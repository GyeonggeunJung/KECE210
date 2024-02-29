`timescale 100ps/1ps
module tb_Unsigned_Binary_Multiplier();
reg  [2:0] in_A;
reg  [3:0] in_B;
wire [6:0] out_C;

Unsigned_Binary_Multiplier A0(in_A, in_B, out_C);

initial begin
    in_A <=3'd5;
    in_B <=4'd14;
    #3
    in_A <=3'd3;
    in_B <=4'd8;
    #3
    in_A <=3'd7;
    in_B <=4'd13;
    #3
    in_A <=3'd2;
    in_B <=4'd10;
end
endmodule