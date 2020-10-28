`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2019 09:51:24 PM
// Design Name: 
// Module Name: VGA_Generator
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


module VGA_Generator(
    input VGA_clk, //required clock: 25MHz
    output reg[9:0] hcount,
    output reg[9:0] vcount,
    output reg displayArea,
    output hsync,
    output vsync
    );
    
    reg hsync_reg,vsync_reg;
    
    integer HDisplay = 640; //horizontal display line
    integer HFP = 16; //horizontal front porch
    integer HRT = 96; //horizontal sync
    integer HMAX = 800; //max horizontal lines
    integer VDisplay = 480; //verical display line
    integer VFP = 10; //vertical front porch
    integer VRT = 2; //vertical sync 
    integer VMAX = 525; //max vertical lines
    
    always @(posedge VGA_clk)
    begin
        if(hcount==HMAX)
          hcount <= 0;
        else
          hcount <= hcount+1'b1;
    end
    
    always @(posedge VGA_clk)
    begin
    if(hcount==HMAX)
        begin
        if(vcount==VMAX)
          vcount <= 0;
        else
          vcount <= vcount+1'b1;
        end
    end
    
    always @(posedge VGA_clk)
    begin
        displayArea <= ((hcount<HDisplay) && (vcount<VDisplay));
    end
    
    always @(posedge VGA_clk)
    begin
        hsync_reg <= ((hcount>=(HDisplay+HFP)) && (hcount<(HDisplay+HFP+HRT)));
        vsync_reg <= ((vcount>=(VDisplay+VFP)) && (vcount<(VDisplay+VFP+VRT)));
    end
    
    assign hsync = ~hsync_reg;
    assign vsync = ~vsync_reg;
    
endmodule
