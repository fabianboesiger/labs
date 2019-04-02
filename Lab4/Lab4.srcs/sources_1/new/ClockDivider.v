`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2019 08:22:59
// Design Name: 
// Module Name: ClockDivider
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


module ClockDivider(
    input clk,
    input rst,
    output clk_en
    );
    
    reg [24:0] clk_count;
    
    always @ (posedge clk)
    begin
        if (rst)
            clk_count <= 0;
        else
            clk_count <= clk_count + 1;
    end
    
    assign clk_en = &clk_count;
    
endmodule
