`default_nettype none
`timescale 1ns/1ps

module tb();
    // Dump waveform
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

// testbench is controlled by test.py

  // wire up the inputs and outputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  reg rx;
  wire tx;
  assign tx = uo_out[0];

  `ifdef GL_TEST
    wire VPWR = 1'b1;
    wire VGND = 1'b0;
  `endif


  tt_um_prem_pipeline_test tt_um_prem_pipeline_test (
      // include power ports for the Gate Level test
`ifdef GL_TEST
      .VPWR(1'b1),
      .VGND(1'b0),
`endif
    .ui_in({7'b0, rx}),    // Dedicated inputs (unused for UART now)
    .uo_out(uo_out),   // Dedicated outputs
    .uio_in(uio_in),   // IOs: Input path
    .uio_out(uio_out),  // IOs: Output path
    .uio_oe(uio_oe),   // IOs: Enable path
    .ena(ena),      // always 1 when powered
    .clk(clk),      // clock
    .rst_n(rst_n)    // reset_n
  );

endmodule