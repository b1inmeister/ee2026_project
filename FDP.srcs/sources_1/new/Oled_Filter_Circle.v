`timescale 1ns / 1ps

module Oled_Filter_Circle #(
    parameter CENTER_X = 48,
    parameter CENTER_Y = 32,
    parameter DIAMETER = 40
    )(
    input clk6p25m, input [12:0] pixel_index, input [15:0] oled_data,
    output reg [15:0] filtered_data);

    wire [6:0] column;
    wire [5:0] row;
    localparam RADIUS_SQ = (DIAMETER / 2) * (DIAMETER / 2);

    assign column = pixel_index % 96;
    assign row = pixel_index / 96;

    always @ (posedge clk6p25m) begin
        if (((column - CENTER_X) * (column - CENTER_X) + 
            (row - CENTER_Y) * (row - CENTER_Y)) <= RADIUS_SQ) begin
            filtered_data <= oled_data;
        end else begin
            filtered_data <= 16'h0000;
        end
    end

endmodule
