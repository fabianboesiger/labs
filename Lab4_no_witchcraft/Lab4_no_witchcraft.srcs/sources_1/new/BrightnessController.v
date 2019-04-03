`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2019 20:36:12
// Design Name: 
// Module Name: BrightnessController
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


module BrightnessController(
    input clock, reset, state,
    output reg LED
    );
    /*
    reg [7:0] off_count;
    reg [15:0] off_range;
    reg [8:0] led_count;
    reg full;

    always @ (posedge clock or posedge reset)
    begin
        if (reset | ~state)
        begin
            off_count <= 8'b00000000;
            led_count <= 9'b000000000;
            off_range <= 16'b0000000000000000;
            full <= 0;
            LED <= 0;
        end
        else
        begin
            if(full)
                LED <= 1;
            else
            begin
                off_count <= off_count + 1;
                led_count <= led_count + (off_range + 1);
                if(&off_count)
                begin
                    off_range <= off_range + 1;
                    if(&off_range)
                        full <= 1;
                end
                LED <= led_count[8];
            end
        end
    end
     */
     
    reg [24:0] clk_count;
    reg [15:0] led_count;  
    reg ended;
    
    always @ (posedge clock)
    begin
        if (reset | ~state)
        begin
            clk_count <= 25'b0000000000000000000000000;
            led_count <= 16'b0000000000000000;
            ended <= 0;
            LED <= 0;
        end
        else
            if(ended)
                LED <= 1;
            else
                if(state)
                begin
                
                    if(&clk_count == 0)
                    begin
                        clk_count <= clk_count + 1;
                    end
                    else
                    begin
                        clk_count <= 25'b0000000000000000000000000;
                        led_count <= 16'b0000000000000000;
                        ended <= 1;
                    end
                    
                    led_count <= led_count + clk_count[24:22];
                    if(|led_count[15:8])
                    begin
                        led_count <= 16'b0000000000000000;
                        LED <= 1;
                    end
                    else
                        LED <= 0;
                        
                end
    end
    
endmodule
