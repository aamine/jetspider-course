require 'stringio'
require 'yaml'

module JetSpider

  class ObjectFile

    # jsxdrapi.h
    JSXDR_MAGIC_SCRIPT_BASE = 0xdead0000
    JSXDR_MAGIC_SCRIPT_11 = JSXDR_MAGIC_SCRIPT_BASE + 11
    JSXDR_MAGIC_SCRIPT_CURRENT = JSXDR_MAGIC_SCRIPT_11

    # jsversion.h
    JS_VERSION = 185   # SpiderMonkey 1.8.5 (ECMAScript 5)

    def initialize
      @units = []
    end

    def new_unit(scope, filename, lineno)
      Unit.new(scope, filename, lineno).tap {|unit|
        @units.push unit
      }
    end

    def serialize
      buf = StringIO.new
      serialize_to_stream(buf)
      buf.string
    end

    def write(path)
      File.open(path, 'w') {|f|
        serialize_to_stream(f)
      }
    end

    def serialize_to_stream(stream)
      f = XDRWriter.new(stream)
      f.uint32 JSXDR_MAGIC_SCRIPT_CURRENT
      f.uint32 @units.length
      @units.each do |unit|
        unit.serialize_to_stream(stream)
      end
    end

    def pretty_print
      dump.to_yaml.sub(/\A---\n/, '')
    end

    def dump
      @units.map(&:dump)
    end

    # A compiled toplevel or function
    class Unit
      def initialize(scope, filename, lineno)
        @scope = scope
        @filename = filename
        @lineno = lineno
        @instructions = []
        @lvar_slots = []
        @atom_table = {}
      end

      attr_reader :filename
      attr_reader :lineno

      def toplevel?
        !function?
      end

      def function?
        @scope.function?
      end

      def put(insn)
        @instructions.push insn
      end

      def pretty_print
        dump.to_yaml.sub(/\A---\n/, '')
      end

      def dump
        {
          'n_vars' => @lvar_slots.size,
          'n_args' => arguments.size,
          'vars' => var_names,
          'prolog_length' => prolog_length,
          'js_version' => JS_VERSION,
          'n_fixed' => n_fixed,
          'script_bits' => script_bits,   # FIXME: split to bools
          'code' => @instructions.map(&:dump),
          'srcnotes' => srcnotes,   # FIXME: should be an array
          'filename' => filename,
          'lineno' => lineno,
          'n_slots' => n_slots,
          'static_level' => static_level,
          'atoms' => atoms.map(&:dump),
          'blocks' => blocks.map(&:dump),
          'upvars' => upvars.map(&:dump),
          'regexps' => regexps.map(&:dump),
          'closed_args' => closed_args.map(&:dump),
          'closed_vars' => closed_vars.map(&:dump),
          'trynotes' => trynotes.map(&:dump),
          'consts' => consts.map(&:dump)
        }
      end

      def serialize_to_stream(stream)
        f = XDRWriter.new(stream)
        if @scope.function?
          serialize_JSFunction f
        else
          serialize_JSScript f
        end
      end

      JSFUN_NAMED = 0b0001

      JSFUN_JOINABLE = 0x0001
      JSFUN_PROTOTYPE = 0x0800
      JSFUN_EXPR_CLOSURE = 0x1000
      JSFUN_TRCINFO = 0x2000
      JSFUN_INTERPRETED = 0x4000
      JSFUN_FLAT_CLOSURE = 0x8000
      JSFUN_NULL_CLOSURE = 0xC000
      JSFUN_KINDMASK = 0xC000

      def serialize_JSFunction(f)
        f.uint32 JSFUN_NAMED
        f.atom @scope.function_name
        f.uint16 JSFUN_INTERPRETED | JSFUN_NULL_CLOSURE
        f.uint16 arguments.size
        serialize_JSScript f
      end

      def serialize_JSScript(f)
        f.uint32 JSXDR_MAGIC_SCRIPT_CURRENT
        f.uint16 local_variables.size
        f.uint16 arguments.size
        f.uint16 upvars.size
        f.uint16(padding = 0)
        f.uint32(*vars_bitmap)
        var_names.each do |name|
          f.jsstring name
        end
        code = bytecode()
        f.uint32 code.length
        f.uint32 prolog_length
        f.uint16 JS_VERSION
        f.uint16 n_fixed
        f.uint32 atoms.size
        f.uint32 n_srcnotes
        f.uint32 trynotes.size
        f.uint32 blocks.size   # n_objects
        f.uint32 regexps.size
        f.uint32 consts.size
        f.uint16 closed_vars.size
        f.uint16 closed_args.size
        f.uint32 script_bits
        f.byte_string code
        f.byte_string srcnotes   # ASCII string
        f.cstring_or_null filename
        f.uint32 lineno
        f.uint16 n_slots
        f.uint16 static_level
        f.uint32 0   # no principals exist
        atoms.each do |a|
          f.atom a
        end
        blocks.each do |b|
          if b.block?
            f.uint32 1
            f.block b
          else
            f.uint32 0
            f.function b
          end
        end
        upvars.each do |var|
          f.uint32 var.id
        end
        regexps.each do |re|
          f.regexp_object re
        end
        closed_args.each do |arg|
          f.uint32 arg.id
        end
        closed_vars.each do |var|
          f.uint32 var.id
        end
        trynotes.each do |note|
          f.uint16 note.stack_depth
          f.uint16 note.kind
          f.uint32 note.start
          f.uint32 note.length
        end
        consts.each do |c|
          f.jsval c
        end
      end

      def arguments
        return [] unless function?
        @scope.parameters
      end

      def vars_bitmap
        var_names.map {|name| name ? 1 : 0 }.each_slice(32).map {|bits|
          bytes = [bits.join].pack('b*')
          ("\0" * (4 - bytes.size) + bytes).unpack('N').first
        }
      end

      def var_names
        arguments.map(&:name) + local_variables.map(&:name) + upvars.map(&:name)
      end

      # number of slots in a function stack
      # num lvars ??  const??
      def n_fixed
        local_variables.length
      end

      def n_srcnotes
        0   # FIXME: tmp
      end

      def n_consts
        0   # FIXME
      end

      # script flags
      NO_SCRIPT_RVAL   = 0b00000001
      SAVED_CALLER_FUN = 0b00000010
      HAS_SHARPS       = 0b00000100
      STRICT_MODE_CODE = 0b00001000
      USES_EVAL        = 0b00010000
      USES_ARGUMENTS   = 0b00100000

      def script_bits
        toplevel? ? NO_SCRIPT_RVAL : USES_ARGUMENTS
      end

      def prolog_length
        0   # FIXME
      end

      def bytecode
        buf = ''.force_encoding('binary')
        @instructions.each do |insn|
          buf.concat insn.serialize
        end
        buf.force_encoding('binary')
      end

      def srcnotes
        ''   # FIXME
      end

      # length of scope-local variables area
      def n_slots
        local_variables.length + max_stack_depth
      end

      def local_variables
        @scope.local_variables
      end

      def max_stack_depth
        @max_stack_depth ||= begin
          max = 0
          n = 0
          @instructions.each do |insn|
            n -= insn.n_consume_values
            n += insn.n_produce_values
            max = n if n > max
          end
          max
        end
      end

      def static_level
        # FIXME: inner functions have higher level, but now we have only 1 level function
        function? ? 1 : 0
      end

      def atoms
        @atom_table.keys
      end

      def atomize(name)
        @atom_table[name] ||= @atom_table.size
      end

      # blocks and functions
      def blocks
        []   # FIXME
      end

      def upvars
        []   # FIXME
      end

      def regexps
        []   # FIXME
      end

      def closed_args
        []   # FIXME
      end

      def closed_vars
        []   # FIXME
      end

      def trynotes
        []
      end

      def consts
        []   # FIXME
      end
    end

    # JS-XDR uses little endien
    class XDRWriter
      def initialize(f)
        @f = f
      end

      def uint32(*vals)
        @f.write vals.pack("V#{vals.size}")
      end

      def uint16(*vals)
        @f.write vals.pack("v#{vals.size}")
      end

      # length (32bit) + UTF-16 bytes with 32bit padding
      def jsstring(str)
        uint32 str.length
        byte_string str.encode('UTF-16LE').force_encoding('binary')
      end

      # length (32bit) + ASCII bytes with 32bit padding
      def cstring(str)
        uint32 str.length
        byte_string str
      end

      # same as cstring, but prefixed with null flag (32bit)
      def cstring_or_null(str)
        if str
          uint32 0
          cstring str
        else
          uint32 1
        end
      end

      # 32bit alignment
      ALIGN = 4

      def byte_string(data)
        @f.write data
        if data.length % ALIGN != 0
          @f.write "\0" * (ALIGN - data.bytesize % ALIGN)
        end
      end

      def atom(val)
        jsstring val.to_s
      end
    end

    class Instruction
      def initialize(op, args)
        @op = op
        @args = args
        check_args op, args
      end

      def check_args(op, args)
        argc = op.argc or raise "[FATAL] argc==nil: #{op}"
        unless args.length == argc
          raise ArgumentError, "wrong arg length (#{args.length} for #{argc}): #{op.name}, #{args.inspect}"
        end
      end
      private :check_args

      attr_reader :op
      attr_reader :args

      def inspect
        "#{@op.name} #{args.inspect}"
      end

      def length
        @op.length
      end

      def serialize
        bin = ([ObjectFile.uint8(@op.code)] + args).map {|v| v.serialize }.join('')
        bin.force_encoding('ascii-8bit')
      end

      def dump
        #{
        #  'name' => @op.name,
        #  'args' => @args.map(&:value),
        #  'bytes' => serialize.bytes.map {|b| '%02x' % b }.join(' ')
        #}
        bytes = serialize.bytes.map {|b| '%02x' % b }.join(' ')
        ('%-16s' % bytes) + " #{@op.name} #{args.map(&:value).join(' ')}".strip
      end

      def n_consume_values
        case @op.name
        when 'call', 'new' then return 2 + args[0].value   # receiver, function, arguments
        end
        raise "[FATAL] variadic use not supported: #{inspect}" if @op.use < 0
        @op.use
      end

      def n_produce_values
        raise "[FATAL] variadic def not supported: #{inspect}" if @op.def < 0
        @op.def
      end
    end

    class RelativeJumpInstruction < Instruction
      def initialize(op, self_pc, target_location)
        super op, [nil]
        @self_pc = self_pc
        @target_location = target_location
      end

      def args
        jump_len = @target_location.pc - @self_pc
        [ObjectFile.int16(jump_len)]
      end
    end

    # SpiderMonkey byte code uses big endien for immediates
    class PackedValue
      def PackedValue.parse(binary)
        new(unpack(binary))
      end

      def initialize(value)
        @value = value
      end

      attr_reader :value

      def to_s
        "(#{self.class.name.split('::').last} #{@value})"
      end
    end

    def self.int8(value)
      SignedInt8.new(value)
    end

    class SignedInt8 < PackedValue
      def serialize
        [value].pack('c')
      end

      def SignedInt8.unpack(value)
        # We don't have big endien signed-integer template,
        # use unsigned-integer template and calculate signed value from it.
        n = ("\0" + value).unpack('n').first
        n[7] == 1 ? -((n ^ 0xff) + 1) : n
      end
    end

    def self.int16(value)
      SignedInt16.new(value)
    end

    class SignedInt16 < PackedValue
      def serialize
        # We don't have big endien signed-integer template,
        # use 's' (CPU-dependent endien 16bit signed int) instead.
        # We assume local machine is little endien (Intel).
        [value].pack('s').split(//).reverse.join('')
      end

      def SignedInt16.unpack(value)
        # We don't have big endien signed-integer template,
        # use unsigned-integer template and calculate signed value from it.
        n = value.unpack('n').first
        n[15] == 1 ? -((n ^ 0xffff) + 1) : n
      end
    end

    def self.int32(value)
      SignedInt32.new(value)
    end

    class SignedInt32 < PackedValue
      def serialize
        # We don't have big endien signed-integer template,
        # use 'l' (CPU-dependent endien 32bit signed int) instead.
        # We assume local machine is little endien (Intel).
        [value].pack('l').split(//).reverse.join('')
      end

      def SignedInt32.unpack(value)
        # We don't have big endien signed-integer template,
        # use unsigned-integer template and calculate signed value from it.
        n = value.unpack('N').first
        n[31] == 1 ? -((n ^ 0xffff_ffff) + 1) : n
      end
    end

    def self.uint8(value)
      UnsignedInt8.new(value)
    end

    class UnsignedInt8 < PackedValue
      def serialize
        [value].pack('C')
      end

      def UnsignedInt8.unpack(value)
        value.ord
      end
    end

    def self.uint16(value)
      UnsignedInt16.new(value)
    end

    class UnsignedInt16 < PackedValue
      def serialize
        [value].pack('n')
      end

      def UnsignedInt16.unpack(value)
        value.unpack('n').first
      end
    end

    def self.uint24(value)
      UnsignedInt24.new(value)
    end

    class UnsignedInt24 < PackedValue
      def serialize
        [value].pack('N')[1,3]
      end

      def UnsignedInt24.unpack(value)
        ("\0" + value).unpack('N').first
      end
    end

  end

end
