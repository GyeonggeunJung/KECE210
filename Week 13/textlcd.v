
module textlcd(resetn,clk,LCD_E,LCD_RS,LCD_RW,LCD_DATA);

input resetn,clk;
output LCD_E,LCD_RS,LCD_RW;
output [7:0]LCD_DATA;

wire LCD_E;
reg LCD_RS,LCD_RW;
reg [7:0] LCD_DATA;
reg [2:0] state;

parameter   delay          =3'b000, 
            function_set   =3'b001,
            entry_mode     =3'b010,
            disp_onoff     =3'b011,
            line1          =3'b100,  
            line2          =3'b101,
            delay_t        =3'b110,
            clear_disp     =3'b111;

integer CNT;

always @(negedge resetn or posedge clk)
begin
   if(!resetn) state = delay;
   else
   begin   
      case(state)
         delay:            if(CNT==70)    state = function_set;
         function_set:     if(CNT==30)    state = disp_onoff;
         disp_onoff:       if(CNT==30)    state = entry_mode;
         entry_mode:       if(CNT==30)    state = line1;
         line1:            if(CNT==20)    state = line2;
         line2:            if(CNT==20)    state = delay_t;
         delay_t:          if(CNT==400)   state = clear_disp;
         clear_disp:       if(CNT==200)   state = line1;
         default:                         state = delay;
      endcase
   end
end


always @(negedge resetn or posedge clk)
begin
   if(!resetn) CNT=0;
   else
      begin   
         case(state)
            delay:          if(CNT>=70)CNT=0;
                           else CNT=CNT+1;
            function_set:    if(CNT>=30)CNT=0;
                           else CNT=CNT+1;
            disp_onoff:      if(CNT>=30)CNT=0;
                           else CNT=CNT+1;
            entry_mode:      if(CNT>=30)CNT=0;
                           else CNT=CNT+1;
            line1:         if(CNT>=20)CNT=0;
                           else CNT=CNT+1;
            line2:         if(CNT>=20)CNT=0;
                           else CNT=CNT+1;
            delay_t:         if(CNT>=400)CNT=0;
                           else CNT=CNT+1;
            clear_disp:    if(CNT>=200)CNT=0;
                           else CNT=CNT+1;
            default:         CNT=0;
         endcase
      end
end




always @(negedge resetn or posedge clk)
begin
   if(!resetn) begin
      LCD_RS=1'b1;
      LCD_RW=1'b1;
      LCD_DATA=8'b00000000;
   end
   else
      begin   
         case(state)
            function_set:    begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00111000;
                           end
            disp_onoff:      begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00001100;
                           end
            entry_mode:      begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00000110;
                           end
            line1:         begin
                              LCD_RW=1'b0;
                              case(CNT)
        0 : begin LCD_RS= 1'b0; LCD_DATA = 8'b10000000; end
        1 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01100100; end
        2 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01101001; end
        3 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01100111; end
        4 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01101001; end
        5 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01110100; end
        6 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01100001; end
        7 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01101100; end
        8 : begin LCD_RS= 1'b1; LCD_DATA = 8'b00100000; end
        9 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01110011; end
        10: begin LCD_RS= 1'b1; LCD_DATA = 8'b01110011; end
        11: begin LCD_RS= 1'b1; LCD_DATA = 8'b01111001; end
        12: begin LCD_RS= 1'b1; LCD_DATA = 8'b01110100; end
        13: begin LCD_RS= 1'b1; LCD_DATA = 8'b01100101; end
        14: begin LCD_RS= 1'b1; LCD_DATA = 8'b01101101; end
        15: begin LCD_RS= 1'b1; LCD_DATA = 8'b00100000; end
        16: begin LCD_RS= 1'b1; LCD_DATA = 8'b00100000; end
                                 default:begin
                                    LCD_RS=1'b1;LCD_DATA=8'b00100000;//
                                 end
                              endcase
                           end
            line2:         begin
                              LCD_RW=1'b0;
                              case(CNT)
        0 : begin LCD_RS= 1'b0; LCD_DATA = 8'b11000000; end
        1 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01101000; end
        2 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01100101; end
        3 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01101100; end
        4 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01101100; end
        5 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01101111; end
        6 : begin LCD_RS= 1'b1; LCD_DATA = 8'b00100000; end
        7 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01110111; end
        8 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01101111; end
        9 : begin LCD_RS= 1'b1; LCD_DATA = 8'b01110010; end
        10: begin LCD_RS= 1'b1; LCD_DATA = 8'b01101100; end
        11: begin LCD_RS= 1'b1; LCD_DATA = 8'b01100100; end
        12: begin LCD_RS= 1'b1; LCD_DATA = 8'b00100001; end
        13: begin LCD_RS= 1'b1; LCD_DATA = 8'b00100000; end
        14: begin LCD_RS= 1'b1; LCD_DATA = 8'b00100000; end
        15: begin LCD_RS= 1'b1; LCD_DATA = 8'b00100000; end
        16: begin LCD_RS= 1'b1; LCD_DATA = 8'b00100000; end
                                 default:begin
                                    LCD_RS=1'b1;LCD_DATA=8'b00100000;//
                                 end
                              endcase
                           end
            delay_t:         begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00000010;
                           end
            clear_disp:    begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00000001;
                           end
            default:         begin
                              LCD_RS=1'b1;
                              LCD_RW=1'b1;
                              LCD_DATA=8'b00000000;
                           end
         endcase
      end
end

assign LCD_E=clk;

endmodule
