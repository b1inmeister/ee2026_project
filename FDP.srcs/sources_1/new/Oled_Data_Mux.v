`timescale 1ns / 1ps

module Oled_Data_Mux (
    input clk, input [15:0] sw, 
    input [15:0] final_data_4a, input [15:0] final_data_4b,
    input [15:0] final_data_4c, input [15:0] final_data_4d,
    input [15:0] final_data_default,
    output reg enable, output reg [15:0] oled_data);
    
    always @ (posedge clk) begin
        // SW12, 9. 8. 6. 2, 0
        if (sw == 16'b0001001101000101) begin
            enable <= 1;
            oled_data <= final_data_4a;
        //  SW13, 9, 5, 2, 0
        end else if (sw == 16'b0010001000100101) begin
            enable <= 1;
            oled_data <= final_data_4b;
        // SW14, 9, 7, 5, 2, 1, 0
        end else if (sw == 16'b0100001010100111) begin
            enable <= 1;
            oled_data <= final_data_4c;
        // SW15, 9, 7, 4, 2, 1, 0
        end else if (sw == 16'b1000001010010111) begin 
            enable <= 1;
            oled_data <= final_data_4d;
        end else begin
            enable <= 0;
            oled_data <= final_data_default;
        end
    end

endmodule
