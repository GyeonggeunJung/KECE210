module full_adder(in_A, in_B, carry_in, out_C, carry_out);
input in_A, in_B, carry_in;
output carry_out, out_C;
wire c1, c2, c3;

xor (c1, in_A, in_B) ;
xor (out_C, c1, carry_in);
and (c2, c1, carry_in);
and (c3, in_A, in_B);
or (carry_out, c2, c3);
endmodule

module four_bit_FA ( in_A, in_B, carry_in, out_C, carry_out);
input [3:0]   in_A;
input [3:0]   in_B;
input         carry_in;
output [3:0]  out_C;
output        carry_out;
wire c1, c2, c3;
full_adder fa0(in_A[0], in_B[0], carry_in, out_C[0], c1);
full_adder fa1(in_A[1], in_B[1], c1, out_C[1], c2);
full_adder fa2(in_A[2], in_B[2], c2, out_C[2], c3);
full_adder fa3(in_A[3], in_B[3], c3, out_C[3], carry_out);
endmodule
//4bit Ripple Carry Adder 설계
module Unsigned_Binary_Multiplier (A, B, out_C);
input   [2:0] A;
input   [3:0] B;
output  [6:0] out_C;

wire [3:0] A0_and;
wire [3:0] A1_and;
wire [3:0] A2_and;
wire [4:0] out_temp1;

genvar i;
for(i=0; i<4; i=i+1) begin
    and(A0_and[i], A[0], B[i]);
end

for(i=0; i<4; i=i+1) begin
    and(A1_and[i], A[1], B[i]);
end

for(i=0; i<4; i=i+1) begin
    and(A2_and[i], A[2], B[i]);
end

assign out_C[0] = A0_and[0];
four_bit_FA fa_0({1'b0,A0_and[3:1]}, A1_and[3:0], 1'b0, out_temp1[3:0], out_temp1[4]);
assign out_C[1] = out_temp1[0];
four_bit_FA fa_1(A2_and[3:0], out_temp1[4:1], 1'b0, out_C[5:2], out_C[6]);

endmodule
