`timescale 1ns / 1ps

module Task_4b (
    input clk, input enable,
    input btnU, input btnC, input btnD,
    input [12:0] pixel_index,
    output [15:0] final_data_4b
    );
    
    wire [15:0] filtered_data_top, filtered_data_middle, filtered_data_bottom;
    wire [15:0] filtered_data_circle;
        
    wire [15:0] current_color_top, current_color_middle, current_color_bottom;
    wire [15:0] current_color_circle;
        
    wire [2:0] color_state_top, color_state_middle, color_state_bottom;
            
    // top square
    Color_Control color_top_4b (
        clk, enable, btnU, color_state_top, current_color_top);
            
    Oled_Filter #(
        .COL_START(42), 
        .COL_END(54),
        .ROW_START(3),
        .ROW_END(15)
        ) top_square_4b (
        clk, pixel_index, 
        current_color_top, filtered_data_top); 
                    
    // middle square    
    Color_Control color_middle_4b (
        clk, enable, btnC, color_state_middle, current_color_middle);
       
    Oled_Filter #(
        .COL_START(42),
        .COL_END(54),
        .ROW_START(18),
        .ROW_END(30)
        ) middle_square_4b (
        clk, pixel_index, 
        current_color_middle, filtered_data_middle);   
         
    // bottom square   
    Color_Control color_bottom_4b (
        clk, enable, btnD, color_state_bottom, current_color_bottom);
            
    Oled_Filter #(
        .COL_START(42),
        .COL_END(54),
        .ROW_START(33),
        .ROW_END(45)
        ) bottom_square_4b (
        clk, pixel_index, 
        current_color_bottom, filtered_data_bottom);
        
    // circle    
    Color_Control_Circle color_circle_4b (
        clk, color_state_top, color_state_middle, 
        color_state_bottom, current_color_circle);
        
    Oled_Filter_Circle #(
        .CENTER_X(48),
        .CENTER_Y(54),
        .DIAMETER(14)
        ) circle_4b (
        clk, pixel_index, current_color_circle, filtered_data_circle);
        
    // display squares + circle on OLED   
    Pixel_Mux pixel_mux_4b (
        filtered_data_top, filtered_data_middle, 
        filtered_data_bottom, filtered_data_circle, 
        clk, final_data_4b);
        
endmodule
