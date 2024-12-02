`timescale 1ns / 1ps

module ID_EX(
  input clk, reset,
  input [3:0] funct4_in,         // funct4 of instruction from instruction memory
  input [63:0] A_in,             // adder input, output of IF/ID carried forward
  input [63:0] readdata1_in,     // from Register File
  input [63:0] readdata2_in,     // from Register File
  input [63:0] imm_data_in,      // from Immediate Data Extractor
  input [4:0] rs1_in, rs2_in, rd_in,  // from Instruction Parser
  input branch_in, memread_in, memtoreg_in, memwrite_in, aluSrc_in, regwrite_in, // control signals
  input [1:0] Aluop_in,
  output reg [63:0] a,
  output reg [4:0] rs1, rs2, rd,
  output reg [63:0] imm_data,
  output reg [63:0] readdata1, readdata2,
  output reg [3:0] funct4_out,
  output reg Branch, Memread, Memtoreg, Memwrite, Regwrite, Alusrc,
  output reg [1:0] aluop
);

  always @(posedge clk) begin
    if (reset) begin
      // Reset all outputs to default values
      a <= 64'b0;
      rs1 <= 5'b0;
      rs2 <= 5'b0;
      rd <= 5'b0;
      imm_data <= 64'b0;
      readdata1 <= 64'b0;
      readdata2 <= 64'b0;
      funct4_out <= 4'b0;
      Branch <= 1'b0;
      Memread <= 1'b0;
      Memtoreg <= 1'b0;
      Memwrite <= 1'b0;
      Regwrite <= 1'b0;
      Alusrc <= 1'b0;
      aluop <= 2'b0;
    end else begin
      // Update outputs with corresponding inputs
      a <= A_in;
      rs1 <= rs1_in;
      rs2 <= rs2_in;
      rd <= rd_in;
      imm_data <= imm_data_in;
      readdata1 <= readdata1_in;
      readdata2 <= readdata2_in;
      funct4_out <= funct4_in; // Instruction[30, 14:12]
      Branch <= branch_in;
      Memread <= memread_in;
      Memtoreg <= memtoreg_in;
      Memwrite <= memwrite_in;
      Regwrite <= regwrite_in;
      Alusrc <= aluSrc_in;
      aluop <= Aluop_in;
    end
  end

endmodule
