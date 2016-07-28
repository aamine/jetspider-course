require 'jetspider/op_code'
require 'jetspider/object_file'

module JetSpider

  class Assembler
    def initialize(object_unit)
      @object_unit = object_unit
      @pc = 0
    end

    attr_reader :object_unit

    private

    def current_pc
      @pc
    end

    def put(inst)
      @object_unit.put inst
      @pc += inst.length
    end

    def put_insn(name, *args)
      op = OpCode.for_name(name)
      put ObjectFile::Instruction.new(op, args)
    end

    def put_relative_jump(name, target)
      op = OpCode.for_name(name)
      jmp = ObjectFile::RelativeJumpInstruction.new(op, current_pc, target)
      put jmp
    end

    #
    # Location API
    #

    public

    def location
      Location.new(current_pc)
    end

    def lazy_location
      Location.new(nil)
    end

    def fix_location(loc)
      loc.fix current_pc
    end

    class Location
      def initialize(pc)
        @pc = pc
      end

      def pc
        raise "[FATAL] unfixed location used" unless fixed?
        @pc
      end

      def fix(pc)
        raise "[FATAL] location fixiated twice" if @pc
        @pc = pc
      end

      def fixed?
        !!@pc
      end
    end

    #
    # per-Operator interface methods
    #

    public

    # Defines methods for all no-parameter opcodes here.
    OpCode.all.each do |op|
      if op.have_no_parameters?
        define_method(op.name) {
          put_insn op.name
        }
      end
    end

    def int8(num)
      put_insn 'int8', ObjectFile.int8(num)
    end

    def int32(num)
      put_insn 'int32', ObjectFile.int32(num)
    end

    def uint16(num)
      put_insn 'uint16', ObjectFile.uint16(num)
    end

    def uint24(num)
      put_insn 'uint24', ObjectFile.uint24(num)
    end

    def getarg(index)
      put_insn 'getarg', ObjectFile.uint16(index)
    end

    def ifeq(target)
      put_relative_jump 'ifeq', target
    end

    def goto(target)
      put_relative_jump 'goto', target
    end

    def get_atom_id(name)
      ObjectFile.uint16(@object_unit.atomize(name))
    end

    def string(str)
      put_insn 'string', get_atom_id(str)
    end

    def getgname(name)
      put_insn 'getgname', get_atom_id(name)
    end

    def callgname(name)
      put_insn 'callgname', get_atom_id(name)
    end

    def bindgname(name)
      put_insn 'bindgname', get_atom_id(name)
    end

    def setgname(name)
      put_insn 'setgname', get_atom_id(name)
    end

    def call(len)
      put_insn 'call', ObjectFile.uint16(len)
    end

    def setarg(id)
      put_insn 'setarg', ObjectFile.uint16(id)
    end

    def getarg(id)
      put_insn 'getarg', ObjectFile.uint16(id)
    end

    def setlocal(id)
      put_insn 'setlocal', ObjectFile.uint16(id)
    end

    def getlocal(id)
      put_insn 'getlocal', ObjectFile.uint16(id)
    end

    def new(argc)
      put_insn 'new', ObjectFile.uint16(argc)
    end

    def getprop(name)
      put_insn 'getprop', get_atom_id(name)
    end

    def setprop(name)
      put_insn 'setprop', get_atom_id(name)
    end

    def callprop(name)
      put_insn 'callprop', get_atom_id(name)
    end

  end

end
