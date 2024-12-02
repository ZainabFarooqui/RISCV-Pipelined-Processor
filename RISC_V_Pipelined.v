
module RISCV_task3(
  input clk,
  input reset,
//  output reg[63:0] A1,
//  output reg[63:0] A2,
//  output reg[63:0] A3,
//  output reg[63:0] A4,
//  output reg[63:0] A5,
//  output reg[63:0] A6,
//  output reg[63:0] A7,
//  output reg[63:0] A8,
  input stall,
  output reg branch,
  output reg memread,
  output reg memtoreg,
  output reg memwrite,
   output regALUsrc,
  output reg regwrite,
 output reg [1:0] ALUop,
  output reg BLT_Flag,
 
  //regfile
  output reg regwrite_memwb_out,
  output reg [63:0] readdata1, readdata2,
  output reg [63:0] r8, r19, r20, r21, r22,
  output reg [63:0] write_data,
  
   //PC wires
  output reg [63:0] pc_in,
  output reg [63:0] pc_out,
  
  // adders
  output reg [63:0] adderout1,
  output reg [63:0] adderout2,
  
  // inst mem wire
  output reg [31:0] instruction,
  output reg[31:0] inst_ifid_out,
  
  //Parser
  output reg [6:0] opcode,
  output reg [4:0] rd, rs1, rs2,
  output reg [2:0] funct3,
  output reg [6:0] funct7,
  
  
  // Immediate Data Extractor
  output reg [63:0] imm_data,
  //ifid wires
 
  output reg [63:0] random,
  
  //id ex wires
 
  output reg [63:0] a1,
  output reg [4:0] RS1,
  output reg [4:0] RS2,
  output reg [4:0] RD,
  output reg [63:0] d, M1, M2,
  output reg Branch,
  output reg Memread,
  output reg Memtoreg,
  output reg Memwrite,
  output reg Regwrite,
  output reg ALUsrc,
  output reg [1:0] aluop,
  output reg [3:0] funct4_out,
   //forwarding unit wires
  output reg [1:0] forwardA,
  output reg [1:0] forwardB);
  
  wire forwardA;
  wire forwardB;
  // CU wires
  wire branch;
  wire memread;
  wire memtoreg;
  wire memwrite;
  wire ALUsrc;
  wire regwrite;
  wire [1:0] ALUop;
  wire BLT_Flag;
 
  //regfile
  wire regwrite_memwb_out;
  wire [63:0] readdata1, readdata2;
//  wire [63:0] r8, r19, r20, r21, r22;
  wire [63:0] write_data;
  
   //PC wires
  wire [63:0] pc_in;
  wire [63:0] pc_out;
  
  // adders
  wire [63:0] adderout1;
  wire [63:0] adderout2;
  
  // inst mem wire
  wire [31:0] instruction;
  wire[31:0] inst_ifid_out;
  
  //Parser
  wire [6:0] opcode;
  wire [4:0] rd, rs1, rs2;
  wire [2:0] funct3;
  wire [6:0] funct7;
  
  
  // Immediate Data Extractor
  wire [63:0] imm_data;
  
  //ifid wires
 
  wire [63:0] random;
  
  //id ex wires
 
  wire [63:0] a1;
  wire [4:0] RS1;
  wire [4:0] RS2;
  wire [4:0] RD;
  wire [63:0] d, M1, M2;
  wire Branch;
  wire Memread;
  wire Memtoreg;
  wire Memwrite;
  wire Regwrite;
  wire ALUsrc;
  wire [1:0] aluop;
  wire [3:0] funct4_out;
  
  //mux wires
  wire [63:0] threeby1_out1;
  wire[63:0] threeby1_out2;
  wire[63:0]  alu_64_b;
  
   //ex mem wires
  wire [63:0] write_Data;
  wire [63:0] exmem_out_adder;
  wire exmem_out_zero;
  wire [63:0] exmem_out_result;
  wire [4:0] exmemrd;
  wire BRANCH,MEMREAD,MEMTOREG,MEMEWRITE,REGWRITE;   
  
   // ALU 64
  wire [63:0] AluResult;
  wire zero;
  
  
  // ALU Control
  wire [3:0] operation;
  
  // Data Memory
  wire [63:0] readdata;
 
  
  
  
  //memwb wires
  wire[63:0] muxin1,muxin2;
  wire [4:0] memwbrd;
  wire memwb_memtoreg;
  wire memwb_regwrite;
  
  // Branch
  wire addermuxselect;
  wire branch_final;
  
  
//  Flush p_flush
//  (
//    .branch(branch_final & BRANCH),
//    .flush(flush)
//  );
  
   MUX2by1 mux1
  (
    .a(threeby1_out2),.b(d),.sel(Alusrc),.data_out(alu_64_b)
  );
   
  ProgramCounter pc 
  (
    .PC_in(pc_in),
    .stall(stall),
    .clk(clk),
    .reset(reset),
    .PC_out(pc_out)
  );
  
  

  adder adder1
  (
    .a(pc_out),
    .b(64'd4),
    .out(adderout1)
  );
  
  instructionmemory im
  (
    .Inst_Address(pc_out),
    .Instruction(instruction)
  );
  
  
 
  
   IF_ID i1 
  (
    .clk(clk),
    .reset(reset),
    .IFIDWrite(stall),
    .instruction(instruction),
    .A(pc_out),
    .inst(inst_ifid_out),
    .a_out(random),
    .stall(stall)
  );
  
  instructionparser ip
  (
    .instruction(inst_ifid_out),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)
  );
  
  RegisterFile vsdh (
    .clk(clk),
    .reset(reset),
    .RegWrite(RegWrite),
    .WriteData(WriteData),
    .RS1(rs1),
    .RS2(rs2),
    .RD(rd),
    .ReadData1(readdata1),
    .ReadData2(readdata2)
  );
    
     ControlUnit cu
  (
    .opcode(opcode),
    .branch(branch),
    .memread(memread),
    .memtoreg(memtoreg),
    .memwrite(memwrite),
    .aluSrc(ALUsrc),
    .regwrite(regwrite),
    .AlUop(ALUop),
    .stall(stall)
  );
  
   immediateextractor immextr
  (
    .ins(inst_ifid_out),
    .imm_data(imm_data)
  );
  
     
  
//  );input clk,
//  input reset,
//  input [4:0] rs1,
//  input [4:0] rs2,
//  input [4:0] rd,
//  input [63:0] writedata,
//  input reg_write,
//  output reg [63:0] readdata1,
//  output reg [63:0] readdata2
  
  ID_EX i2
  (
    .clk(clk),
//    .flush(flush),
    .reset(reset),
    .funct4_in({inst_ifid_out[30],inst_ifid_out[14:12]}),
    .A_in(random),
    .readdata1_in(readdata1),
    .readdata2_in(readdata2),
    .imm_data_in(imm_data),
    .rs1_in(rs1),.rs2_in(rs2),.rd_in(rd),
    .branch_in(branch),.memread_in(memread),.memtoreg_in(memtoreg),
    .memwrite_in(memwrite),.aluSrc_in(ALUsrc),.regwrite_in(regwrite),.Aluop_in(ALUop),
    .a(a1),.rs1(RS1),.rs2(RS2),.rd(RD),.imm_data(d),.readdata1(M1),.readdata2(M2),
    .funct4_out(funct4_out),.Branch(Branch),.Memread(Memread),.Memtoreg(Memtoreg),
    .Memwrite(Memwrite),.Regwrite(Regwrite),.Alusrc(Alusrc),.aluop(aluop)
  );
   Hazard_Detection hu
  (
    .Memread(Memread),
    .inst(inst_ifid_out),
    .rd(RD),
    .stall(stall)
  );
 
  
  adder adder2
  (
    .a(a1),
    .b(d << 1),
    .out(adderout2)
  );
  
  
  MUX2by1 m1
  (
    .a(M1),.b(write_data),.sel(forwardA),.data_out(threeby1_out1)
  );
   ALUControl ac
  (
    .ALUOp(aluop),
    .Funct(funct4_out),
    .Operation(operation)
  );
  
   Branch_unit branc(
    .Funct3(funct4_out[2:0]),.ReadData1(M1),.ReadData2(alu_64_b),.addermuxselect(addermuxselect)
  );
    ALU_64_bit alu
  (
    .a(threeby1_out1),
    .b(alu_64_b),
    .ALUOp(operation),
    .Result(AluResult),
    .ZERO(zero),.BLT_Flag(BLT_Flag)
  );
  
  Forwarding f1(
    .ID_EX_RegisterRS1(RS1),.ID_EX_RegisterRS2(RS2),.EX_MEM_RegisterRD(exmemrd),
    .MEM_WB_RegisterRD(memwbrd),.MEM_WB_RegWrite(memwb_regwrite),
    .EX_MEM_RegWrite(REGWRITE),
    .ForwardA(forwardA),.ForwardB(forwardB)
  );
  
   EX_MEM i3
  (
    .clk(clk),.reset(reset),.Adder_out(adderout2),.Result_in_alu(AluResult),.Zero_in(zero),.flush(flush),
    .writedata_in(threeby1_out2),.Rd_in(RD), .addermuxselect_in(addermuxselect),
    .branch_in(Branch),.memread_in(Memread),.memtoreg_in(Memtoreg),.memwrite_in(Memwrite),.regwrite_in(Regwrite),
    .Adderout( exmem_out_adder),.zero(exmem_out_zero),.result_out_alu(exmem_out_result),.writedata_out(write_Data),
    .rd(exmemrd),.Branch(BRANCH),.Memread(MEMREAD),.Memtoreg(MEMTOREG),.Memwrite(MEMEWRITE),.Regwrite(REGWRITE), .addermuxselect(branch_final)
  );
  
  datamemory datamem
  (
    .write_data(write_Data),
    .address(exmem_out_result),
    .memorywrite(MEMEWRITE),
    .clk(clk),
    .memoryread(MEMREAD),
    .read_data(readdata),
    .A1(element1),
    .A2(element2),
    .A3(element3),
    .A4(element4),
    .A5(element5),
    .A6(element6),
    .A7(element7),
    .A8(element8)
  );
  
  MEM_WB i4
  
  (
    .clk(clk),.reset(reset),.read_data_in(readdata),
    .result_alu_in(exmem_out_result),.Rd_in(exmemrd),.memtoreg_in(MEMTOREG),.regwrite_in(REGWRITE),
    .readdata(muxin1),.result_alu_out(muxin2),.rd(memwbrd),.Memtoreg(memwb_memtoreg),.Regwrite(memwb_regwrite)
  );
  
   MUX2by1 mux3
  (
    .a(muxin2),.b(muxin1),.sel(memwb_memtoreg),.data_out(write_data)
  );
       
endmodule 