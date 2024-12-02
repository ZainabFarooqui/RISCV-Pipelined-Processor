`timescale 1ns / 1ps

module adder(
    input [63:0] a, b,
    output [63:0] out
);

    assign out = a + b; 

endmodule
