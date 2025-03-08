`timescale 1ns / 1ps

module Colour_Return (
    input clk6p25m, input [12:0] pixel_index,
    input [6:0] xOffset, input [5:0] yOffset,
    output reg [15:0] oled_color);
    
    always @ (posedge clk6p25m) begin
        // Paint pixels to colour green
        if ((pixel_index / 96 < 10 + yOffset && pixel_index / 96 >= yOffset) && 
            (pixel_index % 96 < 10 + xOffset && pixel_index % 96 >= xOffset)) begin
            oled_color = 16'h07E0;
        // Paint pixels to colour red
        end else if ((pixel_index / 96 < 30 && pixel_index / 96 >= 0) && 
                     (pixel_index % 96 < 96 && pixel_index % 96 >= 66)) begin
            oled_color = 16'hF800;
        end else begin
            oled_color = 0;
        end
    end

endmodule
