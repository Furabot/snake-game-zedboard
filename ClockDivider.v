`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2019 03:59:32 PM
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


module ClockDivider( //25MHz clock for VGA
    input clk,
    output reg VGA_clk
    );
    
    integer max_bit = 4;
    integer clk_count = 0; 
    
    always@(posedge clk)
    begin
        if(clk_count < max_bit)
        begin
            clk_count <= clk_count + 1
            VGA_clk <= 0;
        end
        
        else
        begin
            clk_count <= 0;
            VGA_clk <= 1;
        end
    end
endmodule
