`timescale 1ns / 1ps
module tb();
 // Inputs
  reg clk;
  reg reset;
  reg stall;

  // Outputs
  wire branch;
  wire memread;
  wire memtoreg;
  wire memwrite;
  wire regwrite;
  wire ALUsrc;
  wire [1:0] ALUop;
  wire BLT_Flag;
  wire regwrite_memwb_out;
  wire [63:0] readdata1, readdata2;
  wire [63:0] r8, r19, r20, r21, r22;
  wire [63:0] write_data;
  wire [63:0] pc_in, pc_out;
  wire [63:0] adderout1, adderout2;
  wire [31:0] instruction;
  wire [31:0] inst_ifid_out;
  wire [6:0] opcode;
  wire [4:0] rd, rs1, rs2;
  wire [2:0] funct3;
  wire [6:0] funct7;
  wire [63:0] imm_data;
  wire [63:0] random;
  wire [63:0] a1, d, M1, M2;
  wire [4:0] RS1, RS2, RD;
  wire Branch, Memread, Memtoreg, Memwrite, Regwrite, Alusrc;
  wire [1:0] aluop;
  wire [3:0] funct4_out;
  wire [1:0] forwardA, forwardB;
  
  RISCV_task3 uut (
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .branch(branch),
    .memread(memread),
    .memtoreg(memtoreg),
    .memwrite(memwrite),
    .regwrite(regwrite),
//    .ALUsrc(ALUsrc),
    .ALUop(ALUop),
    .BLT_Flag(BLT_Flag),
    .regwrite_memwb_out(regwrite_memwb_out),
    .readdata1(readdata1),
    .readdata2(readdata2),
    .r8(r8),
    .r19(r19),
    .r20(r20),
    .r21(r21),
    .r22(r22),
    .write_data(write_data),
    .pc_in(pc_in),
    .pc_out(pc_out),
    .adderout1(adderout1),
    .adderout2(adderout2),
    .instruction(instruction),
    .inst_ifid_out(inst_ifid_out),
    .opcode(opcode),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .funct3(funct3),
    .funct7(funct7),
    .imm_data(imm_data),
    .random(random),
    .a1(a1),
    .RS1(RS1),
    .RS2(RS2),
    .RD(RD),
    .d(d),
    .M1(M1),
    .M2(M2),
    .Branch(Branch),
    .Memread(Memread),
    .Memtoreg(Memtoreg),
    .Memwrite(Memwrite),
    .Regwrite(Regwrite),
    .ALUsrc(ALUsrc),
    .aluop(aluop),
    .funct4_out(funct4_out),
    .forwardA(forwardA),
    .forwardB(forwardB)
  );
  
  initial 
    begin
      
      $dumpfile("dump.vcd");
      $dumpvars(1, tb);
		
      clk = 1'b0;
      reset = 1'b1;
      
      #7 
      reset = 1'b0;
      #7000
      $finish;
      
    end
  
  always
    begin
      #5
      clk = ~clk;
    end
endmodule
