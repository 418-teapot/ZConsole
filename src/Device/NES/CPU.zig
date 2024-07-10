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
