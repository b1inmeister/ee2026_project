`timescale 1ns / 1ps

module Movement_Controller (
    input enable,
    input btnU, input btnD,
    input btnL, input btnR,
    output reg [3:0] direction);
    
    always @ (btnU, btnL, btnR, btnD) begin
        if (enable) begin
        
        if (btnU) begin
            direction <= 4'b0001;
        end else if (btnL) begin
            direction <= 4'b0010;
        end else if (btnR) begin
            direction <= 4'b0100;
        end else if (btnD) begin
            direction <= 4'b1000;
        end else begin
            direction <= 4'b0000;
        end
        
        end
    end
    
endmodule
