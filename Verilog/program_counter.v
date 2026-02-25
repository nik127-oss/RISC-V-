module program_counter #(
    parameter WIDTH = 32
)(
    input clk,
    input reset,
    input [WIDTH-1:0] in_pc,
    output reg [WIDTH-1:0] out_pc
);

always @(posedge clk) begin
    if (reset)
        out_pc <= {WIDTH{1'b0}};
    else
        out_pc <= in_pc;
end

endmodule   