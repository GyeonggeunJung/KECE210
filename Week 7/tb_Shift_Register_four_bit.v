`timescale 100ps/1ps
module tb_Shift_Register_four_bit;
reg     clk, inp;
wire    [3:0] outp;

wire     [5:0] data;
integer i;
assign data    = 6'b101101;
Shift_Register_four_bit U0(clk, inp, outp);
initial
clk     <=0;

always  #1 clk = ~clk;

initial begin
 for(i=0; i<6; i=i+1) begin
 inp <= data[i];
 #2;
 end    
end
endmodule