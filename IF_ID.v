module IF_ID (
    input clk,
    input reset,
    input [31:0] instruction,  // Fetched instruction
    input [63:0] A,            // Adder output or PC
    input stall,               // Stall signal
    input IFIDWrite,           // Write enable for IF/ID register
    output reg [31:0] inst,    // Output instruction to ID stage
    output reg [63:0] a_out    // Output adder value to ID stage
);

  always @(posedge clk) begin
    if (reset) begin
      // Reset all outputs to 0
      inst <= 32'b0;
      a_out <= 64'b0;
    end else if (stall) begin
      // On stall, maintain current values (no action)
      inst <= inst;
      a_out <= a_out;
    end else if (IFIDWrite) begin
      // Write new instruction and adder output if not stalled
      inst <= instruction;
      a_out <= A;
    end
  end

endmodule
