module Program_Counter (CLK, PL, JB, BC, LAddress, RAddress, AData, PC);
input  CLK, PL, JB, BC;
input  [1:0] LAddress, RAddress;
input  [3:0] AData;
output reg [3:0] PC;

initial begin
    
end

always @(posedge CLK) begin
    if(~PL) //if PB is 0
        PC <= PC + 4'b0001;
    else if(JB) // if PB and JB are both 1.
        PC <= AData;
    else if(BC) begin // PB = 1, JB = 0, BC = 1
        if(AData < 4'b0000)
            PC <= PC + {LAddress[1:0], RAddress[1:0]};
        else
            PC <= PC + 4'b0001;

    end 
    else if(~BC) begin // PB = 1, JB = 0, BC = 0
        if(AData == 4'b0000)
            PC <= PC + {LAddress[1:0], RAddress[1:0]};
        else
            PC <= PC + 4'b0001;
    end  
end

endmodule