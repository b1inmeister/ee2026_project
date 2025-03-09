`timescale 1ns / 1ps

module Color_Control_Circle (
    input clk, input [2:0] color_state_1, 
    input [2:0] color_state_2, input [2:0] color_state_3,
    output reg [15:0] current_color_circle);
    
    // define colour states using parameters
    parameter WHITE = 3'b000,
                RED = 3'b001,
              GREEN = 3'b010,
               BLUE = 3'b011,
             ORANGE = 3'b100,
              BLACK = 3'b101;
            
    reg [2:0] color_state_circle;
    
    // circle color logic
    always @ (posedge clk) begin
       if (color_state_1 == RED && color_state_2 == RED && color_state_3 == RED) begin
           color_state_circle = RED;
       end else if (color_state_1 == ORANGE && color_state_2 == ORANGE && color_state_3 == ORANGE) begin
           color_state_circle = ORANGE;
       end else begin
           color_state_circle = BLACK;
       end
    end
    
    // output colour for circle
    always @ (*) begin
       case (color_state_circle)
           RED: current_color_circle = 16'hF800;
           ORANGE: current_color_circle = 16'hFC40;
           BLACK: current_color_circle = 16'h0000;
           default: current_color_circle = 16'h0000;
        endcase
    end

endmodule
