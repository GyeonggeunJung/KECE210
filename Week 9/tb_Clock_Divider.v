`timescale 100ps/1ps
module tb_Clock_Divider;
reg   CLK, Rst;
wire  QA, QB, QC, QD;

CLOCK_DIVIDER C0 (CLK, {QD, QC, QB, QA}, Rst);

always #1 CLK = ~CLK;
initial begin
CLK <= 0;
Rst <= 1;
#1
Rst <=0;
end

endmodule
