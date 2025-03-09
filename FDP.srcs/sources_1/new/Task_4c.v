`timescale 1ns / 1ps

module Task_4c (
    input clk, input clk6p25m, input enable,
    input btnC, input [12:0] pixel_index,
    output [15:0] final_data_4c);
    
    reg [15:0] color_data;
    wire [15:0] color_data_w;
      
    wire [15:0] sh0_filtered_data, sh1_filtered_data, sh2_filtered_data, 
        sh3_filtered_data, sh4_filtered_data, sh5_filtered_data, sh6_filtered_data;

    wire [6:0] sh0_col_start, sh1_col_start, sh2_col_start, sh3_col_start,
        sh4_col_start, sh5_col_start, sh6_col_start;
    wire [6:0] sh0_col_end, sh1_col_end, sh2_col_end, sh3_col_end, 
        sh4_col_end, sh5_col_end, sh6_col_end;
    wire [5:0] sh0_row_start, sh1_row_start, sh2_row_start, sh3_row_start,
        sh4_row_start, sh5_row_start, sh6_row_start;
    wire [5:0] sh0_row_end, sh1_row_end, sh2_row_end, sh3_row_end,
        sh4_row_end, sh5_row_end, sh6_row_end;

    wire clk_15, clk_45, clk_1k;
    reg [2:0] state;
        
    wire state0_end, state1_end, state2_end, state3_end, 
        state4_end, state5_end, state6_end;
        
    reg reset_shapes;
    reg [19:0] reset_counter;    
   
    initial begin
        color_data <= 16'hFFE0;
        state <= 3'b000;
        reset_shapes <= 1'b0;
        reset_counter <= 0;
    end
   
    always @(posedge clk6p25m) begin
        if (!enable) begin
            state <= 3'b000;
            reset_shapes <= 1'b1;
            reset_counter <= 625000;
        end else begin
            if (reset_counter > 0) begin
                reset_counter <= reset_counter - 1;
           
                if (reset_counter == 1) begin
                    reset_shapes <= 1'b0;
                    state <= 3'b000;
                end
            end else if (state == 3'b000 && state0_end) begin
                state <= 3'b001;
            end else if (state == 3'b001 && state1_end) begin
                state <= 3'b010;
            end else if (state == 3'b010 && state2_end) begin
                state <= 3'b011;
            end else if (state == 3'b011 && state3_end) begin
                state <= 3'b100;
            end else if (state == 3'b100 && state4_end) begin
                state <= 3'b101;
            end else if (state == 3'b101 && state5_end) begin
                state <= 3'b110;
            end else if (state == 3'b110 && state6_end) begin
                if (btnC) begin
                    reset_shapes <= 1'b1;
                    reset_counter <= 625000; 
                end
            end
        end
    end
   
    assign color_data_w = color_data;   
    
    // shape 0
    Shape0 sh0 (
        clk_1k, btnC, state, reset_shapes, 
        sh0_col_start, sh0_col_end, sh0_row_start, sh0_row_end, state0_end); 
        
    Oled_Filter_2 filter_sh0 (
        clk6p25m, pixel_index, color_data_w, 
        sh0_col_start, sh0_col_end, sh0_row_start, sh0_row_end, sh0_filtered_data);
        
    // shape 1
    Shape1 sh1 (
        clk_45, state, reset_shapes, 
        sh1_col_start, sh1_col_end, sh1_row_start, sh1_row_end, state1_end); 

    Oled_Filter_2 filter_sh1 (
        clk6p25m, pixel_index, color_data_w, 
        sh1_col_start, sh1_col_end, sh1_row_start, sh1_row_end, sh1_filtered_data);
    
    // shape 2    
    Shape2 sh2 (
        clk_45, state, reset_shapes, 
        sh2_col_start, sh2_col_end, sh2_row_start, sh2_row_end, state2_end); 

    Oled_Filter_2 filter_sh2 (
        clk6p25m, pixel_index, color_data_w, 
        sh2_col_start, sh2_col_end, sh2_row_start, sh2_row_end, sh2_filtered_data);
           
    // shape 3       
    Shape3 sh3 (
        clk_15, state, reset_shapes, 
        sh3_col_start, sh3_col_end, sh3_row_start, sh3_row_end, state3_end); 

    Oled_Filter_2 filter_sh3 (
        clk6p25m, pixel_index, color_data_w, 
        sh3_col_start, sh3_col_end, sh3_row_start, sh3_row_end,
        sh3_filtered_data);
    
    // shape 4  
    Shape4 sh4 (
        clk_15, state, reset_shapes, 
        sh4_col_start, sh4_col_end, sh4_row_start, sh4_row_end, state4_end); 
    
    Oled_Filter_2 filter_sh4 (
        clk6p25m, pixel_index, color_data_w, 
        sh4_col_start, sh4_col_end, sh4_row_start, sh4_row_end, sh4_filtered_data);
               
     // shape 5
    Shape5 sh5 (
        clk_15, state, reset_shapes, 
        sh5_col_start, sh5_col_end, sh5_row_start, sh5_row_end, state5_end); 

    Oled_Filter_2 filter_sh5 (
        clk6p25m, pixel_index, color_data_w, 
        sh5_col_start, sh5_col_end, sh5_row_start, sh5_row_end, sh5_filtered_data);
       
    // shape 6
    Shape6 sh6 (
        clk_15, state, reset_shapes, 
        sh6_col_start, sh6_col_end, sh6_row_start, sh6_row_end, state6_end); 
        
    Oled_Filter_2 filter_sh6 (
        clk6p25m, pixel_index, color_data_w, 
        sh6_col_start, sh6_col_end, sh6_row_start, sh6_row_end, sh6_filtered_data);
       
    // choose state using mux
    States_Mux mux (
        clk6p25m, state, sh0_filtered_data, sh1_filtered_data, sh2_filtered_data, 
        sh3_filtered_data, sh4_filtered_data, sh5_filtered_data, sh6_filtered_data,
        final_data_4c);
    
    Clk_Div_45 clk_first_movement (clk, clk_45);
    Clk_Div_15 clk_next_movements(clk, clk_15);
    Clk_Div_1k button_clock (clk, clk_1k);   

endmodule
