`timescale 1ns / 1ps

module States_Mux (
    input clk6p25m, input [2:0] state,
    input [15:0] state_0_data, input [15:0] state_1_data, 
    input [15:0] state_2_data, input [15:0] state_3_data, 
    input [15:0] state_4_data, input [15:0] state_5_data, 
    input [15:0] state_6_data, 
    output reg [15:0] data);
        
    always @ (posedge clk6p25m) begin
        if (state == 3'b000)
            data <= state_0_data;
        else if (state == 3'b110 && state_5_data == 16'h0000 && 
                state_4_data == 16'h0000 && state_3_data == 16'h0000 && 
                state_2_data == 16'h0000 && state_1_data == 16'h0000)
            data <= state_6_data;
        else if ((state == 3'b110 || state == 3'b101) && 
                state_4_data == 16'h0000 && state_3_data == 16'h0000 && 
                state_2_data == 16'h0000 && state_1_data == 16'h0000)
            data <= state_5_data;
        else if ((state == 3'b110 || state == 3'b101 || 
                state == 3'b100) && state_3_data == 16'h0000 && 
                state_2_data == 16'h0000 && state_1_data == 16'h0000)
            data <= state_4_data;
        else if ((state == 3'b110 || state == 3'b101 || 
                state == 3'b100 || state == 3'b011) && 
                state_2_data == 16'h0000 && state_1_data == 16'h0000)
            data <= state_3_data;
        else if ((state == 3'b110 || state == 3'b101 || 
                state == 3'b100 || state == 3'b011 || 
                state == 3'b010) && state_1_data == 16'h0000)
            data <= state_2_data;
        else
            data <= state_1_data;
    end

endmodule
