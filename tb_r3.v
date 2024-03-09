`timescale 1ns / 1ps // no comments on this.

module MemoryUnit_tb;

reg read_enable, write_enable;
reg [4:0] address;
reg [7:0] data_input;
reg [1:0] alu_function_select;
reg [3:0] flag_registers;
wire [7:0] output_data;

// Instantiate the MemoryUnit module
MemoryUnit mem_unit (
    .address(address),
    .data_input(data_input),
    .alu_function_select(alu_function_select),
    .flag_registers(flag_registers),
    .output_data(output_data)
);


// Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

// Test scenario
initial begin
    // Initialize inputs
    write_enable = 0;
    address = 0;
    data_input = 0;
    alu_function_select = 2'b00; // Default to ADD
    flag_registers = 4'b0000;

    // Release reset after a few clock cycles
    //#10 rst = 0;

    // Test case a) Load 141 to R4
    address = 4;
    data_input = 8'b10001101; // 141 in binary
    write_enable = 1;
    #20 write_enable = 0;

    // Test case b) Load 208 to R6
    address = 6;
    data_input = 8'b11010000; // 208 in binary
    write_enable = 1;
    #20 write_enable = 0;

    // Test case c) Load 32 to R8
    address = 8;
    data_input = 8'b00100000; // 32 in binary
    write_enable = 1;
    #20 write_enable = 0;

    // Add more test cases or operations as needed

    // Monitor the simulation
    $monitor("Time=%0t, Address=%0h, Output Data=%0h", $time, address, output_data);

    // Stop simulation after some time
    #1000 $finish;
end

initial begin
    $dumpvars;
    $dumpfile("dump.vcd");
  end
  
endmodule

