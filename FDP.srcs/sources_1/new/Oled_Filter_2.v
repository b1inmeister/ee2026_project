`timescale 1ns / 1ps

module Oled_Filter_2 (
    input clk6p25m, input [12:0] pixel_index, input [15:0] oled_data,
    input [6:0] col_start, input [6:0] col_end,
    input [5:0] row_start, input [5:0] row_end,
    output reg [15:0] filtered_data);
    
    wire [6:0] column;
    wire [5:0] row;
    
    assign column = pixel_index % 96;
    assign row = pixel_index / 96;
    
    always @ (posedge clk6p25m) begin
        if ((column >= col_start && column <= col_end) && 
            (row >= row_start && row <= row_end)) begin
            filtered_data <= oled_data;
        end else begin
            filtered_data <= 16'h0000;
        end
    end
    
endmodule
