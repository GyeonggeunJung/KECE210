`timescale 100ps/1ps
module mux4to1_tb;
reg [3:0] A;
reg [1:0] sel;
wire mux_out;
mux4to1 U1(A, sel, mux_out);
initial
begin
A=4'b1001; 
sel<=2'b00;
#3
sel<=2'b01;
#3
sel<=2'b10;
#3
sel<=2'b11;
end
endmodule
