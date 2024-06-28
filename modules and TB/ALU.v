module ALU (
    input wire [511:0] A,
    input wire [511:0] B,
    input wire [1:0] opcode,
    output reg [511:0] least_sig,
    output reg [511:0] most_sig
);
    always @(*) begin
        case (opcode)
            2'b00: {most_sig, least_sig} = A + B;
            2'b01: {most_sig, least_sig} = A * B;
            default: {most_sig, least_sig} = 0;
        endcase
    end
endmodule
