`timescale 100ps/1ps
module tb_Full_Adder();
reg in_A, in_B, carry_in;
wire sum_out, carry_out;
Full_Adder_struc A0(in_A, in_B, carry_in, sum_out, carry_out);
initial begin
    in_A <=0;
    in_B <=0;
    carry_in <=0;
    #3
    in_A <= 1;
    #3
    in_B <= 1;
    #3
    in_A <=0;
    #3
    in_B <=0;
    carry_in <=1;
    #3
    in_A <= 1;
    #3
    in_B <= 1;
    #3
    in_A <=0;
end
endmodule
