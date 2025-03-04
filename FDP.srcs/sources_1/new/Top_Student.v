`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME: LEE MING KAI JOSHUA
//  STUDENT C NAME: 
//  STUDENT D NAME: LEE SEUNG-YOON
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clk, input reset,
    output frame_begin, output sending_pixels, output sample_pixel,
    output [7:0] Jx);
    
    wire [12:0] pixel_index;
    wire [15:0] filtered_data_square1;
    wire [15:0] filtered_data_square2;
    wire [15:0] filtered_data_square3;
    wire [15:0] final_filtered_data;
    
    wire clk6p25m;
    Clock_Divider #(16) clk_divide(clk, clk6p25m);
    
    reg [15:0] oled_data = 16'hFFFF;
     
    Oled_Filter #(
        .COL_START(42), 
        .COL_END(54),
        .ROW_START(3), 
        .ROW_END(15)
        ) oled_filter1 (
        clk6p25m, pixel_index, oled_data, filtered_data_square1);  
    
    Oled_Filter #(
        .COL_START(42), 
        .COL_END(54),
        .ROW_START(18), 
        .ROW_END(30)
        ) oled_filter2 (
        clk6p25m, pixel_index, oled_data, filtered_data_square2);
        
    Oled_Filter #(
        .COL_START(42), 
        .COL_END(54),
        .ROW_START(33), 
        .ROW_END(45)
        ) oled_filter3 (
        clk6p25m, pixel_index, oled_data, filtered_data_square3);
        
    Pixel_Mux mux (
        filtered_data_square1, filtered_data_square2, filtered_data_square3, 
        clk, final_filtered_data); 
    
    Oled_Display oled_display (
        clk6p25m, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, 
        final_filtered_data, Jx[0], Jx[1], Jx[3], Jx[4], Jx[5], Jx[6], Jx[7]);
   
endmodule