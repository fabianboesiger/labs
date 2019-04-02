module TailLights(
    input clk, reset, left, right,
    output LA, LB, LC, RA, RB, RC
    );
    
    wire clk_en;
    
    ClockDivider clockDivider (clk, reset, clk_en);
    
    FiniteStateLoop leftLoop (.clock(clk_en), .reset(reset), .active(left), .LEDA(LA), .LEDB(LB), .LEDC(LC));
    //FiniteStateLoop rightLoop (clk_en, reset, right, RA, RB, RC);
    
endmodule