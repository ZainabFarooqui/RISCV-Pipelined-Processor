`timescale 1ns / 1ps
module MUX3by1(
    input [63:0] a,
    input [63:0] b,
    input [63:0] c,
    input [1:0] sel,
    output reg [63:0] data_out
);
    always @(*) begin
        case (sel)
            2'b00: data_out = a;
            2'b01: data_out = b;
            2'b10: data_out = c;
            default: data_out = 64'b0; //handle undefined sel value
        endcase
    end
endmodule

