module my_memory (
    input [4:0] address, input [7:0] data_input, input write_enable, input read_enable,  
    output reg [7:0] output_data, input wire [1:0] alu_function_select, input wire [3:0] flag_registers
    
);
    
    // 32 registers of 8 bits
    reg [7:0] register[31:0]; //assign_1 memory
    reg [7:0] alu_output; // assign_2 ALU output
    reg [7:0] result; // assign_2 flag status
	
    // storing the data when write signal is enabled
    always @(posedge write_enable) begin
        register[address] <= data_input;
    end

    // loading the data to ouput_data when read signal is enabled
    always @(posedge read_enable) begin
        //my_memory <= register[address];
        output_data <= register[address];
    end
    
   // these line for flag setting alone 
    assign R0 = regsiter(0);
    assign R1 = register(1);
    assign R2 = register(2);
    assign R3 = register(3);
    assign R4 = register(4);
    assign R5 = register(5);
    
    // case fro perform the instruction set 5 
        case(alu_function_select)
            // alu_fun_sel : result <= Address 1 ? Address 2
            2'b00: alu_output <= register[0] + register[1]; // ADD
            2'b01: alu_output <= register[0] - register[1]; // SUBTRACT
            2'b10: alu_output <= (register[4] > register[5]) ? 8'b1 : 8'b0; // COMPARE
            2'b11: alu_output <= register[0] + 1; // INC
        endcase
    
    assign result == alu_output;
    
    assign flag[0] = (R2 == 8'b0) || (result[8] == 1) || (result[7] ^ A[7]) & (result[7] ^ B[7]);
    
    // shifted out bit
    assign flag[1] = (result[8] == 1);
    
    //is set if ALU operation results in Zero
    assign flag[2] = (R2 == 8'b0);

    // 1 indicates result of compare is triue,0 otherwise
    assign flag[3] = (com_result >= 1);

    assign L0 = flag_registers[0];
    assign L1 = flag_registers[1];
    assign L2 = flag_registers[2];
    assign L3 = flag_registers[3];
endmodule

