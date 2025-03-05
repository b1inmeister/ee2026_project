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
    input clk, input [15:0] sw,
    input btnC, input btnU, input btnD, 
    //input btnL, input btnR,
    output [15:0] led, 
    //output [6:0] seg, output dp, output [3:0] an,
    output frame_begin, output sending_pixels, output sample_pixel,
    output [7:0] JC);
    
    reg reset = 1'b0;
    
    wire clk6p25m;
    Clock_Divider #(16) clk_divide(clk, clk6p25m);
    
    wire [12:0] pixel_index;
    
    /*
     * TASK 4.B
     */
    wire [15:0] filtered_data_top, filtered_data_middle, filtered_data_bottom;
    wire [15:0] filtered_data_circle;
    wire [15:0] final_filtered_data_4b;
    
    wire [15:0] current_color_top, current_color_middle, current_color_bottom;
    wire [15:0] current_color_circle;
    
    wire [2:0] color_state_top, color_state_middle, color_state_bottom;
    
    // top square
    Color_Control color_top_4b (
        clk, btnU, color_state_top, current_color_top);
        
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
        clk, btnC, color_state_middle, current_color_middle);
   
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
        clk, btnD, color_state_bottom, current_color_bottom);
        
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
        clk, final_filtered_data_4b);
  
    /*
     * TASK 4.E1
     */  
    assign led = sw; 
     
    /*
     * TASK 4.E2
     */
    reg [15:0] current_color_default = 16'hFFFF;
    
    wire [15:0] filtered_data_left1, filtered_data_right1;
    wire [15:0] final_filtered_data_default;
    
    Oled_Filter #(
        .COL_START(41),
        .COL_END(45),
        .ROW_START(5),
        .ROW_END(58)
        ) left_one (
        clk, pixel_index, 
        current_color_default, filtered_data_left1);
    
    Oled_Filter #(
        .COL_START(88),
        .COL_END(92),
        .ROW_START(5),
        .ROW_END(58)
        ) right_one (
        clk, pixel_index, 
        current_color_default, filtered_data_right1);

     Team_Number_Mux team_number_mux (
        filtered_data_left1, filtered_data_right1, 
        clk, final_filtered_data_default);
    
    /*
     * task 4.E3
     */
     
     
    
  
    /*
     * TASK 4.E4
     */
     
     /*
     wire [15:0] oled_data;
     
     Oled_Data_Mux oled_data_mux (
        sw, final_filtered_data_4b, final_filtered_data_default, oled_data);
        */
     
     
    Oled_Display oled_display (
        clk6p25m, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, 
        final_filtered_data_default, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7]);

endmodule