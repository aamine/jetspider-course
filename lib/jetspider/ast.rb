require 'jetspider/ast_visitor'
require 'jetspider/ast_dumper'
require 'rkelly/visitable'
require 'rkelly/nodes'

module JetSpider

  class Ast

    def initialize(raw_ast)
      @raw_ast = raw_ast
      @global_functions = nil
      @global_scope = nil
    end

    attr_reader :raw_ast

    def filename
      @raw_ast.filename
    end

    def lineno
      1
    end

    # Semantic AST attributes.
    # These values are set by a Resolver.
    attr_accessor :global_functions
    attr_accessor :global_scope

    def dump
      if @global_functions   # semantic AST
        trees = []
        @global_functions.each do |defun|
          trees.push AstDumper.new(false).accept(defun)
        end
        trees.push AstDumper.new(true).accept(@raw_ast)
        trees
      else
        AstDumper.new(false).accept(@raw_ast)
      end
    end

    def pretty_print
      make_readable_tree(dump).to_yaml.sub(/\A---\n/, '')
    end

    private

    def make_readable_tree(tree)
      case tree
      when Hash
        h = {}
        tree.each do |name, value|
          h[name.to_s] = make_readable_tree(value)
        end
        h
      when Array
        tree.map {|elem| make_readable_tree(elem) }
      when Class
        tree.name.split('::').last
      when String, Numeric
        tree
      when nil
        nil
      when Variable
        tree.description
      else
        raise "[FATAL] unsupported AST value tree: #{tree.inspect}"
      end
    end

  end

  Nodes = RKelly::Nodes

  class Nodes::Node
    def statement?
      false
    end
  end

  class Nodes::VarStatementNode
    def statement?
      true
    end
  end

  class Nodes::ExpressionStatementNode
    def statement?
      true
    end
  end

  class Nodes::EmptyStatementNode
    def statement?
      true
    end
  end

  # var a;
  class Nodes::VarDeclNode   # reopen
    attr_accessor :variable
  end

  # function f(a) { ... }
  class Nodes::ParameterNode   # reopen
    attr_accessor :variable
  end

  # variable reference
  class Nodes::ResolveNode   # reopen
    attr_accessor :variable
  end

  class Nodes::FunctionDeclNode   # reopen
    attr_accessor :scope
    alias name value

    def lineno
      range.from.line
    end
  end

end
