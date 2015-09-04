require 'jetspider/ast_visitor'

module JetSpider
  class AstDumper < AstVisitor
    def initialize(skip_defun = false)
      @skip_defun = skip_defun
    end

    ## Terminal nodes
    %w{
      BreakNode ContinueNode EmptyStatementNode FalseNode
      NullNode NumberNode ParameterNode RegexpNode StringNode
      ThisNode TrueNode
    }.each do |type|
      define_method(:"visit_#{type}") do |n|
        {
          type: n.class,
          value: n.value
        }
      end
    end

    def visit_ResolveNode(n)
      desc = {
        type: n.class,
        value: n.value
      }
      desc[:ref] = n.variable if n.variable
      desc
    end

    # Single value nodes
    %w{
      AssignExprNode BitwiseNotNode BlockNode DeleteNode ElementNode
      ExpressionStatementNode FunctionBodyNode LogicalNotNode ReturnNode
      ThrowNode TypeOfNode UnaryMinusNode UnaryPlusNode VoidNode
    }.each do |type|
      define_method(:"visit_#{type}") do |n|
        {
          type: n.class,
          value: (n.value && n.value.accept(self))
        }
      end
    end

    # Binary nodes
    %w{
      AddNode BitAndNode BitOrNode BitXOrNode CaseClauseNode CommaNode
      DivideNode DoWhileNode EqualNode GreaterNode GreaterOrEqualNode InNode
      InstanceOfNode LeftShiftNode LessNode LessOrEqualNode LogicalAndNode
      LogicalOrNode ModulusNode MultiplyNode NotEqualNode NotStrictEqualNode
      OpAndEqualNode OpDivideEqualNode OpEqualNode OpLShiftEqualNode
      OpMinusEqualNode OpModEqualNode OpMultiplyEqualNode OpOrEqualNode
      OpPlusEqualNode OpRShiftEqualNode OpURShiftEqualNode OpXOrEqualNode
      RightShiftNode StrictEqualNode SubtractNode SwitchNode
      UnsignedRightShiftNode WhileNode WithNode
    }.each do |type|
      define_method(:"visit_#{type}") do |n|
        {
          type: n.class,
          left: (n.left && n.left.accept(self)),
          value: (n.value && n.value.accept(self))
        }
      end
    end

    # Array Value Nodes
    %w{
      ArgumentsNode ArrayNode CaseBlockNode ConstStatementNode
      ObjectLiteralNode SourceElementsNode VarStatementNode
    }.each do |type|
      define_method(:"visit_#{type}") do |node|
        {
          type: node.class,
          value: (node.value && node.value.map {|n| n && n.accept(self) })
        }
      end
    end

    # Name and Value Nodes
    %w{
      LabelNode PropertyNode GetterPropertyNode SetterPropertyNode
    }.each do |type|
      define_method(:"visit_#{type}") do |node|
        {
          type: node.class,
          name: node.name,
          value: (node.value && node.value.accept(self))
        }
      end
    end

    def visit_VarDeclNode(node)
      desc = {
        type: node.class,
        name: node.name,
        value: (node.value && node.value.accept(self))
      }
      desc[:ref] = node.variable if node.variable
      desc
    end

    %w{ PostfixNode PrefixNode }.each do |type|
      define_method(:"visit_#{type}") do |node|
        {
          type: node.class,
          value: node.value,
          operand: (node.operand && node.operand.accept(self))
        }
      end
    end

    def collect_attributes(node, attributes)
      desc = {type: node.class}
      attributes.each do |method|
        n = node.__send__(method)
        desc[method] = (n && n.accept(self))
      end
      desc
    end

    def visit_ForNode(node)
      collect_attributes(node, [:init, :test, :counter, :value])
    end

    %w{ IfNode ConditionalNode }.each do |type|
      define_method(:"visit_#{type}") do |node|
        collect_attributes(node, [:conditions, :value, :else])
      end
    end

    def visit_ForInNode(node)
      collect_attributes(node, [:left, :right, :value])
    end

    def visit_TryNode(node)
      collect_attributes(node, [:value, :catch_block, :finally_block])
    end

    def visit_BracketAccessorNode(node)
      collect_attributes(node, [:value, :accessor])
    end

    %w{ NewExprNode FunctionCallNode }.each do |type|
      define_method(:"visit_#{type}") do |node|
        collect_attributes(node, [:value, :arguments])
      end
    end

    def visit_FunctionExprNode(node)
      {
        type: node.class,
        arguments: node.arguments.map {|n| n && n.accept(self) },
        function_body: (node.function_body && node.function_body.accept(self))
      }
    end

    def visit_FunctionDeclNode(node)
      return nil if @skip_defun
      {
        type: node.class,
        value: node.value,   # name
        arguments: node.arguments.map {|n| n && n.accept(self) },
        function_body: (node.function_body && node.function_body.accept(self))
      }
    end

    def visit_DotAccessorNode(node)
      {
        type: node.class,
        value: (node.value && node.value.accept(self)),
        accessor: node.accessor
      }
    end
  end
end
