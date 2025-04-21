module Controller (
    input [31:0]cmd,
    output Jump,
    output [1:0]RegSrc,
    output MemWrite,
    output Branch,
    output [1:0]ALUSrc,
    output [1:0]RegDst,
    output RegWrite,
    output [1:0]Extop,
    output [3:0]ALUCtrl
);
    
    reg [15:0]temp;
    always @(cmd) begin
        if ((cmd[31:26]==0)&&(cmd[5:0]!=0)) begin
            if (cmd[5:0]==8) begin
                temp <= 16'b0000000000010000;//寄存器
            end
            else if (cmd[5:0]==33) begin
                temp <= 16'b0010100000000011;//addu
            end
        end
    end

assign 
{Extop,RegWrite,RegDst,ALUSrc,Branch,MemWrite,RegSrc,Jump,ALUCtrl}
= temp;
endmodule
