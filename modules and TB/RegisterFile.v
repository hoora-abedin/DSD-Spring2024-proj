module RegisterFile (
    input wire clk,
    input wire [1:0] read_from_a_address,
    input wire [1:0] read_from_b_address,
    input wire [1:0] address_to_write,
    input wire [511:0] data_to_write,
    input wire write_enable,
    output reg [511:0] data_from_a,
    output reg [511:0] data_from_b
);
    reg [511:0] A1, A2, A3, A4;
    
    always @(posedge clk) begin
        if (write_enable) begin
            case (address_to_write)
                2'b00: A1 <= data_to_write;
                2'b01: A2 <= data_to_write;
                2'b10: A3 <= data_to_write;
                2'b11: A4 <= data_to_write;
            endcase
        end
    end

    always @(*) begin
        case (read_from_a_address)
            2'b00: data_from_a = A1;
            2'b01: data_from_a = A2;
            2'b10: data_from_a = A3;
            2'b11: data_from_a = A4;
        endcase
        case (read_from_b_address)
            2'b00: data_from_b = A1;
            2'b01: data_from_b = A2;
            2'b10: data_from_b = A3;
            2'b11: data_from_b = A4;
        endcase
    end
endmodule


