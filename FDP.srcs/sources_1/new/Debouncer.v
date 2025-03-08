`timescale 1ns / 1ps

module Debouncer (
    input clk, input button_in, 
    output reg button_out);
    
    wire clk1ms;
    
    reg enable = 1;
    reg [8:0] counter = 0;
    reg counter_start = 0;
    
    Clock_Divider #(100000) clk_div (clk, clk1ms);
    
    always @ (posedge clk1ms) begin    
        if (button_in && enable) begin
            button_out <= 1;
            enable <= 0;
            counter <= 0;
        end else begin
            button_out <= 0;
        end
        
        if (!enable && button_in == 0) begin
            counter <= counter + 1;
            
            if (counter >= 20) begin
                enable <= 1;
                counter <= 0;
            end
        end
    end

endmodule
