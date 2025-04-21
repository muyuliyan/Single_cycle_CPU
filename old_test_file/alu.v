module ALU(
    input [31:0]op1,
    input [31:0]op2,
    input [3:0]sel,
    output [31:0]result,
    output zero,
);

    reg[31:0]res;

    always @(*) begin
        if(sel == 2)begin
            res <= op1 + op2;//+
        end
        else if (sel == 3) begin
            res <= op1 - op2;//-
        end
        else if (sel == 4) begin
            res <= op1 & op2;//&
        end
        else if (sel == 5) begin
            res <= op1 | op2;//|
        end
        else if (sel == 6) begin
            res <= op1 ^ op2;//^
        end
        else if (sel == 8) begin
            res <= {31'b0,($signed(op1)) < ($signed(op2))}//小于置一有符号
        end
        else begin
            //默认res
            res <= 0;
        end
    end

    assign result = res;
    assign zero = (res==0?1:0);

endmodule
