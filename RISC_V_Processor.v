`timescale 1ns / 1ps

module RISC_V_Processor(input clk,
    input reset,
    output reg [63:0] PC_In, PC_Out, ReadData1, ReadData2, WriteData, Result, Read_Data, imm_data,
    output reg [31:0] Instruction,
    output reg [6:0] opcode,
    output reg [4:0] rs1, rs2, rd,
    output reg [1:0] ALUOp,
    output reg [63:0] adder_out1, adder_out2,
    output reg Branch, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite, addermuxselect,
    output reg [63:0] index0, index1, index2, index3, index4,index5,index6, index7,index8
    );

wire [63:0] PC_In, PC_Out, adder_out1, adder_out2, imm_data, WriteData, ReadData1, ReadData2, Result, Read_Data;
wire [63:0] muxmid_out;

wire [3:0] Funct, Operation;
wire [2:0] funct3;

// Instruction Fetch //
Adder A1(.a(PC_Out), .b(64'd4), .out(adder_out1));
mux2by1 muxfirst(.a(adder_out1), .b(adder_out2), .sel(Branch && addermuxselect), .data_out(PC_In));
Program_Counter PC(.clk(clk), .reset(reset), .PC_In(PC_In), .PC_Out(PC_Out));
instruction_memory IM(.Inst_Address(PC_Out), .Instruction(Instruction));

// Instruction Decode / Register File Read //
instruction_parser IP(.instruction(Instruction), .opcode(opcode), .rd(rd), .funct3(funct3), .rs1(rs1), .rs2(rs2), .funct7(funct7));
Immediate_Extractor Immgen(.ins(Instruction), .imm_data(imm_data));
Control_Unit cu(.Opcode(opcode), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
registerfile rf(.clk(clk), .reset(reset), .rs1(rs1), .rs2(rs2), .rd(rd), .writedata(WriteData),.reg_write(RegWrite), .readdata1(ReadData1), .readdata2(ReadData2));
assign Funct = {Instruction[30], Instruction[14:12]};

// Execute / Address Calculation // 
Adder A2(.a(PC_Out), .b(imm_data * 2), .out(adder_out2));
mux2by1 muxmid(.a(ReadData2), .b(imm_data), .sel(ALUSrc), .out(muxmid_out));
ALU_Control aluc(.ALUOp(ALUOp), .Funct(Funct), .Operation(Operation));
ALU_64_bit ALU(.a(ReadData1), .b(muxmid_out), .ALUOp(Operation), .Result(Result));
//Branch_unit BU(.Funct3(funct3), .ReadData1(ReadData1), .ReadData2(ReadData2), .addermuxselect(addermuxselect));
// MEM: Memory Access //
//Data_Memory DM(.Mem_Addr(Result), .Write_Data(ReadData2), .clk(clk), .MemWrite(MemWrite), .MemRead(MemRead), .Read_Data(Read_Data));
data_memory DM(.write_data(ReadData2),.address(Result),.memorywrite(MemWrite),.clk(clk),  .memoryread(MemRead), .read_data(Read_Data), .A1(index0), .A2(index1), .A3(index2), .A4(index3), .A5(index4), .A6(index2), .A7(index3), .A8(index4));
// Write Back // 
mux2by1 muxlast(.a(Result), .b(Read_Data), .sel(MemtoReg), .out(WriteData));
endmodule


