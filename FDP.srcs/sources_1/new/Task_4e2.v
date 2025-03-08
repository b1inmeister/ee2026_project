`timescale 1ns / 1ps

module Task_4e2 (
    input clk, input [12:0] pixel_index,
    output [15:0] final_data_default
    );
    
    reg [15:0] current_color_default = 16'hFFFF;
    
    wire [15:0] filtered_data_left1, filtered_data_right1;
    
    Oled_Filter #(
        .COL_START(39),
        .COL_END(45),
        .ROW_START(5),
        .ROW_END(58)
        ) left_one (
        clk, pixel_index, 
        current_color_default, filtered_data_left1);
    
    Oled_Filter #(
        .COL_START(86),
        .COL_END(92),
        .ROW_START(5),
        .ROW_END(58)
        ) right_one (
        clk, pixel_index, 
        current_color_default, filtered_data_right1);

     Team_Number_Mux team_number_mux (
        filtered_data_left1, filtered_data_right1, 
        clk, final_data_default);
   
endmodule
