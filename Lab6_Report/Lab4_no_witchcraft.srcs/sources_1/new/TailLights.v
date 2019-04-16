module TailLights(
    input clk, reset, left, right,
    output LA, LB, LC, RA, RB, RC
    );
    
    wire clk_slow = clk;
    
    //ClockDivider #(24) clockDivider (clk, reset, clk_slow);
    
    FiniteStateLoop leftLoop (clk, clk_slow, reset, left, LA, LB, LC);
    FiniteStateLoop rightLoop (clk, clk_slow, reset, right, RA, RB, RC);
        
endmodule