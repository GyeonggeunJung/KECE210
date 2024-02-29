module ALU(A, B, OPCODE, out_C);
    input             [3:0] A, B; 
    input             [2:0] OPCODE; 
    output reg signed [3:0] out_C;

    integer i;

    always @ (*) begin
    case(OPCODE)
    3'b000 : out_C <= A + B;
    3'b001 : out_C <= A - B;
    3'b010 : out_C <= A * B;
    3'b011 : begin
     for(i = 0; i < 4; i=i+1)
		out_C[i] = A[i]|B[i];
    end
    3'b100 : begin
     for(i = 0; i < 4; i=i+1)
		out_C[i] = A[i]&B[i];
    end
    3'b101 : begin
     for(i = 0; i < 4; i=i+1)
		out_C[i] = A[i]^B[i];
    end
    endcase
    end
endmodule
