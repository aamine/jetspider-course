require 'jetspider/ast'
require 'jetspider/exception'

module JetSpider

  class Resolver < AstVisitor

    def Resolver.resolve(ast)
      new.resolve(ast)
    end

    def initialize
      @global_scope = @scope = GlobalScope.new
      @global_functions = []
    end

    def resolve(ast)
      traverse_ast ast
      @global_scope.run_scope_close_hooks
      ast.global_functions = @global_functions
      ast.global_scope = @global_scope
    end

    def visit_VarStatementNode(n)
      n.value.each do |var|
        visit var
      end
    end

    def visit_VarDeclNode(n)
      n.variable = @scope.define(n.name)
      # Resolve var references in rhs.
      visit n.value if n.value
    end

    def visit_FunctionDeclNode(n)
      @scope.define n.value
      push_function_scope(n) {|scope|
        n.scope = scope
        n.arguments.each do |a|
          name = a.value
          a.variable = scope.define_parameter(name)
        end
        visit n.function_body
      }
      @global_functions.push n
    end

    def visit_BlockNode(n)
      # We do not support block scope (let expr/stmt).
      visit n.value
    end

    def visit_ResolveNode(n)
      # Delay name resolution until block close because of variable hoisting
      on_scope_close {
        n.variable = resolve_variable(n.value)
      }
    end

    def visit_LabelNode(n)
      raise "LabelNode not implemented"
    end

    private

    def push_function_scope(fun)
      @scope = FunctionScope.new(@scope, fun)
      begin
        yield @scope
        @scope.run_scope_close_hooks
      ensure
        @scope = @scope.up
      end
    end

    def on_scope_close(&block)
      @scope.on_scope_close(&block)
    end

    def resolve_variable(name)
      @scope.get_recursive(name) or raise ReferenceError, "unbound variable: #{name}"
    end

  end

  class Scope
    def initialize(up)
      @up = up
      @lvars = []
      @variables = {}
      @on_scope_close = []
    end

    attr_reader :up

    def global?
      !@up
    end

    def function?
      false
    end

    def block?
      false
    end

    def defined?(name)
      @variable.key?(name)
    end

    def define(name)
      var = @variables[name.to_s]
      return var if var
      @variables[name.to_s] = new_variable(name.to_s)
    end

    def define_parameter(name)
      raise "[FATAL] #{self.class}\#define_parameter is not defined"
    end

    def new_variable(name)
      var = LocalVariable.new(name, self, @lvars.size)
      @lvars.push var
      var
    end
    private :new_variable

    def on_scope_close(&block)
      @on_scope_close.push block
    end

    def run_scope_close_hooks
      @on_scope_close.each do |b|
        b.call
      end
    end

    def get_local(name)
      @variables[name.to_s]
    end

    def get_recursive(name)
      @variables[name.to_s] || (@up && @up.get_recursive(name))
    end
  end

  class FunctionScope < Scope
    def initialize(up, function)
      super up
      @function = function
      @parameters = []
    end

    def function?
      true
    end

    def function_name
      @function.name
    end

    def description
      "[function #{@function.name}]"
    end

    def define_parameter(name)
      param = @variables[name.to_s]
      return param if param
      param = Parameter.new(name, self, @parameters.size)
      @parameters.push param
      @variables[name.to_s] = param
    end

    def parameters
      @parameters.dup
    end

    def local_variables
      @lvars.dup
    end
  end

  class GlobalScope < Scope
    def initialize
      super nil
    end

    # We can refer undeclared global variables.  JavaScript SUCKS
    def get_local(name)
      @variables[name.to_s] || new_variable(name.to_s)
    end

    # We can refer undeclared global variables.  JavaScript SUCKS
    def get_recursive(name)
      @variables[name.to_s] || new_variable(name.to_s)
    end

    def new_variable(name)
      GlobalVariable.new(name, self)
    end

    def description
      "[global]"
    end

    def local_variables
      []
    end
  end

  class Variable
    def initialize(name, scope)
      @name = name
      @scope = scope
    end

    attr_reader :name

    def global?
      @scope.global?
    end

    def local?
      !@scope.global?
    end

    def parameter?
      false
    end

    def description
      "#{@scope.description}:#{@name}"
    end
  end

  class LocalVariable < Variable
    def initialize(name, scope, index)
      super name, scope
      @index = index
    end

    attr_reader :index

    def description
      "#{@scope.description}:local:#{@name}"
    end
  end

  class Parameter < Variable
    def initialize(name, scope, index)
      super name, scope
      @index = index
    end

    attr_reader :index

    def parameter?
      true
    end

    def description
      "#{@scope.description}:param:#{@name}"
    end
  end

  class GlobalVariable < Variable
  end

end

__END__
    def visit_FunctionCallNode(n) raise "FunctionCallNode not implemented"; end
    def visit_ArgumentsNode(n) raise "ArgumentsNode not implemented"; end
    def visit_EmptyStatementNode(n) raise "EmptyStatementNode not implemented"; end
    def visit_ParentheticalNode(n) raise "ParentheticalNode not implemented"; end
    def visit_ExpressionStatementNode(n) raise "ExpressionStatementNode not implemented"; end
    def visit_TrueNode(n) raise "TrueNode not implemented"; end
    def visit_DeleteNode(n) raise "DeleteNode not implemented"; end
    def visit_ReturnNode(n) raise "ReturnNode not implemented"; end
    def visit_TypeOfNode(n) raise "TypeOfNode not implemented"; end
    def visit_SourceElementsNode(n) raise "SourceElementsNode not implemented"; end
    def visit_NumberNode(n) raise "NumberNode not implemented"; end
    def visit_LogicalNotNode(n) raise "LogicalNotNode not implemented"; end
    def visit_AssignExprNode(n) raise "AssignExprNode not implemented"; end
    def visit_FunctionBodyNode(n) raise "FunctionBodyNode not implemented"; end
    def visit_ObjectLiteralNode(n) raise "ObjectLiteralNode not implemented"; end
    def visit_UnaryMinusNode(n) raise "UnaryMinusNode not implemented"; end
    def visit_ThrowNode(n) raise "ThrowNode not implemented"; end
    def visit_ThisNode(n) raise "ThisNode not implemented"; end
    def visit_BitwiseNotNode(n) raise "BitwiseNotNode not implemented"; end
    def visit_ParameterNode(n) raise "ParameterNode not implemented"; end
    def visit_FalseNode(n) raise "FalseNode not implemented"; end
    def visit_AttrNode(n) raise "AttrNode not implemented"; end
    def visit_ContinueNode(n) raise "ContinueNode not implemented"; end
    def visit_ConstStatementNode(n) raise "ConstStatementNode not implemented"; end
    def visit_UnaryPlusNode(n) raise "UnaryPlusNode not implemented"; end
    def visit_FunctionExprNode(n) raise "FunctionExprNode not implemented"; end
    def visit_BinaryNode(n) raise "BinaryNode not implemented"; end
    def visit_SubtractNode(n) raise "SubtractNode not implemented"; end
    def visit_LessOrEqualNode(n) raise "LessOrEqualNode not implemented"; end
    def visit_GreaterOrEqualNode(n) raise "GreaterOrEqualNode not implemented"; end
    def visit_AddNode(n) raise "AddNode not implemented"; end
    def visit_MultiplyNode(n) raise "MultiplyNode not implemented"; end
    def visit_NotEqualNode(n) raise "NotEqualNode not implemented"; end
    def visit_DoWhileNode(n) raise "DoWhileNode not implemented"; end
    def visit_SwitchNode(n) raise "SwitchNode not implemented"; end
    def visit_LogicalAndNode(n) raise "LogicalAndNode not implemented"; end
    def visit_UnsignedRightShiftNode(n) raise "UnsignedRightShiftNode not implemented"; end
    def visit_ModulusNode(n) raise "ModulusNode not implemented"; end
    def visit_WhileNode(n) raise "WhileNode not implemented"; end
    def visit_NotStrictEqualNode(n) raise "NotStrictEqualNode not implemented"; end
    def visit_LessNode(n) raise "LessNode not implemented"; end
    def visit_WithNode(n) raise "WithNode not implemented"; end
    def visit_InNode(n) raise "InNode not implemented"; end
    def visit_GreaterNode(n) raise "GreaterNode not implemented"; end
    def visit_BitOrNode(n) raise "BitOrNode not implemented"; end
    def visit_StrictEqualNode(n) raise "StrictEqualNode not implemented"; end
    def visit_LogicalOrNode(n) raise "LogicalOrNode not implemented"; end
    def visit_BitXOrNode(n) raise "BitXOrNode not implemented"; end
    def visit_LeftShiftNode(n) raise "LeftShiftNode not implemented"; end
    def visit_EqualNode(n) raise "EqualNode not implemented"; end
    def visit_BitAndNode(n) raise "BitAndNode not implemented"; end
    def visit_InstanceOfNode(n) raise "InstanceOfNode not implemented"; end
    def visit_DivideNode(n) raise "DivideNode not implemented"; end
    def visit_RightShiftNode(n) raise "RightShiftNode not implemented"; end
    def visit_BracketAccessorNode(n) raise "BracketAccessorNode not implemented"; end
    def visit_CaseClauseNode(n) raise "CaseClauseNode not implemented"; end
    def visit_CommaNode(n) raise "CommaNode not implemented"; end
    def visit_IfNode(n) raise "IfNode not implemented"; end
    def visit_ConditionalNode(n) raise "ConditionalNode not implemented"; end
    def visit_DotAccessorNode(n) raise "DotAccessorNode not implemented"; end
    def visit_ForInNode(n) raise "ForInNode not implemented"; end
    def visit_ForNode(n) raise "ForNode not implemented"; end
    def visit_NewExprNode(n) raise "NewExprNode not implemented"; end
    def visit_PostfixNode(n) raise "PostfixNode not implemented"; end
    def visit_PrefixNode(n) raise "PrefixNode not implemented"; end
    def visit_PropertyNode(n) raise "PropertyNode not implemented"; end
    def visit_GetterPropertyNode(n) raise "GetterPropertyNode not implemented"; end
    def visit_SetterPropertyNode(n) raise "SetterPropertyNode not implemented"; end
    def visit_ElementNode(n) raise "ElementNode not implemented"; end
    def visit_StringNode(n) raise "StringNode not implemented"; end
    def visit_ArrayNode(n) raise "ArrayNode not implemented"; end
    def visit_CaseBlockNode(n) raise "CaseBlockNode not implemented"; end
    def visit_NullNode(n) raise "NullNode not implemented"; end
    def visit_BreakNode(n) raise "BreakNode not implemented"; end
    def visit_VoidNode(n) raise "VoidNode not implemented"; end
    def visit_RegexpNode(n) raise "RegexpNode not implemented"; end
    def visit_TryNode(n) raise "TryNode not implemented"; end
    def visit_OpEqualNode(n) raise "OpEqualNode not implemented"; end
    def visit_OpMultiplyEqualNode(n) raise "OpMultiplyEqualNode not implemented"; end
    def visit_OpDivideEqualNode(n) raise "OpDivideEqualNode not implemented"; end
    def visit_OpLShiftEqualNode(n) raise "OpLShiftEqualNode not implemented"; end
    def visit_OpMinusEqualNode(n) raise "OpMinusEqualNode not implemented"; end
    def visit_OpPlusEqualNode(n) raise "OpPlusEqualNode not implemented"; end
    def visit_OpModEqualNode(n) raise "OpModEqualNode not implemented"; end
    def visit_OpXOrEqualNode(n) raise "OpXOrEqualNode not implemented"; end
    def visit_OpRShiftEqualNode(n) raise "OpRShiftEqualNode not implemented"; end
    def visit_OpAndEqualNode(n) raise "OpAndEqualNode not implemented"; end
    def visit_OpURShiftEqualNode(n) raise "OpURShiftEqualNode not implemented"; end
    def visit_OpOrEqualNode(n) raise "OpOrEqualNode not implemented"; end
