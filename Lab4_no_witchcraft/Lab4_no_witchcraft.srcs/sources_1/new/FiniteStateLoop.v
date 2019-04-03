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
    output LEDA, LEDB, LEDC 
    );
    
    reg [1:0] state;
    
    reg is_active;
           
    reg LEDA_state;
    reg LEDB_state;
    reg LEDC_state;
    
    always @ (posedge active or posedge clock)
        if(active == 1)
            is_active <= 1;
        else
            is_active <= 0;
    
    always @ (posedge clock or posedge reset)    
        if(reset == 1)
        begin
            state <= 2'b00;
        end
        else
            if(state != 2'b00)
                state <= state + 1;
            else if(is_active == 1)
                state <= 2'b01;

   
   always @ (*)
        case(state)
            2'b00: 
                begin
                    LEDA_state <= 0;
                    LEDB_state <= 0;
                    LEDC_state <= 0;
                end
            2'b01: 
                begin
                    LEDA_state <= 1;
                    LEDB_state <= 0;
                    LEDC_state <= 0;
                end
            2'b10:
                begin
                    LEDA_state <= 1;
                    LEDB_state <= 1;
                    LEDC_state <= 0;
                end
            2'b11: 
                begin
                    LEDA_state <= 1;
                    LEDB_state <= 1;
                    LEDC_state <= 1;
                end
            default:
                begin
                    LEDA_state <= 0;
                    LEDB_state <= 0;
                    LEDC_state <= 0;
                end
        endcase
    
    BrightnessController brightnessControllerA (clock_fast, reset, LEDA_state, LEDA);
    BrightnessController brightnessControllerB (clock_fast, reset, LEDB_state, LEDB);
    BrightnessController brightnessControllerC (clock_fast, reset, LEDC_state, LEDC);
    
endmodule
