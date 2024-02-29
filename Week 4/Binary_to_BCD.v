module Add_3(Binary, Binary_out);
input       [3:0] Binary;
output reg  [3:0] Binary_out;

always @(*) begin
case(Binary)
  4'd0 : Binary_out = 4'd0;
  4'd1 : Binary_out = 4'd1;
  4'd2 : Binary_out = 4'd2;
  4'd3 : Binary_out = 4'd3;
  4'd4 : Binary_out = 4'd4;
  4'd5 : Binary_out = 4'd8;
  4'd6 : Binary_out = 4'd9;
  4'd7 : Binary_out = 4'd10;
  4'd8 : Binary_out = 4'd11;
  4'd9 : Binary_out = 4'd12;
  default : Binary_out = 4'bxxxx;
endcase
end
endmodule

module Binary_to_BCD(Binary, BCD);
input   [3:0] Binary;
output  [9:0] BCD;
wire    [11:0] t;
    assign BCD[0] = Binary[0];
    Add_3 C1( {1'b0, 1'b0, 1'b0, Binary[3]}, t[3:0]);
    Add_3 C2( {t[2], t[1], t[0], Binary[2]}, t[7:4]);
    Add_3 C3( {1'b0, 1'b0, 1'b0, t[3]}, t[11:8]);
    Add_3 C4( {t[6], t[5], t[4], Binary[1]}, BCD[4:1]);
    Add_3 C5( {t[10], t[9], t[8], t[7]} , BCD[8:5]);   
    assign BCD[9] = t[11];
endmodule

