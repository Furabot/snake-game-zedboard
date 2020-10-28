`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2019 09:35:12 PM
// Design Name: 
// Module Name: Random
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


module VGAGenerator(
    input VGA_clk,
    output reg [9:0] randX,
    output reg [8:0] randY
    );
    
    reg [9:0] i = 0; //initial seed
    reg [9:0] j = 450;
    
    always @(posedge VGA_clk)
    begin
        if (i < 610)
            i <= i + 1'b1;
        else
            i <= 10'b0;
    end

    always @(posedge VGA_clk)
    begin
        if (j > 0)
            j <= j - 1'b1;
        else
            j <= 10'd480;
    endmodule
    
    always @(i,j)
    begin
        randX <= i;
        randY <= j;
    end
endmodule
