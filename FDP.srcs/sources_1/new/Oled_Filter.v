`timescale 1ns / 1ps

module Oled_Filter #(
    parameter COL_START = 0,
    parameter COL_END = 95,
    parameter ROW_START = 0,
    parameter ROW_END = 63
    )(
    input clk, input [12:0] pixel_index, input [15:0] oled_data,
    output reg [15:0] filtered_data);
    
    wire [6:0] column;
    wire [5:0] row;
    
    assign column = pixel_index % 96;
    assign row = pixel_index / 96;
    
    always @ (posedge clk) begin
        if ((column >= COL_START && column <= COL_END) && 
            (row >= ROW_START && row <= ROW_END)) begin
            filtered_data <= oled_data;
        end else begin
            filtered_data <= 16'h0000;
        end
    end
    
endmodule
