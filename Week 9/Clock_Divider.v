module CLOCK_DIVIDER (clk, out_Q, Rst); 

input   clk, Rst;
output  [3:0] out_Q;
wire    [3:0] Q;

UD_Count A0(Rst, 1'b0, clk, out_Q);

endmodule