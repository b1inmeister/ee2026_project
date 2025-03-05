`timescale 1ns / 1ps

module Team_Number_Mux(
    input [15:0] filtered_data_1, input [15:0] filtered_data_2,
    input clk, 
    output reg [15:0] final_filtered_data);

    always @ (posedge clk) begin
        if (filtered_data_1 != 16'h0000) begin
            final_filtered_data <= filtered_data_1;
        end else if (filtered_data_2 != 16'h0000) begin
            final_filtered_data <= filtered_data_2;
        end else begin
            final_filtered_data <= 16'h0000;
        end
    end  

endmodule
