`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2019 04:19:40 PM
// Design Name: 
// Module Name: ButtonInput
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


module ButtonInput(
    input clk,
    input left,
    input right,
    input up,
    input down,
    output reg [3:0] direction
    );
    
    always@ (posedge clk)
    begin
    
        if (left==1) begin //left movement, when button is pressed
        direction <= 4'b0001;
        end
    
        else if (right == 1) begin //right movement, when button is pressed
        direction <= 4'b0010;
        end
    
        else if (up == 1) begin //up movement, when button is pressed
        direction <= 4'b0100;
        end
        
        else if (down == 1) begin //down movement, when button is pressed
        direction <= 4'b1000;
        end
        
        else begin //keep previous direction, if no button is pressed
        direction <= direction;
        end
        
 end 
 
endmodule
