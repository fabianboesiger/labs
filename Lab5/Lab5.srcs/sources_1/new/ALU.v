`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 09:06:28
// Design Name: 
// Module Name: ALU
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


module ALU( 
    input [3:0] op,
    input [31:0] a, 
    input [31:0] b,
    output zero,
    output [31:0] out
    );
    
    //arithmetic
    
    wire [31:0] w1;
    Mux m1 (op[1], ~b, b, w1);
    
    wire [31:0] w2;
    Adder a1 (op[1], a, w1, w2);
   
   wire [31:0] w3;
   Extend e1 (w2[31], w3); 
   
   wire [31:0] w4;
   Mux m2 (op[3], w3, w2, w4);
  
    //logic
    wire [31:0] w5;
    assign w5 = a&b;
    
    wire [31:0] w6;
    assign w6 = a | b;
    
    wire [31:0] w7;
    assign w7 = a ^ b;
    
    wire [31:0] w8;
    assign w8 =  ~(a | b);
    
    wire [31:0] w9;
    Mux m3 (op[0], w6, w5, w9);
    
    wire [31:0] w10;
    Mux m4 (op[0], w8, w7, w10);
    
    wire [31:0] w11;
    Mux m5 (op[1], w10, w9, w11);
    
    //output
    wire [31:0] w12;
    Mux m6 (op[2], w11, w4, w12);
    
    assign out = w12;
    assign zero = ~(|w12);
    
endmodule
