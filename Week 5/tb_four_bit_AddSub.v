`timescale 100ps/1ps
module tb_four_bit_Add_Sub();
reg  [3:0] in_A, in_B;
reg  m;
wire [3:0] out_C;
wire carry_out, V;

four_bit_Add_Sub A0(in_A, in_B, out_C, carry_out, m, V);

initial begin
    in_A <=4'd4;
    in_B <=4'd7;
    m <=0;
    #3
    in_A <=4'd13;
    in_B <=4'd12;
    m <=0;
    #3
    in_A <=4'd13;
    in_B <=4'd5;
    m <=1;
    #3
    in_A <=4'd5;
    in_B <=4'd2;
    m <=1;
end
endmodule