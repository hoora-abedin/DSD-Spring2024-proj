module TB;
    reg clk;
    reg [8:0] memmory_address;
    reg [1:0] resister_a_address;
    reg [1:0] register_b_address;
    reg [1:0] register_address_to_write;
    reg [511:0] data_to_write;
    reg write_enable;
    reg [1:0] alu_opcode;
    reg mem_write_enable;
    wire [511:0] result;

    Processor processor (
        .clk(clk),
        .memmory_address(memmory_address),
        .resister_a_address(resister_a_address),
        .register_b_address(register_b_address),
        .register_address_to_write(register_address_to_write),
        .data_to_write(data_to_write),
        .write_enable(write_enable),
        .alu_opcode(alu_opcode),
        .mem_write_enable(mem_write_enable),
        .result(result)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        memmory_address = 0;
        resister_a_address = 0;
        register_b_address = 1;
        register_address_to_write = 0;
        data_to_write = 0;
        write_enable = 0;
        alu_opcode = 0;
        mem_write_enable = 0;

        // Test: Load data into registers
        #10;
        data_to_write = 512'hA5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5;
        write_enable = 1;
        register_address_to_write = 2'b00;
        #10;
        write_enable = 0;

        data_to_write = 512'h115A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5A511;
        write_enable = 1;
        register_address_to_write = 2'b01;
        #10;
        write_enable = 0;

        // Test: ADD
        alu_opcode = 2'b00;
        resister_a_address = 2'b00;
        register_b_address = 2'b01;
        #10;
        $display("TEST 1: ADD 2 NUMBERS");
        $display("Input A: %d, Input B: %d", processor.registerFile.A1, processor.registerFile.A2);
        $display("Expected Result: %d", processor.registerFile.A1 + processor.registerFile.A2);
        $display("Least Significant: %d, Actual High Result: %b", processor.alu.least_sig, processor.alu.most_sig);

        // Test: Mult
        alu_opcode = 2'b01;
        #10;
        $display("TEST 2: MULTIPLY 2 NUMBERS");
        $display("Input A: %d, Input B: %d", processor.registerFile.A1, processor.registerFile.A2);
        $display("Expected Least Significant: %d, Expected Most Significant: %d", processor.registerFile.A1 * processor.registerFile.A2[255:0], (processor.registerFile.A1 * processor.registerFile.A2) >> 256);
        $display("Actual Least Significant: %d, Actual Most Significant: %d", processor.alu.least_sig, processor.alu.most_sig);

        // Load new data into registers
        data_to_write = 512'h6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B6B;
        write_enable = 1;
        register_address_to_write = 2'b00;
        #10;
        write_enable = 0;

        data_to_write = 512'h123C123C123C123C123C123C123C123C123C123C123C123C123C123C123C123C123C123C123C123C;
        write_enable = 1;
        register_address_to_write = 2'b01;
        #10;
        write_enable = 0;

        // Test: ADD
        alu_opcode = 2'b00;
        resister_a_address = 2'b00;
        register_b_address = 2'b01;
        #10;

        $display("TEST 3: ADD 2 NUMBERS");
        $display("Input A: %d, Input B: %d", processor.registerFile.A1, processor.registerFile.A2);
        $display("Expected Result: %d", processor.registerFile.A1 + processor.registerFile.A2);
        $display("Least Significant: %d, Actual High Result: %d", processor.alu.least_sig, processor.alu.most_sig);

        // Test: Mult
        alu_opcode = 2'b01;
        #10;

        $display("TEST 2: MULTIPLY 2 NUMBERS");
        $display("Input A: %d, Input B: %d", processor.registerFile.A1, processor.registerFile.A2);
        $display("Expected Least Significant: %d, Expected Most Significant: %d", processor.registerFile.A1 * processor.registerFile.A2[255:0], (processor.registerFile.A1 * processor.registerFile.A2) >> 256);
        $display("Actual Least Significant: %d, Actual Most Significant: %d", processor.alu.least_sig, processor.alu.most_sig);

        // Load and store from memory
        memmory_address = 0;
        data_to_write = 512'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
        mem_write_enable = 1;
        #10;
        mem_write_enable = 0;
        #10;

        $display("Memory Write and Read Test 1:");
        $display("Written Data: %d", data_to_write);
        $display("Read Data: %d", result);

        // Load new data into memory
        memmory_address = 16;
        data_to_write = 512'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
        mem_write_enable = 1;
        #10;
        mem_write_enable = 0;
        #10;

        $display("Memory Write and Read Test 2:");
        $display("Written Data: %d", data_to_write);
        $display("Read Data: %d", result);

        $finish;
    end
endmodule
