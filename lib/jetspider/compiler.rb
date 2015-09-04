require 'jetspider/parser'
require 'jetspider/resolver'
require 'jetspider/code_generator'
require 'jetspider/assembler'
require 'rkelly'
require 'optparse'
require 'yaml'

module JetSpider

  class Compiler

    def Compiler.main
      new.main
    end

    def main
      mode = :compile
      src = nil

      opts = OptionParser.new
      opts.banner = "Usage: #{File.basename($0, '.*')} [options] {JS_FILE | -e SOURCE}"
      opts.on('--dump-tokens', 'Dumps lexical tokens and quit.') {
        mode = :dump_tokens
      }
      opts.on('--dump-ast', 'Dumps AST and quit.') {
        mode = :dump_ast
      }
      opts.on('--dump-semantic', 'Dumps semantic tree and quit.') {
        mode = :dump_sem
      }
      opts.on('--dump-object', 'Dumps object file and quit.') {
        mode = :dump_obj
      }
      opts.on('-e', '--source=TEXT', 'Give source code from option.') {|text|
        src = TextSource.new(text, '(option)')
      }
      opts.on('--help', 'Prints this message and quit.') {
        puts opts.help
        exit 0
      }
      begin
        opts.parse!
      rescue OptionParser::ParseError => ex
        $stderr.puts ex.message
        exit 1
      end
      if src
        error_exit 'too many input file' unless ARGV.empty?
      else
        error_exit 'missing source file' if ARGV.empty?
        error_exit 'too many input file' unless ARGV.size == 1
        src = FileSource.new(ARGV.first)
      end

      if mode == :dump_tokens
        Parser.lex(src).each do |t|
          symbol, word = t.to_racc_token
          text = (/\s/ =~ word.to_s) ? word.to_s.dump : word.to_s
          printf "%s\t%s\n", symbol.to_s, text
        end
        exit 0
      end

      ast = Parser.parse(src)
      if mode == :dump_ast
        puts ast.pretty_print
        exit 0
      end

      Resolver.resolve(ast)
      if mode == :dump_sem
        puts ast.pretty_print
        exit 0
      end

      cgen = CodeGenerator.new(ObjectFile.new)
      obj = cgen.generate_object_file(ast)
      if mode == :dump_obj
        puts obj.pretty_print
        exit 0
      end

      obj.write src.make_output_path('.jsc')
    end

    class TextSource
      def initialize(text, name = '(option)')
        @text = text
        @name = name
      end

      attr_reader :text
      attr_reader :name

      def make_output_path(new_ext)
        "out#{new_ext}"
      end
    end

    class FileSource
      def initialize(path)
        @path = path
      end

      def text
        File.read(@path)
      end

      def name
        @path
      end

      def make_output_path(new_ext)
        File.dirname(@path) + '/' + File.basename(@path, '.js') + new_ext
      end
    end

    def error_exit(msg)
      $stderr.puts "#{File.basename($0, '.*')}: error: #{msg}"
      exit 1
    end

  end

end
