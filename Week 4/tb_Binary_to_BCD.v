`timescale 100ps/1ps
module tb_Binary_to_BCD;
   reg   [3:0] Binary;
   wire  [9:0] BCD;
   Binary_to_BCD U1(Binary, BCD);
initial begin
 for(Binary=4'b0000; Binary<4'b1111; Binary = Binary+1) begin
 Binary = Binary +1;
 #3;
 end
end
endmodule
