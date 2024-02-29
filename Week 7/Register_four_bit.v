module Register_four_bit (clk, D, Q);
input clk;
input   [3:0] D;
output  [3:0] Q;

    D_FF DF1(clk, D[0], Q[0], );
    D_FF DF2(clk, D[1], Q[1], );
    D_FF DF3(clk, D[2], Q[2], );
    D_FF DF4(clk, D[3], Q[3], );

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