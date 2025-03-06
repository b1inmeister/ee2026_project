`timescale 1ns / 1ps

module Color_Control (
    input clk, input button,
    output reg [2:0] color_state,
    output reg [15:0] current_color);
    
    // define colour states using parameters
    parameter WHITE = 3'b000,
                RED = 3'b001,
              GREEN = 3'b010,
               BLUE = 3'b011,
             ORANGE = 3'b100,
              BLACK = 3'b101;
    
    // button press detection
    reg button_last;
    reg stable_button;
    reg button_pressed;
    
    // debouncing counter
    reg [7:0] debounce_counter;
    reg debounce_active;
    
    // clock divider
    reg [16:0] clk_divider;
    reg tick_1ms;
    
    always @ (posedge clk) begin;
        if (clk_divider == 10000) begin
            clk_divider <= 0;
            tick_1ms <= 1;
        end else begin
            clk_divider <= clk_divider + 1;
            tick_1ms <= 0;
        end
    end
    
    // debouncing logic
    always @ (posedge clk) begin
        if (!debounce_active) begin
            if (button != stable_button) begin
                debounce_active <= 1;
                debounce_counter <= 0;
            end
        end else if (tick_1ms && debounce_active) begin
            if (debounce_counter < 200) begin
                debounce_counter <= debounce_counter + 1;
            end else begin
                debounce_active <= 0;
                stable_button <= button;
            end
        end
     end
     
     // colour state logic
     always @ (posedge clk) begin
        if (button_pressed && !debounce_active) begin
            case (color_state)
                WHITE: color_state <= RED;
                RED: color_state <= GREEN;
                GREEN: color_state <= BLUE;
                BLUE: color_state <= ORANGE;
                ORANGE: color_state <= BLACK;
                BLACK: color_state <= WHITE;
                default: color_state <= WHITE;
            endcase
        end
     end
     
     // output colour for squares
     always @ (*) begin
        case (color_state)
            WHITE: current_color = 16'hFFFF;
            RED: current_color = 16'hF800;
            GREEN: current_color = 16'h07E0;
            BLUE: current_color = 16'h001F;
            ORANGE: current_color = 16'hFC40;
            BLACK: current_color = 16'h0000;
        endcase
     end
     
     // edge detection (for stable_button)
     always @ (posedge clk) begin
         if (stable_button && !button_last) begin
             button_pressed <= 1;
         end else begin
             button_pressed <= 0;
         end
         button_last <= stable_button;
     end

endmodule
