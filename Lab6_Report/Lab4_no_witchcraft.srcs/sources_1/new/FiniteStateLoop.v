`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2019 08:46:47
// Design Name: 
// Module Name: FiniteStateLoop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FiniteStateLoop(
    input clock_fast, clock, reset, active,
    output reg LEDA, LEDB, LEDC 
    );
    
    reg [1:0] state;
    reg is_active;
    
    initial
    begin
        LEDA = 0;
        LEDB = 0;
        LEDC = 0;
        state = 0;
        is_active = 0;
    end;
    
    
    
    always @ (posedge active or posedge clock)
        if(active == 1)
            is_active = 1;
        else
            is_active = 0;
    
    always @ (posedge clock or posedge reset)    
        if(reset == 1)
        begin
            state = 2'b00;
        end
        else
            if(state != 2'b00)
                state = state + 1;
            else if(is_active == 1)
                state = 2'b01;

   
   always @ (*)
        case(state)
            2'b00: 
                begin
                    LEDA <= 0;
                    LEDB <= 0;
                    LEDC <= 0;
                end
            2'b01: 
                begin
                    LEDA <= 1;
                    LEDB <= 0;
                    LEDC <= 0;
                end
            2'b10:
                begin
                    LEDA <= 1;
                    LEDB <= 1;
                    LEDC <= 0;
                end
            2'b11: 
                begin
                    LEDA <= 1;
                    LEDB <= 1;
                    LEDC <= 1;
                end
            default:
                begin
                    LEDA <= 0;
                    LEDB <= 0;
                    LEDC <= 0;
                end
        endcase
        
endmodule
