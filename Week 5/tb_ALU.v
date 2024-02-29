`timescale 10ns/1ps

module ALU_tb;

    reg     [2:0] Opcode;
    reg     [3:0] a, b;
    wire    [3:0] result;

    initial begin
        Opcode <= 3'd0; // addition
        a <= 3'd2;
        b <= 3'd3;
        #10;

        Opcode <= 3'd1; //subtraction
        a <= 3'd7;
        b <= 3'd4;
        #10;

        Opcode <= 3'd2; //multiplication
        a <= 3'd2;
        b <= 3'd3;
        #10;

        Opcode <= 3'd3; // bitwise-or
        a <= 3'd1;
        b <= 3'd2;
        #10;

        Opcode <= 3'd4; // bitwise-and
        a <= 3'd7;
        b <= 3'd7;
        #10;

        Opcode <= 3'd5; // bitwise-xor
        a <= 3'd5;
        b <= 3'd2;
        #10;
    end
    ALU U1(a, b, Opcode, result);
endmodule

