module Memory(clk, WR, RD, A, D_IN, Q);
input   [3:0] A, D_IN;      //Address, Data Input
input         RD, WR, clk;  //Read, Write, Clock
output  [3:0] Q;            //Data Output
reg     [3:0] SRAM [15:0];  //SRAM Cell

assign Q = RD ? SRAM[A[3:0]] : 4'bzzzz ;

always @(posedge clk) begin
if(WR==1) begin
    SRAM[A[3:0]] <= D_IN [3:0];
end
end

endmodule