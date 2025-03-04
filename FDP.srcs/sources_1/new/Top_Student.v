`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: KAM SHENG JIE
//  STUDENT B NAME: LEE MING KAI JOSHUA
//  STUDENT C NAME: RYAN TAN
//  STUDENT D NAME: LEE SEUNG-YOON
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clk, input reset,
    input button_top, input button_middle, button_bottom,
    output frame_begin, output sending_pixels, output sample_pixel,
    output [7:0] Jx);
    
    wire [12:0] pixel_index;
    wire [15:0] filtered_data_square1, filtered_data_square2, filtered_data_square3;
    wire [15:0] filtered_data_circle;
    wire [15:0] final_filtered_data;
    
    wire [15:0] current_color1, current_color2, current_color3;
    
    wire clk6p25m;
    Clock_Divider #(16) clk_divide(clk, clk6p25m);
    
    Color_Control color_control1 (
        clk6p25m, button_top, current_color1);
        
    Color_Control color_control2 (
        clk6p25m, button_middle, current_color2);
    
    Color_Control color_control3 (
        clk6p25m, button_bottom, current_color3);
     
    Oled_Filter #(
        .COL_START(42), 
        .COL_END(54),
        .ROW_START(3),
        .ROW_END(15)
        ) oled_square1 (
        clk6p25m, pixel_index, current_color1, filtered_data_square1);  
    
    Oled_Filter #(
        .COL_START(42),
        .COL_END(54),
        .ROW_START(18),
        .ROW_END(30)
        ) oled_square2 (
        clk6p25m, pixel_index, current_color2, filtered_data_square2);
        
    Oled_Filter #(
        .COL_START(42),
        .COL_END(54),
        .ROW_START(33),
        .ROW_END(45)
        ) oled_square3 (
        clk6p25m, pixel_index, current_color3, filtered_data_square3);
        
    Oled_Filter_Circle #(
        .CENTER_X(48),
        .CENTER_Y(54),
        .DIAMETER(14)
        ) oled_circle (
        clk6p25m, pixel_index, current_color3, filtered_data_circle);
        
    Pixel_Mux mux (
        filtered_data_square1, filtered_data_square2, filtered_data_square3, filtered_data_circle, 
        clk, final_filtered_data); 
        
    Oled_Display oled_display (
        clk6p25m, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, 
        final_filtered_data, Jx[0], Jx[1], Jx[3], Jx[4], Jx[5], Jx[6], Jx[7]);
   
endmodule