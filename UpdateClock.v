`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2019 03:59:32 PM
// Design Name: 
// Module Name: UpdateClock
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


module UpdateClock( //25Hz clock for game speed
    input clk,
    output reg update_clk
    );
    
    reg [21:0] check;
    
    always@(posedge clk)
    begin
        if(check < 4000000)
        begin
            check <= check + 1;
            update_clk <= 0;
        end
        
        else
        begin
            check <= 0;
            update_clk <= 1;
        end
end
endmodule
