`timescale 100ps/1ps
module tb_Memory;
reg     clk, WR, RD;
reg     [3:0] A, D_IN;
wire    [3:0] Q;

Memory S0(clk, WR, RD, A, D_IN, Q);

always #1 clk = ~clk;

initial begin
RD   <= 0;    
WR   <= 1;
clk  <= 0;
A    <= 4'b0011;
D_IN <= 4'b1001;
#4
A    <= 4'b1101;
D_IN <= 4'b1010;
#4
RD   <= 1;    
WR   <= 0;
A    <= 4'b0011;
#4
A    <= 4'b1101;

end
endmodule