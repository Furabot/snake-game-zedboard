`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2019 11:25:01 AM
// Design Name: 
// Module Name: Snake
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


module Snake(
    input clk, reset, l, r, u, d, sw1, sw2, sw3,
    output reg [3:0] red, green, blue,
    output reg led1, led2, led3, led4, led5, led6, led7, led8, 
    output h_sync, v_sync
    ); 
    
    wire VGA_clk, update_clock, displayArea;
    wire [9:0] xCount;
    wire [9:0] yCount;
    wire [3:0] direction;
    wire [9:0] randX;
    wire [9:0] randomX;
    wire [8:0] randY;
    wire [8:0] randomY;
    wire r, g, b;
    wire lethal, nonlethal;
    reg apple;
    reg border;    
    reg good_coll, bad_coll;
    reg snake;
    reg gameOver;
    reg head;
    reg [9:0] appleX;
    reg [9:0] appleY;
    reg inX, inY;
    reg [9:0] snakeX[0:127];
    reg [9:0] snakeY[0:127];
    reg [4:0] size;
    reg found;
    reg snakebody;
    reg redlight;
    
    integer count1, count2, count3, applecount;
    
    ClockDivider divider(clk, VGA_clk);
    UpdateClock upd(clk, update_clock);
    VGA_Generator vga(VGA_clk, xCount, yCount, displayArea, h_sync, vsync);
    Random ran(VGA_clk, randX, randY);
    ButtonInput ip(clk, l, r, u, d, direction);
    
    //default snake co-ordinates
    initial begin 
        snakeX[0] = 10'd20;
        snakeY[0] = 10'd20;
    end
    
    //apple size set to 20x20px
    always @(posedge VGA_clk) 
    begin
        inX <= (xCount > appleX && xCount < (appleX + 20));
        inY <= (yCount > appleY && yCount < (appleY + 20));
        apple <= inX && inY;
    end
    
    //changing borders based on switch inputs
    always @(posedge VGA_clk)  
    begin
    casex ({sw1, sw2, sw3})
        3'b100 : border <= ((xCount >= 0) && (xCount < 15) && ((yCount >= 180) && (yCount < 320)));
        3'bx10 : border <= ((xCount >= 0) && (xCount < 15) && ((yCount >= 0) && (yCount < 180)));
        3'bxx1 : border <= (((xCount >= 0) && (xCount < 15)) || ((xCount >= 630) && (xCount < 641)));
        default: border <= ((yCount >= 0) && (yCount < 15) || ((yCount >= 465) && (yCount < 481)));
    endcase
    end
    
    //default apple position and randomisation
    always @(posedge VGA_clk) 
    begin
        applecount = applecount + 1; //number of apples eaten
        if(applecount == 1)
        begin
            appleX <= 300;
            appleY <= 300;
        end
        
        else
        begin
            if(good_coll)
            begin
                if((randX < 30) || (randX > 610) || (randY < 30) || (randY >450)) //ensuring that apple does not spawn in the border
                begin
                    appleX <= 40;
                    appleY <= 30;
                end
                
                else
                begin
                    appleX <= randX;
                    appleY <= randY;
                end
            end
            
            else if(reset)
            begin
                if((randX < 30) || (randX > 610) || (randY < 10) || (randY >450))
                begin
                    appleX <= 300;
                    appleY <= 300;
                end
                
                else
                begin
                    appleX <= randX;
                    appleY <= randY;
                end
            end
        end
    end
    
    //snake properties
    always @(posedge update_clock) 
    begin 
        if(~reset) //limiting snake size
        begin
            for(count1 = 127; count1 > 0; count1 = count1 - 1)
            begin
                if(count1 <= size - 1)
                begin
                    snakeX[count1] = snakeX[count1 - 1];
                    snakeY[count1] = snakeY[count1 - 1];
                end
            end
        end
        
        else if(reset)
        begin
            for(count3 = 1; count3 < 128; count3 = count3 + 1)
            begin
                snakeX[count3] = 700;
                snakeY[count3] = 500;
            end
        snakeX[0] = 20;
        snakeY[0] = 20;
        end

        //directing the snake to move by 10px
        begin 
        if(direction == 4'b0001) //left
            snakeX[0] = snakeX[0] - 10;
        else if(direction == 4'b0010) //right
            snakeX[0] = snakeX[0] + 10;
        else if(direction == 4'b0100) //down
            snakeY[0] = snakeY[0] - 10;
        else if(direction == 4'b1000) //up
            snakeY[0] = snakeY[0] + 10;
        end
    end
    
    //defining head size
    always @(posedge VGA_clk)
    begin
        head <= ((xCount > snakeX[0] && xCount < (snakeX[0] +10)) && (yCount > snakeY[0] && ycount < (snakeY[0] + 10)));
    end
    
    //defining snake body
    always @(posedge VGA_clk) 
    begin
    found = 0;
        for(count2 = 1; count2 < size; count2 = count2 + 1)
        begin
            if(~found)
            begin
                snakebody <= ((xCount > snakeX[count2] && xCount < (snakeX[count2] + 10)) && (yCount > snakeY[count2] && yCount < (snakeY[count2] + 10)));
                found = snakebody;
            end
        end
    end
    
    //flags
    assign lethal = border || snakebody; //snake touches body/border
    assign nonlethal = apple; //snake touches apple
    
    always @(posedge VGA_clk) //good collision condition
    begin
        if(nonlethal && head)
        begin
            good_coll <= 1;
            size = size + 1;
        end
        
        else if(reset)
            size = 1;
            
        else
            good_coll = 0;
    end
    
    always @(posedge VGA_clk) //bad collision condition
    begin
        if(lethal && head)
            bad_coll <= 1;
            
        else
            bad_coll = 0;
    end
    
    always @(posedge VGA_clk) //game over condition
    begin
        if(bad_coll)
            gameOver <= 1;
            
        else if(reset)
            gameOver = 0;
    end
    
    //LED lights flash when game over
    always @(posedge update_clock)
    begin
        ledlight <= ~ ledlight;
    end
    
    always @(posedge VGA_clk)
    begin
        if(gameOver)
        begin
            case(ledlight)
                1'b0 : {led1, led2, led3, led4, led5, led6, led7, led8} = 8'b00000000;
                1'b1 : {led1, led2, led3, led4, led5, led6, led7, led8} = 8'b11111111;
            endcase
        end
        
        if(reset)
            {led1, led2, led3, led4, led5, led6, led7, led8} = 8'b00000000;
    end
    
    //display colours on the screen
    assign r = (displayArea && (apple || gameOver)); //apple and gameover colour
    assign g = (displayArea && ((head || snakebody) && (~gameOver)));//snake colour
    assign b = (displayArea && (border && ~gameOver)); //border colour
    
    //declaring colours as 4-bit to interface with FPGA
    always @(posedge VGA_clk)
    begin
        red = {4{r}};
        green = {4{g}};
        blue = {4{b}};
    end
endmodule
