module id_instruction_mem (
    input rst, clk,
    input [31: 0] pc,
    output [6: 0] opcode,
    output [2: 0] func3,
    output [6: 0] func7,
    output [4: 0] rd,
    output [4: 0] rs1,
    output [4: 0] rs2,
    output [31: 0] instruction
);

reg [31: 0] inst_mem[63: 0];

initial begin
    inst_mem[0] =	32'hfe010113;          	// addi	sp,sp,-32
    inst_mem[1] =	32'h00812e23;          	// sw	s0,28(sp)
    inst_mem[2] =	32'h02010413;          	// addi	s0,sp,32
    inst_mem[3] =	32'hfea42623;          	// sw	a0,-20(s0)
    inst_mem[4] =	32'hfec42783;          	// lw	a5,-20(s0)
    inst_mem[5] =	32'h0007a703;          	// lw	a4,0(a5)
    inst_mem[6] =	32'h00200793;          	// li	a5,2
    inst_mem[7] =	32'h00f71e63;          	// bne	a4,a5,38 <fun+0x38>
    inst_mem[8] =	32'hfec42783;          	// lw	a5,-20(s0)
    inst_mem[9] =	32'h0007a783;          	// lw	a5,0(a5)
    inst_mem[10] =	32'h00178713;          	// addi	a4,a5,1
    inst_mem[11] =	32'hfec42783;          	// lw	a5,-20(s0)
    inst_mem[12] =	32'h00e7a023;          	// sw	a4,0(a5)
    inst_mem[13] =	32'h01c0006f;          	// j	50 <fun+0x50>
    inst_mem[14] =	32'hfec42783;         	// lw	a5,-20(s0)
    inst_mem[15] =	32'h0007a783;          	// lw	a5,0(a5)
    inst_mem[16] =	32'h00a78713;          	// addi	a4,a5,10
    inst_mem[17] =	32'hfec42783;          	// lw	a5,-20(s0)
    inst_mem[18] =	32'h00e7a023;          	// sw	a4,0(a5)
    inst_mem[19] =	32'h00000013;          	// nop
    inst_mem[20] =	32'h01c12403;          	// lw	s0,28(sp)
    inst_mem[21] =	32'h02010113;          	// addi	sp,sp,32
    inst_mem[22] =	32'h00008067;          	// ret
    inst_mem[23] =	32'hfe010113;         	//addi	sp,sp,-32
    inst_mem[24] =	32'h00112e23;          	// sw	ra,28(sp)
    inst_mem[25] =	32'h00812c23;          	// sw	s0,24(sp)
    inst_mem[26] =	32'h02010413;          	// addi	s0,sp,32
    inst_mem[27] =	32'h00100793;          	// li	a5,1
    inst_mem[28] =	32'hfef42623;          	// sw	a5,-20(s0)
    inst_mem[29] =	32'hfec40793;          	// addi	a5,s0,-20
    inst_mem[30] =	32'h00078513;          	// mv	a0,a5
    inst_mem[31] =	32'hf85ff0ef;          	// jal	ra,0 <fun>
    inst_mem[32] =	32'h00000793;          	// li	a5,0
    inst_mem[33] =	32'h00078513;         	// mv	a0,a5
    inst_mem[34] =	32'h01c12083;          	// lw	ra,28(sp)
    inst_mem[35] =	32'h01812403;          	// lw	s0,24(sp)
    inst_mem[36] =	32'h02010113;          	// addi	sp,sp,32
    // inst_mem[0] =	32'h00008067;          	// ret

    inst_mem[37] = {12'h0, 5'b0, 3'b000, 5'b0, 7'b0010011}; // nop

    //根据PC地址读取指令
    assign instruction = inst_mem[pc >> 2];

    // 指令解析
    assign opcode  = instruction[6:0];
    assign rs1     = instruction[19:15];
    assign rs2     = instruction[24:20];
    assign rd      = instruction[11:7];
    assign func3   = instruction[14:12];
    assign func7   = instruction[31:25];
end

endmodule