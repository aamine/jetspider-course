# Generated from jsopcode.tbl

module JetSpider
  OpCode = Struct.new(:op, :code, :name, :image, :length, :use, :def, :precedance, :formats)

ops = []
ops.push OpCode.new(* ["JSOP_NOP", 0, "nop", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_PUSH", 1, "push", nil, 1, 0, 1, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_POPV", 2, "popv", nil, 1, 1, 0, 2, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_ENTERWITH", 3, "enterwith", nil, 1, 1, 1, 0, ["JOF_BYTE", "JOF_PARENHEAD"]])
ops.push OpCode.new(* ["JSOP_LEAVEWITH", 4, "leavewith", nil, 1, 1, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_RETURN", 5, "return", nil, 1, 1, 0, 2, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_GOTO", 6, "goto", nil, 3, 0, 0, 0, ["JOF_JUMP"]])
ops.push OpCode.new(* ["JSOP_IFEQ", 7, "ifeq", nil, 3, 1, 0, 4, ["JOF_JUMP", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_IFNE", 8, "ifne", nil, 3, 1, 0, 0, ["JOF_JUMP", "JOF_PARENHEAD"]])
ops.push OpCode.new(* ["JSOP_ARGUMENTS", 9, "arguments", "arguments", 1, 0, 1, 18, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_FORARG", 10, "forarg", nil, 3, 1, 1, 19, ["JOF_QARG", "JOF_NAME", "JOF_FOR", "JOF_TMPSLOT"]])
ops.push OpCode.new(* ["JSOP_FORLOCAL", 11, "forlocal", nil, 3, 1, 1, 19, ["JOF_LOCAL", "JOF_NAME", "JOF_FOR", "JOF_TMPSLOT"]])
ops.push OpCode.new(* ["JSOP_DUP", 12, "dup", nil, 1, 1, 2, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_DUP2", 13, "dup2", nil, 1, 2, 4, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_SETCONST", 14, "setconst", nil, 3, 1, 1, 3, ["JOF_ATOM", "JOF_NAME", "JOF_SET"]])
ops.push OpCode.new(* ["JSOP_BITOR", 15, "bitor", "\"|\"", 1, 2, 1, 7, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_BITXOR", 16, "bitxor", "\"^\"", 1, 2, 1, 8, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_BITAND", 17, "bitand", "\"&\"", 1, 2, 1, 9, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_EQ", 18, "eq", "\"==\"", 1, 2, 1, 10, ["JOF_BYTE", "JOF_LEFTASSOC", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_NE", 19, "ne", "\"!=\"", 1, 2, 1, 10, ["JOF_BYTE", "JOF_LEFTASSOC", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_LT", 20, "lt", "\"<\"", 1, 2, 1, 11, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_LE", 21, "le", "\"<=\"", 1, 2, 1, 11, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_GT", 22, "gt", "\">\"", 1, 2, 1, 11, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_GE", 23, "ge", "\">=\"", 1, 2, 1, 11, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_LSH", 24, "lsh", "\"<<\"", 1, 2, 1, 12, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_RSH", 25, "rsh", "\">>\"", 1, 2, 1, 12, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_URSH", 26, "ursh", "\">>>\"", 1, 2, 1, 12, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_ADD", 27, "add", "\"+\"", 1, 2, 1, 13, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_SUB", 28, "sub", "\"-\"", 1, 2, 1, 13, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_MUL", 29, "mul", "\"*\"", 1, 2, 1, 14, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_DIV", 30, "div", "\"/\"", 1, 2, 1, 14, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_MOD", 31, "mod", "\"%\"", 1, 2, 1, 14, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_NOT", 32, "not", "\"!\"", 1, 1, 1, 15, ["JOF_BYTE", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_BITNOT", 33, "bitnot", "\"~\"", 1, 1, 1, 15, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_NEG", 34, "neg", "\"- \"", 1, 1, 1, 15, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_POS", 35, "pos", "\"+ \"", 1, 1, 1, 15, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_DELNAME", 36, "delname", nil, 3, 0, 1, 15, ["JOF_ATOM", "JOF_NAME", "JOF_DEL"]])
ops.push OpCode.new(* ["JSOP_DELPROP", 37, "delprop", nil, 3, 1, 1, 15, ["JOF_ATOM", "JOF_PROP", "JOF_DEL"]])
ops.push OpCode.new(* ["JSOP_DELELEM", 38, "delelem", nil, 1, 2, 1, 15, ["JOF_BYTE", "JOF_ELEM", "JOF_DEL"]])
ops.push OpCode.new(* ["JSOP_TYPEOF", 39, "typeof", nil, 1, 1, 1, 15, ["JOF_BYTE", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_VOID", 40, "void", nil, 1, 1, 1, 15, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_INCNAME", 41, "incname", nil, 3, 0, 1, 15, ["JOF_ATOM", "JOF_NAME", "JOF_INC", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_INCPROP", 42, "incprop", nil, 3, 1, 1, 15, ["JOF_ATOM", "JOF_PROP", "JOF_INC", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_INCELEM", 43, "incelem", nil, 1, 2, 1, 15, ["JOF_BYTE", "JOF_ELEM", "JOF_INC", "JOF_TMPSLOT2"]])
ops.push OpCode.new(* ["JSOP_DECNAME", 44, "decname", nil, 3, 0, 1, 15, ["JOF_ATOM", "JOF_NAME", "JOF_DEC", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_DECPROP", 45, "decprop", nil, 3, 1, 1, 15, ["JOF_ATOM", "JOF_PROP", "JOF_DEC", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_DECELEM", 46, "decelem", nil, 1, 2, 1, 15, ["JOF_BYTE", "JOF_ELEM", "JOF_DEC", "JOF_TMPSLOT2"]])
ops.push OpCode.new(* ["JSOP_NAMEINC", 47, "nameinc", nil, 3, 0, 1, 15, ["JOF_ATOM", "JOF_NAME", "JOF_INC", "JOF_POST", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_PROPINC", 48, "propinc", nil, 3, 1, 1, 15, ["JOF_ATOM", "JOF_PROP", "JOF_INC", "JOF_POST", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_ELEMINC", 49, "eleminc", nil, 1, 2, 1, 15, ["JOF_BYTE", "JOF_ELEM", "JOF_INC", "JOF_POST", "JOF_TMPSLOT2"]])
ops.push OpCode.new(* ["JSOP_NAMEDEC", 50, "namedec", nil, 3, 0, 1, 15, ["JOF_ATOM", "JOF_NAME", "JOF_DEC", "JOF_POST", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_PROPDEC", 51, "propdec", nil, 3, 1, 1, 15, ["JOF_ATOM", "JOF_PROP", "JOF_DEC", "JOF_POST", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_ELEMDEC", 52, "elemdec", nil, 1, 2, 1, 15, ["JOF_BYTE", "JOF_ELEM", "JOF_DEC", "JOF_POST", "JOF_TMPSLOT2"]])
ops.push OpCode.new(* ["JSOP_GETPROP", 53, "getprop", nil, 3, 1, 1, 18, ["JOF_ATOM", "JOF_PROP"]])
ops.push OpCode.new(* ["JSOP_SETPROP", 54, "setprop", nil, 3, 2, 1, 3, ["JOF_ATOM", "JOF_PROP", "JOF_SET", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_GETELEM", 55, "getelem", nil, 1, 2, 1, 18, ["JOF_BYTE", "JOF_ELEM", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_SETELEM", 56, "setelem", nil, 1, 3, 1, 3, ["JOF_BYTE", "JOF_ELEM", "JOF_SET", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_CALLNAME", 57, "callname", nil, 3, 0, 2, 19, ["JOF_ATOM", "JOF_NAME", "JOF_CALLOP"]])
ops.push OpCode.new(* ["JSOP_CALL", 58, "call", nil, 3, -1, 1, 18, ["JOF_UINT16", "JOF_INVOKE"]])
ops.push OpCode.new(* ["JSOP_NAME", 59, "name", nil, 3, 0, 1, 19, ["JOF_ATOM", "JOF_NAME"]])
ops.push OpCode.new(* ["JSOP_DOUBLE", 60, "double", nil, 3, 0, 1, 16, ["JOF_ATOM"]])
ops.push OpCode.new(* ["JSOP_STRING", 61, "string", nil, 3, 0, 1, 19, ["JOF_ATOM"]])
ops.push OpCode.new(* ["JSOP_ZERO", 62, "zero", "\"0\"", 1, 0, 1, 16, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_ONE", 63, "one", "\"1\"", 1, 0, 1, 16, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_NULL", 64, "null", "null", 1, 0, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_THIS", 65, "this", "this", 1, 0, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_FALSE", 66, "false", "false", 1, 0, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_TRUE", 67, "true", "true", 1, 0, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_OR", 68, "or", nil, 3, 1, 0, 5, ["JOF_JUMP", "JOF_DETECTING", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_AND", 69, "and", nil, 3, 1, 0, 6, ["JOF_JUMP", "JOF_DETECTING", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_TABLESWITCH", 70, "tableswitch", nil, -1, 1, 0, 0, ["JOF_TABLESWITCH", "JOF_DETECTING", "JOF_PARENHEAD"]])
ops.push OpCode.new(* ["JSOP_LOOKUPSWITCH", 71, "lookupswitch", nil, -1, 1, 0, 0, ["JOF_LOOKUPSWITCH", "JOF_DETECTING", "JOF_PARENHEAD"]])
ops.push OpCode.new(* ["JSOP_STRICTEQ", 72, "stricteq", "\"===\"", 1, 2, 1, 10, ["JOF_BYTE", "JOF_DETECTING", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_STRICTNE", 73, "strictne", "\"!==\"", 1, 2, 1, 10, ["JOF_BYTE", "JOF_DETECTING", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_SETCALL", 74, "setcall", nil, 1, 1, 2, 18, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_ITER", 75, "iter", nil, 2, 1, 1, 0, ["JOF_UINT8"]])
ops.push OpCode.new(* ["JSOP_MOREITER", 76, "moreiter", nil, 1, 1, 2, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_ENDITER", 77, "enditer", nil, 1, 1, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_FUNAPPLY", 78, "funapply", nil, 3, -1, 1, 18, ["JOF_UINT16", "JOF_INVOKE"]])
ops.push OpCode.new(* ["JSOP_SWAP", 79, "swap", nil, 1, 2, 2, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_OBJECT", 80, "object", nil, 3, 0, 1, 19, ["JOF_OBJECT"]])
ops.push OpCode.new(* ["JSOP_POP", 81, "pop", nil, 1, 1, 0, 2, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_NEW", 82, "new", nil, 3, -1, 1, 17, ["JOF_UINT16", "JOF_INVOKE"]])
ops.push OpCode.new(* ["JSOP_TRAP", 83, "trap", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_GETARG", 84, "getarg", nil, 3, 0, 1, 19, ["JOF_QARG", "JOF_NAME"]])
ops.push OpCode.new(* ["JSOP_SETARG", 85, "setarg", nil, 3, 1, 1, 3, ["JOF_QARG", "JOF_NAME", "JOF_SET"]])
ops.push OpCode.new(* ["JSOP_GETLOCAL", 86, "getlocal", nil, 3, 0, 1, 19, ["JOF_LOCAL", "JOF_NAME"]])
ops.push OpCode.new(* ["JSOP_SETLOCAL", 87, "setlocal", nil, 3, 1, 1, 3, ["JOF_LOCAL", "JOF_NAME", "JOF_SET", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_UINT16", 88, "uint16", nil, 3, 0, 1, 16, ["JOF_UINT16"]])
ops.push OpCode.new(* ["JSOP_NEWINIT", 89, "newinit", nil, 3, 0, 1, 19, ["JOF_UINT8"]])
ops.push OpCode.new(* ["JSOP_NEWARRAY", 90, "newarray", nil, 4, 0, 1, 19, ["JOF_UINT24"]])
ops.push OpCode.new(* ["JSOP_NEWOBJECT", 91, "newobject", nil, 3, 0, 1, 19, ["JOF_OBJECT"]])
ops.push OpCode.new(* ["JSOP_ENDINIT", 92, "endinit", nil, 1, 0, 0, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_INITPROP", 93, "initprop", nil, 3, 2, 1, 3, ["JOF_ATOM", "JOF_PROP", "JOF_SET", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_INITELEM", 94, "initelem", nil, 1, 3, 1, 3, ["JOF_BYTE", "JOF_ELEM", "JOF_SET", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_DEFSHARP", 95, "defsharp", nil, 5, 0, 0, 0, ["JOF_UINT16PAIR", "JOF_SHARPSLOT"]])
ops.push OpCode.new(* ["JSOP_USESHARP", 96, "usesharp", nil, 5, 0, 1, 0, ["JOF_UINT16PAIR", "JOF_SHARPSLOT"]])
ops.push OpCode.new(* ["JSOP_INCARG", 97, "incarg", nil, 3, 0, 1, 15, ["JOF_QARG", "JOF_NAME", "JOF_INC", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_DECARG", 98, "decarg", nil, 3, 0, 1, 15, ["JOF_QARG", "JOF_NAME", "JOF_DEC", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_ARGINC", 99, "arginc", nil, 3, 0, 1, 15, ["JOF_QARG", "JOF_NAME", "JOF_INC", "JOF_POST", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_ARGDEC", 100, "argdec", nil, 3, 0, 1, 15, ["JOF_QARG", "JOF_NAME", "JOF_DEC", "JOF_POST", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_INCLOCAL", 101, "inclocal", nil, 3, 0, 1, 15, ["JOF_LOCAL", "JOF_NAME", "JOF_INC", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_DECLOCAL", 102, "declocal", nil, 3, 0, 1, 15, ["JOF_LOCAL", "JOF_NAME", "JOF_DEC", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_LOCALINC", 103, "localinc", nil, 3, 0, 1, 15, ["JOF_LOCAL", "JOF_NAME", "JOF_INC", "JOF_POST", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_LOCALDEC", 104, "localdec", nil, 3, 0, 1, 15, ["JOF_LOCAL", "JOF_NAME", "JOF_DEC", "JOF_POST", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_IMACOP", 105, "imacop", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_FORNAME", 106, "forname", nil, 3, 1, 1, 19, ["JOF_ATOM", "JOF_NAME", "JOF_FOR", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_FORPROP", 107, "forprop", nil, 3, 2, 1, 18, ["JOF_ATOM", "JOF_PROP", "JOF_FOR", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_FORELEM", 108, "forelem", nil, 1, 1, 2, 18, ["JOF_BYTE", "JOF_ELEM", "JOF_FOR"]])
ops.push OpCode.new(* ["JSOP_POPN", 109, "popn", nil, 3, -1, 0, 0, ["JOF_UINT16"]])
ops.push OpCode.new(* ["JSOP_BINDNAME", 110, "bindname", nil, 3, 0, 1, 0, ["JOF_ATOM", "JOF_NAME", "JOF_SET"]])
ops.push OpCode.new(* ["JSOP_SETNAME", 111, "setname", nil, 3, 2, 1, 3, ["JOF_ATOM", "JOF_NAME", "JOF_SET", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_THROW", 112, "throw", nil, 1, 1, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_IN", 113, "in", "in", 1, 2, 1, 11, ["JOF_BYTE", "JOF_LEFTASSOC"]])
ops.push OpCode.new(* ["JSOP_INSTANCEOF", 114, "instanceof", "instanceof", 1, 2, 1, 11, ["JOF_BYTE", "JOF_LEFTASSOC", "JOF_TMPSLOT"]])
ops.push OpCode.new(* ["JSOP_DEBUGGER", 115, "debugger", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_GOSUB", 116, "gosub", nil, 3, 0, 0, 0, ["JOF_JUMP"]])
ops.push OpCode.new(* ["JSOP_RETSUB", 117, "retsub", nil, 1, 2, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_EXCEPTION", 118, "exception", nil, 1, 0, 1, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_LINENO", 119, "lineno", nil, 3, 0, 0, 0, ["JOF_UINT16"]])
ops.push OpCode.new(* ["JSOP_CONDSWITCH", 120, "condswitch", nil, 1, 0, 0, 0, ["JOF_BYTE", "JOF_PARENHEAD"]])
ops.push OpCode.new(* ["JSOP_CASE", 121, "case", nil, 3, 2, 1, 0, ["JOF_JUMP"]])
ops.push OpCode.new(* ["JSOP_DEFAULT", 122, "default", nil, 3, 1, 0, 0, ["JOF_JUMP"]])
ops.push OpCode.new(* ["JSOP_EVAL", 123, "eval", nil, 3, -1, 1, 18, ["JOF_UINT16", "JOF_INVOKE"]])
ops.push OpCode.new(* ["JSOP_ENUMELEM", 124, "enumelem", nil, 1, 3, 0, 3, ["JOF_BYTE", "JOF_SET", "JOF_TMPSLOT"]])
ops.push OpCode.new(* ["JSOP_GETTER", 125, "getter", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_SETTER", 126, "setter", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_DEFFUN", 127, "deffun", nil, 3, 0, 0, 0, ["JOF_OBJECT", "JOF_DECLARING"]])
ops.push OpCode.new(* ["JSOP_DEFCONST", 128, "defconst", nil, 3, 0, 0, 0, ["JOF_ATOM", "JOF_DECLARING"]])
ops.push OpCode.new(* ["JSOP_DEFVAR", 129, "defvar", nil, 3, 0, 0, 0, ["JOF_ATOM", "JOF_DECLARING"]])
ops.push OpCode.new(* ["JSOP_LAMBDA", 130, "lambda", nil, 3, 0, 1, 19, ["JOF_OBJECT"]])
ops.push OpCode.new(* ["JSOP_CALLEE", 131, "callee", nil, 1, 0, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_SETLOCALPOP", 132, "setlocalpop", nil, 3, 1, 0, 3, ["JOF_LOCAL", "JOF_NAME", "JOF_SET"]])
ops.push OpCode.new(* ["JSOP_PICK", 133, "pick", nil, 2, 0, 0, 0, ["JOF_UINT8"]])
ops.push OpCode.new(* ["JSOP_TRY", 134, "try", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_FINALLY", 135, "finally", nil, 1, 0, 2, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_GETFCSLOT", 136, "getfcslot", nil, 3, 0, 1, 19, ["JOF_UINT16", "JOF_NAME"]])
ops.push OpCode.new(* ["JSOP_CALLFCSLOT", 137, "callfcslot", nil, 3, 0, 2, 19, ["JOF_UINT16", "JOF_NAME", "JOF_CALLOP"]])
ops.push OpCode.new(* ["JSOP_ARGSUB", 138, "argsub", nil, 3, 0, 1, 18, ["JOF_QARG", "JOF_NAME"]])
ops.push OpCode.new(* ["JSOP_ARGCNT", 139, "argcnt", nil, 1, 0, 1, 18, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_DEFLOCALFUN", 140, "deflocalfun", nil, 5, 0, 0, 0, ["JOF_SLOTOBJECT", "JOF_DECLARING", "JOF_TMPSLOT"]])
ops.push OpCode.new(* ["JSOP_GOTOX", 141, "gotox", nil, 5, 0, 0, 0, ["JOF_JUMPX"]])
ops.push OpCode.new(* ["JSOP_IFEQX", 142, "ifeqx", nil, 5, 1, 0, 4, ["JOF_JUMPX", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_IFNEX", 143, "ifnex", nil, 5, 1, 0, 0, ["JOF_JUMPX", "JOF_PARENHEAD"]])
ops.push OpCode.new(* ["JSOP_ORX", 144, "orx", nil, 5, 1, 0, 5, ["JOF_JUMPX", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_ANDX", 145, "andx", nil, 5, 1, 0, 6, ["JOF_JUMPX", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_GOSUBX", 146, "gosubx", nil, 5, 0, 0, 0, ["JOF_JUMPX"]])
ops.push OpCode.new(* ["JSOP_CASEX", 147, "casex", nil, 5, 2, 1, 0, ["JOF_JUMPX"]])
ops.push OpCode.new(* ["JSOP_DEFAULTX", 148, "defaultx", nil, 5, 1, 0, 0, ["JOF_JUMPX"]])
ops.push OpCode.new(* ["JSOP_TABLESWITCHX", 149, "tableswitchx", nil, -1, 1, 0, 0, ["JOF_TABLESWITCHX", "JOF_DETECTING", "JOF_PARENHEAD"]])
ops.push OpCode.new(* ["JSOP_LOOKUPSWITCHX", 150, "lookupswitchx", nil, -1, 1, 0, 0, ["JOF_LOOKUPSWITCHX", "JOF_DETECTING", "JOF_PARENHEAD"]])
ops.push OpCode.new(* ["JSOP_BACKPATCH", 151, "backpatch", nil, 3, 0, 0, 0, ["JOF_JUMP", "JOF_BACKPATCH"]])
ops.push OpCode.new(* ["JSOP_BACKPATCH_POP", 152, "backpatch_pop", nil, 3, 1, 0, 0, ["JOF_JUMP", "JOF_BACKPATCH"]])
ops.push OpCode.new(* ["JSOP_THROWING", 153, "throwing", nil, 1, 1, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_SETRVAL", 154, "setrval", nil, 1, 1, 0, 2, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_RETRVAL", 155, "retrval", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_GETGNAME", 156, "getgname", nil, 3, 0, 1, 19, ["JOF_ATOM", "JOF_NAME", "JOF_GNAME"]])
ops.push OpCode.new(* ["JSOP_SETGNAME", 157, "setgname", nil, 3, 2, 1, 3, ["JOF_ATOM", "JOF_NAME", "JOF_SET", "JOF_DETECTING", "JOF_GNAME"]])
ops.push OpCode.new(* ["JSOP_INCGNAME", 158, "incgname", nil, 3, 0, 1, 15, ["JOF_ATOM", "JOF_NAME", "JOF_INC", "JOF_TMPSLOT3", "JOF_GNAME"]])
ops.push OpCode.new(* ["JSOP_DECGNAME", 159, "decgname", nil, 3, 0, 1, 15, ["JOF_ATOM", "JOF_NAME", "JOF_DEC", "JOF_TMPSLOT3", "JOF_GNAME"]])
ops.push OpCode.new(* ["JSOP_GNAMEINC", 160, "gnameinc", nil, 3, 0, 1, 15, ["JOF_ATOM", "JOF_NAME", "JOF_INC", "JOF_POST", "JOF_TMPSLOT3", "JOF_GNAME"]])
ops.push OpCode.new(* ["JSOP_GNAMEDEC", 161, "gnamedec", nil, 3, 0, 1, 15, ["JOF_ATOM", "JOF_NAME", "JOF_DEC", "JOF_POST", "JOF_TMPSLOT3", "JOF_GNAME"]])
ops.push OpCode.new(* ["JSOP_REGEXP", 162, "regexp", nil, 3, 0, 1, 19, ["JOF_REGEXP"]])
ops.push OpCode.new(* ["JSOP_DEFXMLNS", 163, "defxmlns", nil, 1, 1, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_ANYNAME", 164, "anyname", nil, 1, 0, 1, 19, ["JOF_BYTE", "JOF_XMLNAME"]])
ops.push OpCode.new(* ["JSOP_QNAMEPART", 165, "qnamepart", nil, 3, 0, 1, 19, ["JOF_ATOM", "JOF_XMLNAME"]])
ops.push OpCode.new(* ["JSOP_QNAMECONST", 166, "qnameconst", nil, 3, 1, 1, 19, ["JOF_ATOM", "JOF_XMLNAME"]])
ops.push OpCode.new(* ["JSOP_QNAME", 167, "qname", nil, 1, 2, 1, 0, ["JOF_BYTE", "JOF_XMLNAME"]])
ops.push OpCode.new(* ["JSOP_TOATTRNAME", 168, "toattrname", nil, 1, 1, 1, 19, ["JOF_BYTE", "JOF_XMLNAME"]])
ops.push OpCode.new(* ["JSOP_TOATTRVAL", 169, "toattrval", nil, 1, 1, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_ADDATTRNAME", 170, "addattrname", nil, 1, 2, 1, 13, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_ADDATTRVAL", 171, "addattrval", nil, 1, 2, 1, 13, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_BINDXMLNAME", 172, "bindxmlname", nil, 1, 1, 2, 3, ["JOF_BYTE", "JOF_SET"]])
ops.push OpCode.new(* ["JSOP_SETXMLNAME", 173, "setxmlname", nil, 1, 3, 1, 3, ["JOF_BYTE", "JOF_SET", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_XMLNAME", 174, "xmlname", nil, 1, 1, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_DESCENDANTS", 175, "descendants", nil, 1, 2, 1, 18, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_FILTER", 176, "filter", nil, 3, 1, 1, 0, ["JOF_JUMP"]])
ops.push OpCode.new(* ["JSOP_ENDFILTER", 177, "endfilter", nil, 3, 2, 1, 18, ["JOF_JUMP"]])
ops.push OpCode.new(* ["JSOP_TOXML", 178, "toxml", nil, 1, 1, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_TOXMLLIST", 179, "toxmllist", nil, 1, 1, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_XMLTAGEXPR", 180, "xmltagexpr", nil, 1, 1, 1, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_XMLELTEXPR", 181, "xmleltexpr", nil, 1, 1, 1, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_NOTRACE", 182, "notrace", nil, 3, 0, 0, 0, ["JOF_UINT16"]])
ops.push OpCode.new(* ["JSOP_XMLCDATA", 183, "xmlcdata", nil, 3, 0, 1, 19, ["JOF_ATOM"]])
ops.push OpCode.new(* ["JSOP_XMLCOMMENT", 184, "xmlcomment", nil, 3, 0, 1, 19, ["JOF_ATOM"]])
ops.push OpCode.new(* ["JSOP_XMLPI", 185, "xmlpi", nil, 3, 1, 1, 19, ["JOF_ATOM"]])
ops.push OpCode.new(* ["JSOP_DELDESC", 186, "deldesc", nil, 1, 2, 1, 15, ["JOF_BYTE", "JOF_ELEM", "JOF_DEL"]])
ops.push OpCode.new(* ["JSOP_CALLPROP", 187, "callprop", nil, 3, 1, 2, 18, ["JOF_ATOM", "JOF_PROP", "JOF_CALLOP", "JOF_TMPSLOT3"]])
ops.push OpCode.new(* ["JSOP_BLOCKCHAIN", 188, "blockchain", nil, 3, 0, 0, 0, ["JOF_OBJECT"]])
ops.push OpCode.new(* ["JSOP_NULLBLOCKCHAIN", 189, "nullblockchain", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_UINT24", 190, "uint24", nil, 4, 0, 1, 16, ["JOF_UINT24"]])
ops.push OpCode.new(* ["JSOP_INDEXBASE", 191, "indexbase", nil, 2, 0, 0, 0, ["JOF_UINT8", "JOF_INDEXBASE"]])
ops.push OpCode.new(* ["JSOP_RESETBASE", 192, "resetbase", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_RESETBASE0", 193, "resetbase0", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_STARTXML", 194, "startxml", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_STARTXMLEXPR", 195, "startxmlexpr", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_CALLELEM", 196, "callelem", nil, 1, 2, 2, 18, ["JOF_BYTE", "JOF_ELEM", "JOF_LEFTASSOC", "JOF_CALLOP"]])
ops.push OpCode.new(* ["JSOP_STOP", 197, "stop", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_GETXPROP", 198, "getxprop", nil, 3, 1, 1, 18, ["JOF_ATOM", "JOF_PROP"]])
ops.push OpCode.new(* ["JSOP_CALLXMLNAME", 199, "callxmlname", nil, 1, 1, 2, 19, ["JOF_BYTE", "JOF_CALLOP"]])
ops.push OpCode.new(* ["JSOP_TYPEOFEXPR", 200, "typeofexpr", nil, 1, 1, 1, 15, ["JOF_BYTE", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_ENTERBLOCK", 201, "enterblock", nil, 3, 0, -1, 0, ["JOF_OBJECT"]])
ops.push OpCode.new(* ["JSOP_LEAVEBLOCK", 202, "leaveblock", nil, 5, -1, 0, 0, ["JOF_UINT16"]])
ops.push OpCode.new(* ["JSOP_IFPRIMTOP", 203, "ifprimtop", nil, 3, 1, 1, 0, ["JOF_JUMP", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_PRIMTOP", 204, "primtop", nil, 2, 1, 1, 0, ["JOF_INT8"]])
ops.push OpCode.new(* ["JSOP_GENERATOR", 205, "generator", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_YIELD", 206, "yield", nil, 1, 1, 1, 1, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_ARRAYPUSH", 207, "arraypush", nil, 3, 1, 0, 3, ["JOF_LOCAL"]])
ops.push OpCode.new(* ["JSOP_GETFUNNS", 208, "getfunns", nil, 1, 0, 1, 19, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_ENUMCONSTELEM", 209, "enumconstelem", nil, 1, 3, 0, 3, ["JOF_BYTE", "JOF_SET"]])
ops.push OpCode.new(* ["JSOP_LEAVEBLOCKEXPR", 210, "leaveblockexpr", nil, 5, -1, 1, 3, ["JOF_UINT16"]])
ops.push OpCode.new(* ["JSOP_GETTHISPROP", 211, "getthisprop", nil, 3, 0, 1, 18, ["JOF_ATOM", "JOF_VARPROP"]])
ops.push OpCode.new(* ["JSOP_GETARGPROP", 212, "getargprop", nil, 5, 0, 1, 18, ["JOF_SLOTATOM", "JOF_VARPROP"]])
ops.push OpCode.new(* ["JSOP_GETLOCALPROP", 213, "getlocalprop", nil, 5, 0, 1, 18, ["JOF_SLOTATOM", "JOF_VARPROP"]])
ops.push OpCode.new(* ["JSOP_INDEXBASE1", 214, "indexbase1", nil, 1, 0, 0, 0, ["JOF_BYTE", "JOF_INDEXBASE"]])
ops.push OpCode.new(* ["JSOP_INDEXBASE2", 215, "indexbase2", nil, 1, 0, 0, 0, ["JOF_BYTE", "JOF_INDEXBASE"]])
ops.push OpCode.new(* ["JSOP_INDEXBASE3", 216, "indexbase3", nil, 1, 0, 0, 0, ["JOF_BYTE", "JOF_INDEXBASE"]])
ops.push OpCode.new(* ["JSOP_CALLGNAME", 217, "callgname", nil, 3, 0, 2, 19, ["JOF_ATOM", "JOF_NAME", "JOF_CALLOP", "JOF_GNAME"]])
ops.push OpCode.new(* ["JSOP_CALLLOCAL", 218, "calllocal", nil, 3, 0, 2, 19, ["JOF_LOCAL", "JOF_NAME", "JOF_CALLOP"]])
ops.push OpCode.new(* ["JSOP_CALLARG", 219, "callarg", nil, 3, 0, 2, 19, ["JOF_QARG", "JOF_NAME", "JOF_CALLOP"]])
ops.push OpCode.new(* ["JSOP_BINDGNAME", 220, "bindgname", nil, 3, 0, 1, 0, ["JOF_ATOM", "JOF_NAME", "JOF_SET", "JOF_GNAME"]])
ops.push OpCode.new(* ["JSOP_INT8", 221, "int8", nil, 2, 0, 1, 16, ["JOF_INT8"]])
ops.push OpCode.new(* ["JSOP_INT32", 222, "int32", nil, 5, 0, 1, 16, ["JOF_INT32"]])
ops.push OpCode.new(* ["JSOP_LENGTH", 223, "length", nil, 1, 1, 1, 18, ["JOF_BYTE", "JOF_PROP"]])
ops.push OpCode.new(* ["JSOP_HOLE", 224, "hole", nil, 1, 0, 1, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_DEFFUN_FC", 225, "deffun_fc", nil, 3, 0, 0, 0, ["JOF_OBJECT", "JOF_DECLARING"]])
ops.push OpCode.new(* ["JSOP_DEFLOCALFUN_FC", 226, "deflocalfun_fc", nil, 5, 0, 0, 0, ["JOF_SLOTOBJECT", "JOF_DECLARING", "JOF_TMPSLOT"]])
ops.push OpCode.new(* ["JSOP_LAMBDA_FC", 227, "lambda_fc", nil, 3, 0, 1, 19, ["JOF_OBJECT"]])
ops.push OpCode.new(* ["JSOP_OBJTOP", 228, "objtop", nil, 3, 0, 0, 0, ["JOF_UINT16"]])
ops.push OpCode.new(* ["JSOP_TRACE", 229, "trace", nil, 3, 0, 0, 0, ["JOF_UINT16"]])
ops.push OpCode.new(* ["JSOP_GETUPVAR_DBG", 230, "getupvar_dbg", nil, 3, 0, 1, 19, ["JOF_UINT16", "JOF_NAME"]])
ops.push OpCode.new(* ["JSOP_CALLUPVAR_DBG", 231, "callupvar_dbg", nil, 3, 0, 2, 19, ["JOF_UINT16", "JOF_NAME", "JOF_CALLOP"]])
ops.push OpCode.new(* ["JSOP_DEFFUN_DBGFC", 232, "deffun_dbgfc", nil, 3, 0, 0, 0, ["JOF_OBJECT", "JOF_DECLARING"]])
ops.push OpCode.new(* ["JSOP_DEFLOCALFUN_DBGFC", 233, "deflocalfun_dbgfc", nil, 5, 0, 0, 0, ["JOF_SLOTOBJECT", "JOF_DECLARING", "JOF_TMPSLOT"]])
ops.push OpCode.new(* ["JSOP_LAMBDA_DBGFC", 234, "lambda_dbgfc", nil, 3, 0, 1, 19, ["JOF_OBJECT"]])
ops.push OpCode.new(* ["JSOP_SETMETHOD", 235, "setmethod", nil, 3, 2, 1, 3, ["JOF_ATOM", "JOF_PROP", "JOF_SET", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_INITMETHOD", 236, "initmethod", nil, 3, 2, 1, 3, ["JOF_ATOM", "JOF_PROP", "JOF_SET", "JOF_DETECTING"]])
ops.push OpCode.new(* ["JSOP_UNBRAND", 237, "unbrand", nil, 1, 1, 1, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_UNBRANDTHIS", 238, "unbrandthis", nil, 1, 0, 0, 0, ["JOF_BYTE"]])
ops.push OpCode.new(* ["JSOP_SHARPINIT", 239, "sharpinit", nil, 3, 0, 0, 0, ["JOF_UINT16", "JOF_SHARPSLOT"]])
ops.push OpCode.new(* ["JSOP_GETGLOBAL", 240, "getglobal", nil, 3, 0, 1, 19, ["JOF_GLOBAL", "JOF_NAME"]])
ops.push OpCode.new(* ["JSOP_CALLGLOBAL", 241, "callglobal", nil, 3, 0, 2, 19, ["JOF_GLOBAL", "JOF_NAME", "JOF_CALLOP"]])
ops.push OpCode.new(* ["JSOP_FUNCALL", 242, "funcall", nil, 3, -1, 1, 18, ["JOF_UINT16", "JOF_INVOKE"]])
ops.push OpCode.new(* ["JSOP_FORGNAME", 243, "forgname", nil, 3, 1, 1, 19, ["JOF_ATOM", "JOF_GNAME", "JOF_FOR", "JOF_TMPSLOT3"]])

  OpCode.const_set :LIST, ops

  class OpCode   # reopen
    def OpCode.all
      LIST.dup
    end

    CODE_INDEX = {}
    LIST.each do |op|
      CODE_INDEX[op.code] = op
    end

    def OpCode.for_code(code)
      CODE_INDEX[code] or raise ArgumentError, "no such JS opcode: #{code}"
    end

    NAME_INDEX = {}
    LIST.each do |op|
      NAME_INDEX[op.name] = op
    end

    def OpCode.for_name(name)
      NAME_INDEX[name] or raise ArgumentError, "no such JS opcode: #{name}"
    end

    def type
      formats.first
    end

    ARG_COUNTS = {
      'JOF_BYTE' => 0,
      'JOF_JUMP' => 1,
      'JOF_JUMPX' => 1,
      'JOF_ATOM' => 1,
      'JOF_OBJECT' => 1,
      'JOF_REGEXP' => 1,
      'JOF_GLOBAL' => 1,
      'JOF_INT8' => 1,
      'JOF_INT32' => 1,
      'JOF_UINT8' => 1,
      'JOF_UINT16' => 1,
      'JOF_UINT24' => 1,
      'JOF_UINT16PAIR' => 2,
      #'JOF_TABLESWITCH' => 1,
      #'JOF_LOOKUPSWITCH' => 1,
      #'JOF_TABLESWITCHX' => 1,
      #'JOF_LOOKUPSWITCHX' => 1,
      'JOF_QARG' => 1,
      'JOF_LOCAL' => 1,
      'JOF_SLOTATOM' => 1,
      'JOF_SLOTOBJECT' => 1
    }

    def argc
      @argc ||= ARG_COUNTS[type]
    end

    def have_no_parameters?
      argc == 0
    end
  end
end
