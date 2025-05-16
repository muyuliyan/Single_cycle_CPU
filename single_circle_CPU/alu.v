module alu(
    input[4: 0] aluc,
    input [31: 0] a, b,
    output reg [31: 0] result, 
    output reg condition_branch
);

wire [31:0] add_sub_result;
wire [31:0] slt_result;
wire [31:0] sltu_result;
wire [31:0] and_result;
wire [31:0] nor_result;
wire [31:0] or_result;
wire [31:0] xor_result;
wire [31:0] lui_result;
wire [31:0] sll_result;
wire [63:0] sr64_result;
wire [31:0] sr_result;
wire adder_cout;

// 32-bit adder
wire [31:0] adder_a;
wire [31:0] adder_b;
wire adder_cin;
wire [31:0] adder_result;

assign adder_a = a;
assign adder_b = (aluc == 5'b00001 || aluc == 5'b00110 || aluc == 5'b00111) ? ~b : b;  // For SUB, SLT, SLTU
assign adder_cin = (aluc == 5'b00001 || aluc == 5'b00110 || aluc == 5'b00111) ? 1'b1 : 1'b0;
assign {adder_cout, adder_result} = adder_a + adder_b + adder_cin;

// ADD, SUB result
assign add_sub_result = adder_result;

// SLT result
assign slt_result[31:1] = 31'b0;
assign slt_result[0]    = (a[31] & ~b[31]) | ((a[31] ^ b[31]) & adder_result[31]);

// SLTU result
assign sltu_result[31:1] = 31'b0;
assign sltu_result[0]    = ~adder_cout;

// bitwise operations
assign and_result = a & b;
assign or_result  = a | b;
assign nor_result = ~(a | b);
assign xor_result = a ^ b;
assign lui_result = b;

// SLL result
assign sll_result = b << a[4:0];

// SRL, SRA result
assign sr64_result = {{32{aluc == 5'b01001 && b[31]}}, b} >> a[4:0];
assign sr_result   = sr64_result[31:0];

always @(*) begin
    condition_branch = 0;
    out = 32'b0;
    case (aluc)
        5'b00000: out = add_sub_result; // ADD
        5'b00001: out = add_sub_result; // SUB
        5'b00010: out = and_result;     // AND
        5'b00011: out = or_result;      // OR
        5'b00100: out = xor_result;     // XOR
        5'b00101: out = sll_result;     // SLL
        5'b00110: out = slt_result;     // SLT
        5'b00111: out = sltu_result;    // SLTU
        5'b01000: begin                 // SRL
            out = sr_result;
        end
        5'b01001: begin                 // SRA
            out = sr_result;
        end
        5'b01010: begin                 // ADD with carry clear?
            out = a + b;
            out[0] = 1'b0;
        end
        5'b01011: condition_branch = (a == b); // BEQ
        5'b01100: condition_branch = (a != b); // BNE
        5'b01101: condition_branch = ($signed(a) < $signed(b)); // BLT
        5'b01110: condition_branch = ($signed(a) >= $signed(b)); // BGE
        5'b01111: condition_branch = (a < b); // BLTU
        5'b10000: condition_branch = (a >= b); // BGEU
        default: result = 32'b0;
    endcase
end

endmodule