`timescale 1ns/1ps

module program_counter_tb;

reg clk;
reg reset;
reg [31:0] in_pc;
wire [31:0] out_pc;

// DUT instantiation
program_counter pc(
    .clk(clk),
    .reset(reset),
    .in_pc(in_pc),
    .out_pc(out_pc)
);

// Clock generation (10ns period)
always #5 clk = ~clk;

// Monitor
initial begin
    $monitor("Time=%0t | clk=%b reset=%b in_pc=%h out_pc=%h",
              $time, clk, reset, in_pc, out_pc);
end

// Stimulus
initial begin
    // Initialize
    clk   = 0;
    reset = 1;
    in_pc = 32'h0000_0000;

    // Apply reset for 2 clock cycles
    #20;
    reset = 0;

    // Apply new PC values (aligned to clock edges)
    @(posedge clk);
    in_pc = 32'h0000_0505;

    @(posedge clk);
    in_pc = 32'h0000_5555;

    @(posedge clk);
    in_pc = 32'h0000_FFFF;

    // Assert reset again
    @(posedge clk);
    reset = 1;

    @(posedge clk);
    reset = 0;

    @(posedge clk);
    in_pc = 32'h0000_0555;

    #20;
    $finish;
end

endmodule