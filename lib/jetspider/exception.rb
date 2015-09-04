module JetSpider
  class ApplicationError < StandardError; end
  class SyntaxError < ApplicationError; end
  class SemanticError < ApplicationError; end
  class ReferenceError < ApplicationError; end
end
