module four_bit_7_Segment_ALU(A, B, Opcode, iCLK, nRST, oS_COM, oS_ENS);
input   iCLK, nRST, Opcode;
input   [3:0] A, B;
output  [7:0] oS_COM, oS_ENS;

wire    [3:0] C;

ALU N1(A, B, Opcode, C);
Binary_to_7_Segment N2(iCLK, nRST, C, oS_COM, oS_ENS);
endmodule

module Add_3(Binary, Binary_out);
input       [3:0] Binary;
output reg  [3:0] Binary_out;
always @(*) begin
case(Binary)
  4'd0 :    Binary_out = 4'd0;
  4'd1 :    Binary_out = 4'd1;
  4'd2 :    Binary_out = 4'd2;
  4'd3 :    Binary_out = 4'd3;
  4'd4 :    Binary_out = 4'd4;
  4'd5 :    Binary_out = 4'd8;
  4'd6 :    Binary_out = 4'd9;
  4'd7 :    Binary_out = 4'd10;
  4'd8 :    Binary_out = 4'd11;
  4'd9 :    Binary_out = 4'd12;
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

module BCD_to_7seg(bcd_in, seven_seg_out);
 input  [3:0] bcd_in;
 output [7:0] seven_seg_out;
 reg    [6:0] char_out;
// char_out[6] == a. char[5] == b ...

 always@(*) begin
 case(bcd_in)
    4'b0000 : char_out <= 7'b1111110;
    4'b0001 : char_out <= 7'b0110000;
    4'b0010 : char_out <= 7'b1101101;
    4'b0011 : char_out <= 7'b1111001;
    4'b0100 : char_out <= 7'b0110011;
    4'b0101 : char_out <= 7'b1011011;
    4'b0110 : char_out <= 7'b1011111;
    4'b0111 : char_out <= 7'b1110010;
    4'b1000 : char_out <= 7'b1111111;
    4'b1001 : char_out <= 7'b1111011;
    default : char_out <= 7'd0; //NULL
 endcase
 end
assign seven_seg_out = {char_out[6:0], 1'b0};

endmodule

module SevenSeg_CTRL( iCLK, nRST, iSEG7, iSEG6, iSEG5, iSEG4, iSEG3, iSEG2, iSEG1, iSEG0, oS_COM, oS_ENS);
input            iCLK, nRST;
input      [7:0] iSEG0, iSEG1, iSEG2, iSEG3, iSEG4, iSEG5, iSEG6, iSEG7;
output reg [7:0] oS_COM, oS_ENS;
integer CNT_SCAN;
always @(posedge iCLK) begin
    if(nRST) begin
        oS_COM   <= 8'b00000000;
        oS_ENS   <= 0;
        CNT_SCAN = 0;
    end
    else begin
        if(CNT_SCAN >= 7) CNT_SCAN = 0;
        else CNT_SCAN = CNT_SCAN + 1;
        case(CNT_SCAN)
        0: begin
            oS_COM <= 8'b11111110;
            oS_ENS <= iSEG0;
        end        
        1: begin
            oS_COM <= 8'b11111101;
            oS_ENS <= iSEG1;
        end
        2: begin
            oS_COM <= 8'b11111011;
            oS_ENS <= iSEG2;
        end
        3: begin
            oS_COM <= 8'b11110111;
            oS_ENS <= iSEG3;
        end
        4: begin
            oS_COM <= 8'b11101111;
            oS_ENS <= iSEG4;
        end        
        5: begin
            oS_COM <= 8'b11011111;
            oS_ENS <= iSEG5;
        end
        6: begin
            oS_COM <= 8'b10111111;
            oS_ENS <= iSEG6;
        end
        7: begin
            oS_COM <= 8'b01111111;
            oS_ENS <= iSEG7;
        end
        default : begin
            oS_COM <= 8'b11111111;
            oS_ENS <= iSEG7;
        end
    endcase
    end
end
endmodule

module Binary_to_7_Segment(iCLK, nRST, Binary, oS_COM, oS_ENS);
input   iCLK, nRST;
input   [3:0] Binary;
output  [7:0] oS_COM, oS_ENS;
wire    [7:0] BCD;
wire    [7:0] seven_seg_out_1, seven_seg_out_2;

Binary_to_BCD U0(Binary, BCD);
BCD_to_7seg   U1(BCD[3:0], seven_seg_out_1);
BCD_to_7seg   U2(BCD[7:4], seven_seg_out_2);
SevenSeg_CTRL U3(iCLK, nRST, seven_seg_out_2, seven_seg_out_1, , , , , , , oS_COM, oS_ENS);
endmodule

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
