require 'rkelly/visitors/visitor'

module JetSpider

  class AstVisitor < RKelly::Visitors::Visitor
    private

    def traverse_ast(ast)
      visit(ast.raw_ast)
    end

    def visit(node)
      node.accept(self)
    end
  end

end
