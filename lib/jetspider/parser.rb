require 'jetspider/ast'
require 'rkelly/parser'
require 'rkelly/tokenizer'

module JetSpider
  class Parser
    def Parser.parse(src)
      new.parse(src)
    end

    def parse(src)
      Ast.new(RKelly::Parser.new.parse(src.text, src.name))
    end

    def Parser.lex(src)
      new.lex(src)
    end

    def lex(src)
      RKelly::Tokenizer.new.raw_tokens(src.text)
    end
  end
end
