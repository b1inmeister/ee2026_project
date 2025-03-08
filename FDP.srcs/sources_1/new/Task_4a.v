`timescale 1ns / 1ps

module Task_4a (
    input clk, input clk6p25m, input enable,
    input btnC, input btnU, input btnD,
    input [12:0] pixel_index,
    output reg [15:0] final_data_4a);
    
    localparam INITIAL_OUTER_DIAMETER = 30;
    localparam INITIAL_INNER_DIAMETER = 25;
    localparam MAX_OUTER_DIAMETER = 50;
    localparam MIN_OUTER_DIAMETER = 10;
    localparam CENTER_X = 48;
    localparam CENTER_Y = 32;
       
    wire [8:0]x;
    wire [7:0]y;
    reg enable_circle = 0;
        
    wire debounced_btnU, debounced_btnD, debounced_btnC;
    reg prev_btnU;
    reg prev_btnD;
        
    reg [6:0]outer_diameter = INITIAL_OUTER_DIAMETER;
    reg [6:0]inner_diameter = INITIAL_INNER_DIAMETER;
    
    Debouncer d1(clk, btnU, debounced_btnU);
    Debouncer d2(clk, btnD, debounced_btnD);
    Debouncer d3(clk, btnC, debounced_btnC);
    
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    always @(posedge clk6p25m) begin
        if (!enable) begin   
            if ((x > 1 && x < 5 && y > 1 && y < 62) || 
                (x > 90 && x < 94 && y > 1 && y < 62) || 
                (y > 1 && y < 5 && x > 1 && x < 94) || 
                (y > 58 && y < 62 && x > 1 && x < 94)) begin
                final_data_4a <= 16'hF800;
            end else begin
                final_data_4a <= 16'h0000;
            end
        end else begin
            if ((x > 1 && x < 5 && y > 1 && y < 62) || 
                (x > 90 && x < 94 && y > 1 && y < 62) || 
                (y > 1 && y < 5 && x > 1 && x < 94) || 
                (y > 58 && y < 62 && x > 1 && x < 94)) begin
                final_data_4a <= 16'hF800;
            end else if (((x - CENTER_X)*(x - CENTER_X) + (y - CENTER_Y)*(y - CENTER_Y) < 
                          (outer_diameter * outer_diameter) / 4) && 
                         ((x - CENTER_X)*(x - CENTER_X) + (y - CENTER_Y)*(y - CENTER_Y) > 
                          (inner_diameter * inner_diameter) / 4)&& enable_circle) begin
                final_data_4a <= 16'h07E0; 
            end else begin
                final_data_4a <= 16'h0000;
            end
        end
    end
    
    always @(posedge clk6p25m) begin
        if (enable) begin
            if (debounced_btnU && prev_btnU == 0) begin
                if (outer_diameter < MAX_OUTER_DIAMETER) begin
                    outer_diameter <= outer_diameter + 5;
                    inner_diameter <= inner_diameter + 5;
                end
            end else if (debounced_btnD && prev_btnD == 0) begin
                if (outer_diameter > MIN_OUTER_DIAMETER) begin
                    outer_diameter <= outer_diameter - 5;
                    inner_diameter <= inner_diameter - 5;
                end   
            end else if (debounced_btnC && enable) begin
                enable_circle <= 1;
            end
        
            prev_btnU = debounced_btnU;
            prev_btnD = debounced_btnD;
        end else begin
            enable_circle <= 0;
            outer_diameter <= INITIAL_OUTER_DIAMETER;
            inner_diameter <= INITIAL_INNER_DIAMETER;
        end
    end
    
endmodule
