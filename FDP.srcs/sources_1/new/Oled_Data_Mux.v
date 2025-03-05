`timescale 1ns / 1ps

module Oled_Data_Mux (
    input sw, input [15:0] final_filtered_data_4b, input [15:0] final_filtered_data_default,
    output reg [15:0] oled_data);
    
    always @ (*) begin 
        case (sw)
            16'b0010001000100100: oled_data <= final_filtered_data_4b;
            default: oled_data <= final_filtered_data_default;
        endcase
    end

endmodule
