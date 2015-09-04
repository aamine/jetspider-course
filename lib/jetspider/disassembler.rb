require 'jetspider/op_code'
require 'jetspider/object_file'

module JetSpider

  class Disassembler

    def disassemble_file(jsc_path, out)
      File.open(jsc_path) {|f|
        disassemble_stream f, out
      }
    end

    def disassemble_stream(f, out)
      pos = 0
      while code = f.getbyte
        out.printf '%05d: %02x', pos, code
        op = OpCode.for_code(code) or
            raise ArgumentError, "[FATAL] unknown opcode: #{code.inspect}"
        pos += op.length
        if op.have_no_parameters?
          out.print "\t#{op.name}"
        else
          operand = f.read(op.length - 1)
          operand.each_byte do |b|
            out.printf ' %02x', b
          end
          out.print "\t#{op.name}"
          decode_operand(op, operand).each do |d|
            out.print ' ', d
          end
        end
        out.puts
      end
    end

    def decode_operand(op, data)
      case op.type
      when 'JOF_JUMP' then [ObjectFile::SignedInt16.parse(data)]
      when 'JOF_INT8' then [ObjectFile::SignedInt8.parse(data)]
      when 'JOF_INT32' then [ObjectFile::SignedInt32.parse(data)]
      when 'JOF_UINT8' then [ObjectFile::UnsignedInt8.parse(data)]
      when 'JOF_UINT16' then [ObjectFile::UnsignedInt16.parse(data)]
      when 'JOF_UINT24' then [ObjectFile::UnsignedInt24.parse(data)]
      else
        raise "disassembler not supported opcode: #{op.name} (type: #{op.type}): #{data.inspect}"
      end
    end

  end

end
