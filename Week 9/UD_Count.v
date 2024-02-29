module JK_FF(clk, J, K, S, Q, notQ); 
input   clk, J, K, S;
output reg Q, notQ;
always @(posedge clk)
if (S == 1'b1) begin
    Q <= 1'b0;
    notQ <= 1'b1;
end
else
case({J, K}) 
2'b00: begin Q <= Q; notQ <= notQ; end
2'b01: begin Q <= 1'b0; notQ <= 1'b1; end
2'b10: begin Q <= 1'b1; notQ <= 1'b0; end
2'b11: begin Q <= ~Q; notQ <= ~notQ; end
endcase
endmodule

module UD_Count(ResetN, DNUP, CLK, Q); 
input ResetN, DNUP, CLK;
output [3:0] Q;
wire Q1, notQ1, Q2, notQ2, Q3, notQ3, Q4, notQ4;
wire up1, down1, w1, w21, w20, w22, w33, w31, w34;
JK_FF J1(CLK, 1, 1, ResetN, Q1, notQ1);
assign down1 = notQ1 & DNUP;
assign up1 = Q1 & (~DNUP);
assign w1 = down1 | up1;

JK_FF J2(CLK, w1, w1, ResetN, Q2, notQ2);
assign w21 = down1 & notQ2;
assign w20 = up1 & Q2;
assign w22 = w21 | w20;

JK_FF J3(CLK, w22, w22, ResetN, Q3, notQ3);
assign w33 = notQ3 & down1 & notQ2;
assign w31 = Q3 & up1 & Q2;
assign w34 = w31 | w33;

JK_FF J4(CLK, w34, w34, ResetN, Q4, notQ4);
assign Q[0] = Q1;
assign Q[1] = Q2;
assign Q[2] = Q3;
assign Q[3] = Q4;
endmodule

