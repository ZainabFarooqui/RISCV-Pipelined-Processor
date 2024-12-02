module data_mem_tb;

  // Testbench variables
  reg clk;
  reg Mem_Read;
  reg Mem_Write;
  reg [63:0] address;
  reg [63:0] Write_Data;
  wire [63:0] Read_Data;
  wire [63:0] va11, va12, va13, va14, va15, va16, va17, va18;
  reg[63:0] temp;

  // Instantiate the Data_Memory module
  datamemory uut (
    .address(address),
    .write_data(Write_Data),
    .clk(clk),
    .memoryread(Mem_Read),
    .memorywrite(Mem_Write),
    .read_data(Read_Data),
     .A1(va11),
         .A2(va12),
         .A3(va13),
         .A4(va14),
         .A5(va15),
         .A6(va16),
         .A7(va17),
         .A8(va18)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Test initialization and bubble sort implementation
     integer i;
    integer j;
  initial begin
    // Reset all inputs
    Mem_Read = 0;
    Mem_Write = 0;
    address = 0;
    Write_Data = 0;

    // Wait for clock edge
    #10;

    // Display initial memory state
//    $display("Initial Data Memory State:");
//    $display("D1=%d, D2=%d, D3=%d, D4=%d, D5=%d, D6=%d, D7=%d, D8=%d, D9=%d, D10=%d", val1, val2, val3, val4, val5, val6, val7, val8);

    // Simulate bubble sort
 


    for (i = 0; i < 9; i = i + 1) begin
      for (j = 0; j < 9 - i; j = j + 1) begin
        // Read current element
        Mem_Read = 1;
        address = j * 8;
        #10;
        temp = Read_Data;

        // Read next element
        address = (j + 1) * 8;
        #10;

        // Compare and swap if necessary
        if (temp > Read_Data) begin
          // Write next element to current position
          Mem_Write = 1;
          address = j * 8;
          Write_Data = Read_Data;
          #10;
          Mem_Write = 0;

          // Write current element to next position
          Mem_Write = 1;
          address = (j + 1) * 8;
          Write_Data = temp;
          #10;
          Mem_Write = 0;
        end
      end
    end

    // Display final memory state
//    $display("Final Data Memory State After Bubble Sort:");
//    $display("D1=%d, D2=%d, D3=%d, D4=%d, D5=%d, D6=%d, D7=%d, D8=%d, D9=%d, D10=%d", D1, D2, D3, D4, D5, D6, D7, D8, D9, D10);

    // End simulation
    $stop;
  end

endmodule