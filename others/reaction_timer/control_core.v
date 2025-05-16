module reaction_timer(
    input clk,clr,clear,start,stop;
    input [1:0]choose_which;
    output reg LED;//控制LED灯
    output reg foul;//犯规信号
);
parameter init_state = 2'b00;//初始状态
          random_times = 2'b01;
          start_count = 2'b10;
          stagnant_state = 2'b11;

reg[1:0]state;

//*子模块调用端口
reg wether_count;
reg random_count;
wire time_out;
wire [12:0]rtime;
// assign rtime = 13'd3000;//test data
wire reach;
wire [12:0]number;

    
endmodule