module reg_file(
    input rst, clk, write_reg,
    input [4: 0] rs1, rs2, target_reg,
    input [31: 0] write_rd_data,

    output reg [31: 0] read_rs1_data,
    output reg [31: 0] read_rs2_data
);

reg [31: 0] regs[31: 0];

// åˆå§‹åŒ–å¯„å­˜å™¨æ–‡ä»¶
initial begin
    regs[0] = 32'h0000_0000;
     regs[1] = 32'd128 + 1 - 1;  // ¼´ 32'd128
    regs[2] = 32'd128 + 2 - 1;  // ¼´ 32'd129
    regs[3] = 32'd128 + 3 - 1;  // ¼´ 32'd130
    regs[4] = 32'd128 + 4 - 1;  // ¼´ 32'd131
    regs[5] = 32'd128 + 5 - 1;  // ¼´ 32'd132
    regs[6] = 32'd128 + 6 - 1;  // ¼´ 32'd133
    regs[7] = 32'd128 + 7 - 1;  // ¼´ 32'd134
    regs[8] = 32'd128 + 8 - 1;  // ¼´ 32'd135
    regs[9] = 32'd128 + 9 - 1;  // ¼´ 32'd136
    regs[10] = 32'd128 + 10 - 1;  // ¼´ 32'd137
    regs[11] = 32'd128 + 11 - 1;  // ¼´ 32'd138
    regs[12] = 32'd128 + 12 - 1;  // ¼´ 32'd139
    regs[13] = 32'd128 + 13 - 1;  // ¼´ 32'd140
    regs[14] = 32'd128 + 14 - 1;  // ¼´ 32'd141
    regs[15] = 32'd128 + 15 - 1;  // ¼´ 32'd142
    regs[16] = 32'd128 + 16 - 1;  // ¼´ 32'd143
    regs[17] = 32'd128 + 17 - 1;  // ¼´ 32'd144
    regs[18] = 32'd128 + 18 - 1;  // ¼´ 32'd145
    regs[19] = 32'd128 + 19 - 1;  // ¼´ 32'd146
    regs[20] = 32'd128 + 20 - 1;  // ¼´ 32'd147
    regs[21] = 32'd128 + 21 - 1;  // ¼´ 32'd148
    regs[22] = 32'd128 + 22 - 1;  // ¼´ 32'd149
    regs[23] = 32'd128 + 23 - 1;  // ¼´ 32'd150
    regs[24] = 32'd128 + 24 - 1;  // ¼´ 32'd151
    regs[25] = 32'd128 + 25 - 1;  // ¼´ 32'd152
    regs[26] = 32'd128 + 26 - 1;  // ¼´ 32'd153
    regs[27] = 32'd128 + 27 - 1;  // ¼´ 32'd154
    regs[28] = 32'd128 + 28 - 1;  // ¼´ 32'd155
    regs[29] = 32'd128 + 29 - 1;  // ¼´ 32'd156
    regs[30] = 32'd128 + 30 - 1;  // ¼´ 32'd157
    regs[31] = 32'd128 + 31 - 1;  // ¼´ 32'd158
end

// å†™å…¥å¯„å­˜å™?
always @(posedge clk) begin
    if (write_reg && target_reg != 5'h0) begin
        regs[target_reg] = write_rd_data;
    end
end

// è¯»å–å¯„å­˜å™? rs1
always @(*) begin
    if (rs1 == 5'h0) begin
        read_rs1_data = 32'h0000_0000;
    end else begin
        read_rs1_data = regs[rs1];
    end
end

// è¯»å–å¯„å­˜å™? rs2
always @(*) begin
    if (rs2 == 5'h0) begin
        read_rs2_data = 32'h0000_0000;
    end else begin
        read_rs2_data = regs[rs2];
    end
end

endmodule