module BCD_Ripple_Counter (clk, out_C);
input    clk;
output [3:0] out_C;
wire  [3:0] out;
wire	[3:0] not_Q;
wire	n_clk;
assign n_clk = ~clk;
JK_FF JK0(clk, 1'b1, 1'b1, out[0], not_Q[0]);
JK_FF JK1(out[0], not_Q[3], 1'b1, out[1],  not_Q[1]);
JK_FF JK2(out[1],    1'b1, 1'b1, out[2], not_Q[2]);
JK_FF JK3(out[0], out[1]&out[2], 1'b1, out[3], not_Q[3]);

assign out_C =out;


endmodule

module SR_Latch(S, R, Q, not_Q);
input S, R;
output Q, not_Q;

nand(Q, S, not_Q);
nand(not_Q, R, Q);
endmodule

module D_FF(clk, D, Q, not_Q);
input   clk, D;
output  Q, not_Q;

wire Q1, Q2, not_Q1, not_Q2, S;

and(S, not_Q1, clk);

SR_Latch SR0(not_Q2, clk, Q1, not_Q1);
SR_Latch SR1(S, D, Q2, not_Q2);
SR_Latch SR2(not_Q1, Q2, Q, not_Q);

endmodule
module JK_FF(clk, J, K, Q, not_Q);
input   clk, J, K;
output  Q, not_Q;

wire    w1, w2, w3;

and(w1, J, not_Q);
and(w2, ~K, Q);
or(w3, w1, w2);

D_FF D0(~clk, w3, Q, not_Q);
endmodule



