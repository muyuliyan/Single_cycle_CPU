module reg_file(
    input rst, clk, write_reg,
    input [4: 0] rs1, rs2, target_reg,
    input [31: 0] write_rd_data,

    output reg [31: 0] read_rs1_data,
    output reg [31: 0] read_rs2_data
);

reg [31: 0] regs[31: 0];

// 初始化寄存器文件
initial begin
    regs[0] = 32'h0000_0000;

    for (int i = 1; i < 32; i++) begin
        regs[i] = 32'd128 + i - 1;
    end
end

// 写入寄存器
always @(posedge clk) begin
    if (write_reg && target_reg != 5'h0) begin
        regs[target_reg] = write_rd_data;
    end
end

// 读取寄存器 rs1
always @(*) begin
    if (rs1 == 5'h0) begin
        read_rs1_data = 32'h0000_0000;
    end else begin
        read_rs1_data = regs[rs1];
    end
end

// 读取寄存器 rs2
always @(*) begin
    if (rs2 == 5'h0) begin
        read_rs2_data = 32'h0000_0000;
    end else begin
        read_rs2_data = regs[rs2];
    end
end

endmodule