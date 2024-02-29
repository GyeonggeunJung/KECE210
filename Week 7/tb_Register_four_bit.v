`timescale 100ps/1ps
module tb_Register_four_bit;
reg     clk;
reg     [3:0] D;
wire    [3:0] out;

Register_four_bit U0(clk, D, out);
initial
clk <=0;
always  #1 clk = ~clk;

initial begin
 for(D=4'b0000; D<4'b1111; D = D+1) begin
 D = D +1;
 #5;
 end    
end
endmodule