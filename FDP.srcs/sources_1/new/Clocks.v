`timescale 1ns / 1ps

module Clk_Div_1k (
    input clk, output reg clk_1k);
    
    reg [15:0] count;
    
    initial begin
        clk_1k = 1'b0;
        count = 16'b0;
    end
    
    always @ (posedge clk) begin
        count <= (count == 49999) ? 0 : count + 1;
        clk_1k <= (count == 0) ? ~clk_1k : clk_1k;
    end
    
endmodule


module Clk_Div_45 (
    input clk, output reg clk_45);
    
    reg [20:0] count;
    
    initial begin
        clk_45 = 1'b0;
        count = 21'b0;
    end
    
    always @ (posedge clk) begin
        count <= (count == 1111110) ? 0 : count + 1;
        clk_45 <= (count == 0) ? ~clk_45 : clk_45;
    end
    
endmodule


module Clk_Div_15 (
    input clk, output reg clk_15);
    
    reg [21:0] count;
    
    initial begin
        clk_15 = 1'b0;
        count = 22'b0;
    end
    
    always @ (posedge clk) begin
        count <= (count == 3333332) ? 0 : count + 1;
        clk_15 <= (count == 0) ? ~clk_15 : clk_15;
    end
    
endmodule
