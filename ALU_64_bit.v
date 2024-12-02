`timescale 1ns / 1ps

module ALU_64_bit
(
    input [63:0] a, b,
    input [3:0] ALUOp,
    
    output reg [63:0] Result,
    output reg ZERO,
    output reg BLT_Flag // flag for branch less than
);

always @ (*)
begin
    // default behavior for the Result and ZERO flag
    Result = 64'd0;
    ZERO = 0;
    BLT_Flag = 0;

    case (ALUOp)
        4'b0000: Result = a & b;          // AND
        4'b0001: Result = a | b;          // OR
        4'b0010: Result = a + b;          // ADD
        4'b0110: Result = a - b;          // SUB
        4'b1100: Result = ~(a | b);       // NOR
        4'b1000: begin                    // BLT (branch less than)
            BLT_Flag = (a < b);           // set the BLT flag if a < b
            Result = (a < b) ? 64'd1 : 64'd0; // set Result to 1 if a < b, else 0
        end
        4'b1001: Result = a + b;          // ADDI 
        4'b1010: Result = a ^ b;          // XOR 
        4'b1111: Result = a * (2 ** b);   // SLLI 
        default: Result = 64'd0;          // default case to ensure safety
    endcase

    // set the ZERO flag if the result is zero
    ZERO = (Result == 0);
end

endmodule
