module data_mem(
    input clk, rst, 
    input [1: 0] write_mem, 
    input [2: 0] read_mem,
    input [31: 0] address, write_data,
    output reg [31: 0] out_mem
);

reg [7: 0] data [127: 0];
reg [31: 0] read_data;

// 读操作是组合逻辑
always @(*) begin
    case (read_mem[1: 0])
        2'b00: begin
            read_data = 32'b0;
        end
        2'b01: begin
            read_data = {data[address + 3], data[address + 2], data[address + 1], data[address]};
        end
        2'b10: begin
            if (read_mem[2])
                read_data = {{16{data[address + 1][7]}}, data[address + 1], data[address]};
            else
                read_data = {16'b0, data[address + 1], data[address]};
        end
        2'b11: begin
            if (read_mem[2])
                read_data = {{24{data[address][7]}}, data[address]};
            else
                read_data = {24'b0, data[address]};
        end
        default: begin
            read_data = 32'b0;
        end
    endcase
end

// 写操作是时序逻辑
always @(posedge clk) begin
    case (write_mem)
        2'b01: begin
            data[address + 3] = write_data[31:24];
            data[address + 2] = write_data[23:16];
            data[address + 1] = write_data[15:8];
            data[address] = write_data[7:0];
        end
        2'b10: begin
            data[address + 1] = write_data[15:8];
            data[address] = write_data[7:0];
        end
        2'b11: begin
            data[address] = write_data[7:0];
        end
        default: begin
        end
    endcase
end

// 使用寄存器将读数据同步到时钟边沿
always @(posedge clk or posedge rst) begin
    if (rst) begin
        out_mem <= 32'b0;
    end else begin
        out_mem <= read_data;
    end
end

endmodule