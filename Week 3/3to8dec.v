module dec2to4(A, B, en, out);
input A, B, en;
output reg [3:0] out;

always @(en or A or B)
begin
if(en==0) begin
 out = 4'b0000;
end
else begin 
 out[0] = (~A) & (~B);
 out[1] = (~A) & (B);
 out[2] = (A) & (~B);
 out[3] = A & B;
end
end
endmodule

module dec3to8 (A, B, C, out);
input A, B, C;
output [7:0] out;

dec2to4 decoder1(B, C, ~A, out [3:0]);
dec2to4 decoder2(B, C,  A, out[7:4]);

endmodule

