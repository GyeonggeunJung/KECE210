//structual modeling
module Half_Adder(A, B, sum_out, carry_out);
input A, B;
output carry_out, sum_out;
xor (sum_out, A, B);
and (carry_out, A, B);
endmodule
//Half Adder 2개 설계 후 Full_Adder 하나로 합체
module Full_Adder_struc(in_A, in_B, carry_in, sum_out, carry_out);
input in_A, in_B, carry_in;
output carry_out, sum_out;
wire temp_sum, temp_c1, temp_c2;
Half_Adder U0(in_A, in_B, temp_sum, temp_c1);
Half_Adder U1(temp_sum, carry_in, sum_out, temp_c2);
or (carry_out, temp_c1, temp_c2);
endmodule