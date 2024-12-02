module testbench();
    reg clk, reset;

    // Outputs to monitor
    wire [63:0] PC_Out, WriteData;
    wire [63:0] ID_EX_PC, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_imm_data;
    wire [4:0] ID_EX_rs1, ID_EX_rs2, ID_EX_rd;
    wire [31:0] IF_ID_PC_Out, IF_ID_Instruction_Out;
    wire [63:0] ID_EX_PC_Out, ID_EX_ReadData1_Out,ID_EX_ReadData2_Out, ID_EX_imm_value_Out,EX_MEM_Result_Out,
    EX_MEM_WriteData_Out,
    MEM_WB_Result_Out,
     MEM_WB_ReadData_Out;
wire[4:0] ID_EX_rd_Out;
    // Instantiate the RISC-V processor
    RISC_V_Pipelined RP1 (
        .clk(clk),
        .reset(reset),
        .IF_ID_PC_Out(IF_ID_PC_Out),
        .IF_ID_Instruction_Out(IF_ID_Instruction_Out),
        .ID_EX_PC_Out(ID_EX_PC_Out),
        .ID_EX_ReadData1_Out(ID_EX_ReadData1_Out),
        .ID_EX_ReadData2_Out(ID_EX_ReadData2_Out),
        .ID_EX_imm_value_Out(ID_EX_imm_value_Out),
        .ID_EX_rd_Out(ID_EX_rd_Out),
        .EX_MEM_Result_Out(EX_MEM_Result_Out),
        .EX_MEM_WriteData_Out(EX_MEM_WriteData_Out),
        .MEM_WB_Result_Out(MEM_WB_Result_Out),
        .MEM_WB_ReadData_Out(MEM_WB_ReadData_Out)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk; // Generate a 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize reset
        reset = 1'b1;
        #10 reset = 1'b0;

        // Let the simulation run for some time
        #1000;

        // Stop the simulation
        $stop;
    end

    // Monitor pipeline register values
    always @(posedge clk) begin
        $display("========================================");
        $display("Time: %t", $time);
        $display("PC_Out: %h", PC_Out);
        $display("ID/EX Stage:");
        $display("   PC: %h", ID_EX_PC);
        $display("   ReadData1: %h", ID_EX_ReadData1);
        $display("   ReadData2: %h", ID_EX_ReadData2);
        $display("   Immediate: %h", ID_EX_imm_data);
        $display("   rs1: %h, rs2: %h, rd: %h", ID_EX_rs1, ID_EX_rs2, ID_EX_rd);
    end
endmodule
