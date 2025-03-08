`timescale 1ns / 1ps

module Task_4e3(
    input clk,
    output [6:0] seg, output dp, output [3:0] an
    );
    
    wire clk_segment;
    Clock_Divider #(100_000) clk_divide_segment (clk, clk_segment);
    
    Seven_Segment seven_segment (
       clk_segment, seg, dp, an);
       
endmodule
