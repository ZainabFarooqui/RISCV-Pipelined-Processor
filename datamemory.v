`timescale 1ns / 1ps

module datamemory (
    input [63:0] write_data,
    input [63:0] address,
    input memorywrite, clk, memoryread,
    output reg [63:0] read_data,
    output [63:0] A1,
    output [63:0] A2,
    output [63:0] A3,
    output [63:0] A4,
    output [63:0] A5,
    output [63:0] A6,
    output [63:0] A7,
    output [63:0] A8
);

    reg [7:0] mem [255:0]; // 256 byte memory array
    integer i;

    // Initialize the memory with zeros and specific values for debugging purposes
    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            mem[i] = 8'd0;
        end
        mem[0] = 8'd11;
        mem[8] = 8'd22;
        mem[16] = 8'd13;
        mem[24] = 8'd4;
        mem[32] = 8'd5;
        mem[40] = 8'd90;
        mem[48] = 8'd26;
        mem[56] = 8'd11;
    end

    // Assign output A for debugging
    assign A1 = {mem[7], mem[6], mem[5], mem[4], mem[3], mem[2], mem[1], mem[0]};
    assign A2 = {mem[15], mem[14], mem[13], mem[12], mem[11], mem[10], mem[9], mem[8]};
    assign A3 = {mem[23], mem[22], mem[21], mem[20], mem[19], mem[18], mem[17], mem[16]};
    assign A4 = {mem[31], mem[30], mem[29], mem[28], mem[27], mem[26], mem[25], mem[24]};
    assign A5 = {mem[39], mem[38], mem[37], mem[36], mem[35], mem[34], mem[33], mem[32]};
    assign A6 = {mem[47], mem[46], mem[45], mem[44], mem[43], mem[42], mem[41], mem[40]};
    assign A7 = {mem[55], mem[54], mem[53], mem[52], mem[51], mem[50], mem[49], mem[48]};
    assign A8 = {mem[63], mem[62], mem[61], mem[60], mem[59], mem[58], mem[57], mem[56]};

    // Read logic
    always @(*) begin
        if (memoryread == 1'b1) begin
            read_data = {mem[address + 7], mem[address + 6], mem[address + 5], mem[address + 4],
                         mem[address + 3], mem[address + 2], mem[address + 1], mem[address]};
        end
    end

    // Write logic
    always @(posedge clk) begin
        if (memorywrite == 1'b1) begin
            mem[address]     = write_data[7:0];
            mem[address + 1] = write_data[15:8];
            mem[address + 2] = write_data[23:16];
            mem[address + 3] = write_data[31:24];
            mem[address + 4] = write_data[39:32];
            mem[address + 5] = write_data[47:40];
            mem[address + 6] = write_data[55:48];
            mem[address + 7] = write_data[63:56];
        end
    end
endmodule
