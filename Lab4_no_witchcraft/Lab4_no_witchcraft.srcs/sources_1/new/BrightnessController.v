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
    
    reg [7:0] off_count;
    reg [7:0] off_range;
    
    always @ (posedge clock or posedge reset)
    begin
        if (reset | ~state)
        begin
            off_count <= 8'b00000000;
            off_range <= 8'b00000000;
            LED <= 0;
        end
        else
        begin
            if(&off_count == 1)
            begin
                if(&off_range != 1)
                begin
                    off_range <= off_range + 1;
                    off_count <= off_range;
                end
                LED <= 1;
            end
            else
            begin
                off_count <= off_count + 1;
                LED <= 0;
            end
        end
    end
     
endmodule
