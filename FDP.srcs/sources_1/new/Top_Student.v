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
    input btnC, input btnU, input btnD, input btnL, input btnR,
    output [15:0] led, 
    output [6:0] seg, output dp, output [3:0] an,
    output frame_begin, output sending_pixels, output sample_pixel,
    output [7:0] JC);
    
    reg reset = 1'b0;
    
    wire clk6p25m;
    Clock_Divider #(16) clk_divide_6p25m (clk, clk6p25m);
    
    wire [12:0] pixel_index;
    wire [15:0] oled_data;
    wire [15:0] final_data_4a, final_data_4b, final_data_4c, final_data_4d, final_data_default;
    wire enable_4a, enable_4b, enable_4c, enable_4d;

    // TASK 4.A 
    Task_4a task_4a (
        clk, clk6p25m, enable_4a, btnC, btnU, btnD, pixel_index,
        final_data_4a);

    // TASK 4.B
    Task_4b task_4b (
        clk, enable_4b, btnU, btnC, btnD, pixel_index, 
        final_data_4b);
        
    // TASK 4.C
    assign final_data_4c = reset;

    // TASK 4.D
    Task_4d task_4d (
        clk6p25m, enable_4d, btnU, btnD, btnL, btnR, pixel_index,
        final_data_4d);

    // TASK 4.E1 AND 4.E5
    Led_Controller led_controller (
        clk, sw, led);
     
    // TASK 4.E2
    Task_4e2 default_display (
        clk, pixel_index, final_data_default); 
    
    // TASK 4.E3
    Task_4e3 seven_segment (
        clk, seg, dp, an);
  
    // TASK 4.E4
    Oled_Data_Mux oled_data_mux (
       clk, sw, 
       final_data_4a, final_data_4b, final_data_4c, final_data_4d, final_data_default, 
       enable_4a, enable_4b, enable_4c, enable_4d,
       oled_data);

     // OLED DISPLAY
     Oled_Display oled_display (
        clk6p25m, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, 
        oled_data, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7]);

endmodule