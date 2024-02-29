`timescale 100ps/1ps
module dec3to8_tb;
reg [2:0] A;
wire [7:0] out;

dec3to8 U0(A[2], A[1], A[0], out);

initial begin
 A <= 3'b000;
 for(A = 3'b000; A<=3'b111; A = A+1) #3;
end
endmodule
