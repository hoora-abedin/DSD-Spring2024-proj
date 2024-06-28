module Memory (
    input wire clk,
    input wire [8:0] address,
    input wire [511:0] data_to_write,
    input wire write_enable,
    output reg [511:0] data_from_memmory
);
    reg [31:0] memory [511:0];

    always @(posedge clk) begin
        if (write_enable)
            {memory[address+15], memory[address+14], memory[address+13], memory[address+12], memory[address+11], memory[address+10], memory[address+9], memory[address+8],
             memory[address+7], memory[address+6], memory[address+5], memory[address+4], memory[address+3], memory[address+2], memory[address+1], memory[address]} <= data_to_write;
    end

    always @(*) begin
        data_from_memmory = {memory[address+15], memory[address+14], memory[address+13], memory[address+12], memory[address+11], memory[address+10], memory[address+9], memory[address+8],
                   memory[address+7], memory[address+6], memory[address+5], memory[address+4], memory[address+3], memory[address+2], memory[address+1], memory[address]};
    end
endmodule
