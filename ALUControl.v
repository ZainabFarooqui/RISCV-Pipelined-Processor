`timescale 1ns / 1ps

module ALUControl
(
    input [1:0] ALUOp, 
    input [3:0] Funct,
    output reg [3:0] Operation
);

    always @(*)
    begin
        //default operation
        Operation = 4'bxxxx;

        case(ALUOp)
            2'b00: begin //for ld, sd, addi, slli
                case(Funct[2:0])
                    3'b000: Operation = 4'b1001; // addi
                    3'b001: Operation = 4'b1111; // slli
                    default: Operation = 4'b0010; //default to ADD
                endcase 
            end
            
            2'b01: //branch instructions
            begin
                case(Funct[2:0])
                    3'b000: Operation = 4'b0110; // branch like beq
                    3'b100: Operation = 4'b1000; // blt (branch less than)
                    default: Operation = 4'bxxxx; // undefined for this ALUOp
                endcase
            end

            2'b10: // R-format instructions
            begin 
                case(Funct)
                    4'b0000: Operation = 4'b0010; // ADD
                    4'b1000: Operation = 4'b0110; // SUBTRACT
                    4'b0111: Operation = 4'b0000; // AND
                    4'b0110: Operation = 4'b0001; // OR
                    default: Operation = 4'bxxxx; // undefined for this ALUOp
                endcase
            end

            default: Operation = 4'bxxxx; //for undefined ALUOp
        endcase
    end

endmodule
