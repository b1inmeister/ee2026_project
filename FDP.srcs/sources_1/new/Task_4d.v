`timescale 1ns / 1ps

module Task_4d(
    input clk6p25m, input enable,
    input btnU, input btnD, input btnL, input btnR,
    input [12:0] pixel_index,
    output [15:0] final_data_4d);
   
    // input direction from buttons
    wire [3:0] direction;
    // reg for latching on the commands from mvtDirection
    reg [3:0] nextMovement;
    
    // Position of box
    reg [6:0] xOffset;
    reg [5:0] yOffset;
    
    // Boundaries
    parameter OOB_top = 0;
    parameter OOB_left = 0;
    parameter OOB_right = 86; 
    parameter OOB_bottom = 54; 
    
    integer count;
    reg reset_done;
    
    initial begin
        count = 0;
        xOffset = 0;
        yOffset = 54;
        reset_done = 0;
        nextMovement = 4'b0010;
    end
    
    always @ (posedge clk6p25m) begin 
        if (!enable) begin
            reset_done <= 0;
        end else if (enable && !reset_done) begin
            xOffset <= 0;
            yOffset <= 54;
            nextMovement <= 4'b0010;
            reset_done <= 1;
        end
    
        count <= count + 1;

        if (direction != 4'b0000) begin
            nextMovement <= direction;
        end
            
        if (count > 208332) begin
            count <= 0;
            
            case (nextMovement)
                4'b0001 : begin // Up
                    if (xOffset <= 56)
                        yOffset <= (yOffset > OOB_top) ? yOffset - 1 : yOffset;
                    else
                        yOffset <= (yOffset > 30) ? yOffset - 1 : yOffset;
                        nextMovement <= 4'b0001;
                end
                4'b0010 : begin // Left
                    xOffset <= (xOffset > OOB_left) ? xOffset - 1 : xOffset;
                    nextMovement <= 4'b0010; 
                end
                4'b0100 : begin // Right
                    if (yOffset >= 30)
                        xOffset <= (xOffset < OOB_right) ? xOffset + 1 : xOffset;
                    else
                        xOffset <= (xOffset < 56) ? xOffset + 1 : xOffset;
                        nextMovement <= 4'b0100;
                end
            4'b1000 : begin // Down
                    yOffset <= (yOffset < OOB_bottom) ? yOffset + 1 : yOffset;
                    nextMovement <= 4'b1000; 
                end
            endcase
        end
    end
    
    Colour_Return shader (
        clk6p25m, pixel_index, xOffset, yOffset, final_data_4d);
        
    Movement_Controller move (
        enable, btnU, btnD, btnL, btnR, direction);
    
endmodule
