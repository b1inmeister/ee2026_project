`timescale 1ns / 1ps

module Led_Controller (
    input clk, input [15:0] sw,
    output reg [15:0] led);
    
    reg blink_2Hz, blink_3Hz, blink_5Hz, blink_10Hz;
             
    wire clk_2Hz;
    Clock_Divider #(50_000_000) clk_divide_2 (clk, clk_2Hz);
             
    wire clk_3Hz;
    Clock_Divider #(33_333_333) clk_divide_3 (clk, clk_3Hz);
             
    wire clk_10Hz;
    Clock_Divider #(10_000_000) clk_divide_10 (clk, clk_10Hz);
             
    always @ (posedge clk_2Hz) blink_2Hz <= !blink_2Hz;
    always @ (posedge clk_3Hz) blink_3Hz <= !blink_3Hz;
    always @ (posedge clk_10Hz) blink_10Hz <= !blink_10Hz;
        
    always @ (posedge clk) begin
        led <= sw;
            
        case (sw)
            // SW12, 9. 8. 6. 2, 0 (BLINK = 3Hz)
            16'b0001001101000101: begin
                led[0] <= blink_3Hz;
                led[2] <= blink_3Hz;
                led[6] <= blink_3Hz;
                led[8] <= blink_3Hz;
                led[9] <= blink_3Hz;
            end
            // SW13, 9, 5, 2, 0 (BLINK = 10Hz)
            16'b0010001000100101: begin
                led[0] <= blink_10Hz;
                led[2] <= blink_10Hz;
                led[5] <= blink_10Hz;
                led[9] <= blink_10Hz;
            end
            // SW14, 9, 7, 5, 2, 1, 0 (BLINK = 2Hz)
            16'b0100001010100111: begin
                led[0] <= blink_2Hz;
                led[1] <= blink_2Hz;
                led[2] <= blink_2Hz;
                led[5] <= blink_2Hz;
                led[7] <= blink_2Hz;
                led[9] <= blink_2Hz; 
            end   
            // SW15, 9, 7, 4, 2, 1, 0 (BLINK = 10Hz)
            16'b1000001010010111: begin
                led[0] <= blink_10Hz;
                led[1] <= blink_10Hz;
                led[2] <= blink_10Hz;
                led[4] <= blink_10Hz;
                led[7] <= blink_10Hz;
                led[9] <= blink_10Hz;
            end  
        endcase
    end
    
endmodule
