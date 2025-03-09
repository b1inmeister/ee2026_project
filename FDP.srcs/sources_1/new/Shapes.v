`timescale 1ns / 1ps

module Shape0 (
    input clk_1k, input btnC, input [2:0] state, input reset_shapes,
    output reg [6:0] col_start, output reg [6:0] col_end, 
    output reg [5:0] row_start, output reg [5:0] row_end, 
    output reg state0_end);
    
    initial begin
        col_start <= 85;
        col_end <= 94;
        row_start <= 0;
        row_end <= 10;
        state0_end <= 1'b0;
    end
    
    always @ (posedge clk_1k) begin
        if (reset_shapes) begin
            col_start <= 85;
            col_end <= 94;
            row_start <= 0;
            row_end <= 10;
            state0_end <= 1'b0;
        end else if (btnC && state == 3'b000)
            state0_end <= 1'b1;
    end
    
endmodule


module Shape1 (
    input clk_45, input [2:0] state, input reset_shapes, 
    output reg [6:0] col_start, output reg [6:0] col_end, 
    output reg [5:0] row_start, output reg [5:0] row_end, 
    output reg state1_end);
    
    initial begin
        col_start <= 85;
        col_end <= 94;
        row_start <= 0;
        row_end <= 10;
        state1_end <= 1'b0;
    end
    
    always @ (posedge clk_45) begin
        if (reset_shapes) begin
            col_start <= 85;
            col_end <= 94;
            row_start <= 0;
            row_end <= 10;
            state1_end <= 1'b0;
        end else if (row_end < 63 && state == 3'b001)
            row_end <= row_end + 1;
        else if (row_end >= 63 && state == 3'b001)
            state1_end <= 1'b1;
    end
    
endmodule


module Shape2 (
    input clk_45, input [2:0] state, input reset_shapes, 
    output reg [6:0] col_start, output reg [6:0] col_end, 
    output reg [5:0] row_start, output reg [5:0] row_end, 
    output reg state2_end);
    
    initial begin
        col_start <= 85;
        col_end <= 85;
        row_start <= 53;
        row_end <= 63;
        state2_end <= 1'b0;
    end
    
    always @ (posedge clk_45) begin
        if (reset_shapes) begin
            col_start <= 85;
            col_end <= 85;
            row_start <= 53;
            row_end <= 63;
            state2_end <= 1'b0;
        end else if (col_start > 47 && state == 3'b010)
            col_start <= col_start - 1;
        else if (col_start <= 47 && state == 3'b010)
            state2_end <= 1'b1;
    end
    
endmodule


module Shape3 (
    input clk_15, input [2:0] state, input reset_shapes, 
    output reg [6:0] col_start, output reg [6:0] col_end, 
    output reg [5:0] row_start, output reg [5:0] row_end, 
    output reg state3_end);
    
    initial begin
        col_start <= 47;
        col_end <= 57;
        row_start <= 53;
        row_end <= 63;
        state3_end <= 1'b0;
    end
    
    always @ (posedge clk_15) begin
        if (reset_shapes) begin
            col_start <= 47;
            col_end <= 57;
            row_start <= 53;
            row_end <= 63;
            state3_end <= 1'b0;
        end else if (row_start > 31 && state == 3'b011)
            row_start <= row_start - 1;
        else if (row_start <= 31 && state == 3'b011)
            state3_end <= 1'b1;
    end
    
endmodule


module Shape4 (
    input clk_15, input [2:0] state, input reset_shapes, 
    output reg [6:0] col_start, output reg [6:0] col_end, 
    output reg [5:0] row_start, output reg [5:0] row_end, 
    output reg state4_end);
    
    initial begin
        col_start <= 47;
        col_end <= 57;
        row_start <= 31;
        row_end <= 41;
        state4_end <= 1'b0;
    end
    
    always @ (posedge clk_15) begin
        if (reset_shapes) begin
            col_start <= 47;
            col_end <= 57;
            row_start <= 31;
            row_end <= 41;
            state4_end <= 1'b0;
        end else if (col_end < 71 && state == 3'b100)
            col_end <= col_end + 1;
        else if (col_end >= 71 && state == 3'b100)
            state4_end <= 1'b1;
    end
    
endmodule


module Shape5 (
    input clk_15, input [2:0] state, input reset_shapes, 
    output reg [6:0] col_start, output reg [6:0] col_end, 
    output reg [5:0] row_start, output reg [5:0] row_end, 
    output reg state5_end);
    
    initial begin
        col_start <= 61;
        col_end <= 71;
        row_start <= 31;
        row_end <= 41;
        state5_end <= 1'b0;
    end
    
    always @ (posedge clk_15) begin
        if (reset_shapes) begin
            col_start <= 61;
            col_end <= 71;
            row_start <= 31;
            row_end <= 41;
            state5_end <= 1'b0;
        end else if (row_start > 0 && state == 3'b101)
            row_start <= row_start - 1;
        else if (row_start <= 0 && state == 3'b101)
            state5_end <= 1'b1;
    end
    
endmodule


module Shape6 (
    input clk_15, input [2:0] state, input reset_shapes, 
    output reg [6:0] col_start, output reg [6:0] col_end, 
    output reg [5:0] row_start, output reg [5:0] row_end, 
    output reg state6_end);
    
    initial begin
        col_start <= 61;
        col_end <= 71;
        row_start <= 0;
        row_end <= 10;
        state6_end <= 1'b0;
    end
    
    always @ (posedge clk_15) begin
        if (reset_shapes) begin
            col_start <= 61;
            col_end <= 71;
            row_start <= 0;
            row_end <= 10;
            state6_end <= 1'b0;
        end else if (col_end < 85 && state == 3'b110)
            col_end <= col_end + 1;
        else if (col_end >= 85 && state == 3'b110)
            state6_end <= 1'b1;
    end
    
endmodule
