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
//Gate Level Modeling으로 Full Adder 설계

module four_bit_Add_Sub (in_A, in_B, out_C, carry_out, m, V);
input [3:0]   in_A;
input [3:0]   in_B;
input         m;
// in_A, in_B는 피연산자에 해당, m은 뺄셈의 유무를 나타냄
output [3:0]  out_C;
output        carry_out;
output        V;
//out_C는 출력 값을, carry_out은 마지막 full_adder에서 출력되는 값을 나타냄
//V는 overflow의 발생여부를 나타냄 
wire    c1, c2, c3;
wire    xor_B0, xor_B1, xor_B2, xor_B3;
xor (xor_B0, in_B[0], m);
xor (xor_B1, in_B[1], m);
xor (xor_B2, in_B[2], m);
xor (xor_B3, in_B[3], m);
//B가 음수이거나 뺄셈을 실행하는 경우 2's Complement를 실행

full_adder fa0(in_A[0], xor_B0,  m, out_C[0], c1);
full_adder fa1(in_A[1], xor_B1, c1, out_C[1], c2);
full_adder fa2(in_A[2], xor_B2, c2, out_C[2], c3);
full_adder fa3(in_A[3], xor_B3, c3, out_C[3], carry_out);
xor (V, c3, carry_out);
//각 FULL ADDER를 실행 후 값을 출력 마지막 Xor은 오버플로우 여부를 확인하기 위한 것
endmodule