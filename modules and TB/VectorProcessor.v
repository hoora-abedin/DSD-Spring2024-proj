module VecotrProcessor (
    input wire clk,
    input wire [8:0] memmory_address,
    input wire [1:0] resister_a_address,
    input wire [1:0] register_b_address,
    input wire [1:0] register_address_to_write,
    input wire [511:0] data_to_write,
    input wire write_enable,
    input wire [1:0] alu_opcode,
    input wire mem_write_enable,
    output wire [511:0] result
);
    wire [511:0] register_a;
    wire [511:0] register_b;
    wire [511:0] alu_least_sig;
    wire [511:0] alu_most_sig;
    wire [511:0] memmory_data;
    RegisterFile registerFile (
        .clk(clk),
        .read_from_a_address(resister_a_address),
        .read_from_b_address(register_b_address),
        .address_to_write(register_address_to_write),
        .data_to_write(data_to_write),
        .write_enable(write_enable),
        .data_from_a(register_a),
        .data_from_b(register_b)
    );
    ALU alu (
        .A(register_a),
        .B(register_b),
        .opcode(alu_opcode),
        .least_sig(alu_least_sig),
        .most_sig(alu_most_sig)
    );
    Memory memory (
        .clk(clk),
        .address(memmory_address),
        .data_to_write(data_to_write),
        .write_enable(mem_write_enable),
        .data_from_memmory(memmory_data)
    );

    assign result = memmory_data;
endmodule
