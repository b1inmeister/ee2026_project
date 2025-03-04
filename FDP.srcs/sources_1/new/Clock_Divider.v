`timescale 1ns / 1ps

module Clock_Divider #(
    parameter DIV_VALUE = 1_000_000)(
    input CLK, output reg CLK_DIV);
        
    reg [25:0] count = 0;
        
    always @ (posedge CLK) begin
        if (count == (DIV_VALUE - 1)) begin
            count <= 0;
            CLK_DIV <= ~CLK_DIV;
        end else begin
            count <= count + 1;
        end
    end
endmodule
