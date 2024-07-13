const RegFile = struct {
    /// Program counter register.
    PC: u16,
    /// Stack pointer register.
    SP: u8,
    /// Accumulator register.
    A: u8,
    /// Index register X.
    X: u8,
    /// Index register Y.
    Y: u8,
    /// Processor status register
    P: u8,

    const Flags = enum(u8) {
        C = 1 << 0, // Carry flag.
        Z = 1 << 1, // Zero flag.
        I = 1 << 2, // Interrupt flag.
        D = 1 << 3, // Decimal mode.
        B = 1 << 4, // Break command.
        U = 1 << 5, // Unused.
        V = 1 << 6, // Overflow flag.
        N = 1 << 7, // Negative flag.
    };

    pub fn reset(self: RegFile) void {
        self.PC = 0;
        self.SP = 0;
        self.A = 0;
        self.X = 0;
        self.Y = 0;
        self.P = 0;
    }

    pub fn getFlag(self: RegFile, flag: Flags) bool {
        return self.P & flag;
    }

    pub fn setFlag(self: RegFile, flag: Flags) void {
        self.P |= flag;
    }

    pub fn clearFlag(self: RegFile, flag: Flags) void {
        self.P &= ~flag;
    }
};

/// Most of 6502 instructions have bit patterns of the form AAABBBCC. The AAA
/// and CC bits determine the opcode, and the BBB bits determine the addressing
/// mode.
const OpCodeCC00 = enum(u3) {
    BIT = 0b001,
    JMP = 0b010,
    JMP_ABS = 0b111,
    STY = 0b100,
    LDY = 0b101,
    CPY = 0b110,
    CPX = 0b111,
};

const AddrModeCC00 = enum(u3) {
    IMME = 0b000,
    ZERO = 0b001,
    ABS = 0b011,
    ZERO_X = 0b101,
    ABS_X = 0b111,
};

const OpCodeCC01 = enum(u3) {
    ORA = 0b000,
    AND = 0b001,
    EOR = 0b010,
    ADC = 0b011,
    STA = 0b100,
    LDA = 0b101,
    CMP = 0b110,
    SBC = 0b111,
};

const AddrModeCC01 = enum(u3) {
    IDX_IND = 0b000,
    ZERO = 0b001,
    IMME = 0b010,
    ABS = 0b011,
    IND_IDX = 0b100,
    ZERO_X = 0b101,
    ABS_Y = 0b110,
    ABS_X = 0b111,
};

const OpCodeCC10 = enum(u3) {
    ASL = 0b000,
    ROL = 0b001,
    LSR = 0b010,
    ROR = 0b011,
    STX = 0b100,
    LDX = 0b101,
    DEC = 0b110,
    INC = 0b111,
};

const AddrModeCC10 = enum(u3) {
    IMME = 0b000,
    ZERO = 0b001,
    ACC = 0b010,
    ABS = 0b011,
    ZERO_X = 0b101,
    ABS_X = 0b111,
};

const Branch = enum(u8) {
    BPL = 0x10,
    BMI = 0x30,
    BVC = 0x50,
    BVS = 0x70,
    BCC = 0x90,
    BCS = 0xB0,
    BNE = 0xD0,
    BEQ = 0xF0,
};

const Jump = enum(u8) {
    BRK = 0x00,
    JSR = 0x20,
    RTI = 0x40,
    RTS = 0x60,
};

const Status = enum(u8) {
    CLC = 0x18,
    SEC = 0x38,
    CLI = 0x58,
    SEI = 0x78,
    CLV = 0xB8,
    CLD = 0xD8,
    SED = 0xF8,
};

const Stack = enum(u8) {
    PHP = 0x08,
    PLP = 0x28,
    PHA = 0x48,
    PLA = 0x68,
};

const XY = enum(u8) {
    INX = 0xE8,
    INY = 0xC8,
    DEX = 0xCA,
    DEY = 0x88,
    TXA = 0x8A,
    TAX = 0xAA,
    TYA = 0x98,
    TAY = 0xA8,
    TXS = 0x9A,
    TSX = 0xBA,
};

const Special = enum(u8) {
    NOP = 0xEA,
};
