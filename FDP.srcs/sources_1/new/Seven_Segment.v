`timescale 1ns / 1ps

module Seven_Segment (
    input clk_segment,
    output reg [6:0] seg, output reg dp,  output reg [3:0] an);
    
    reg [2:0] counter = 0;
    reg [6:0] clk_div = 0;
    
    reg [6:0] seg_s = 7'b0010010;
    reg [6:0] seg_1 = 7'b1111001;
    
    always @ (posedge clk_segment) begin
        counter <= counter + 1;
    end
     
    always @ (*) begin
        case (counter)
            2'b00: begin seg = seg_s; dp = 1'b1; an = 4'b0111; end
            2'b01: begin seg = seg_1; dp = 1'b0; an = 4'b1011; end
            2'b10: begin seg = seg_1; dp = 1'b1; an = 4'b1101; end
            2'b11: begin seg = seg_1; dp = 1'b1; an = 4'b1110; end
            default: begin seg = 7'b0; dp = 1'b0; an = 4'b1111; end
        endcase
    end
    
endmodule
