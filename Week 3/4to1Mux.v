module mux4to1 (A, sel, mux_out);

input [3:0] A;
input [1:0] sel;
output reg mux_out ;

always@(A, sel) begin
case(sel)
2'b00:mux_out=A[0];
2'b01:mux_out=A[1];
2'b10:mux_out=A[2];
2'b11:mux_out=A[3];

endcase
end
endmodule

