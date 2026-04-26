// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

`include "package.sv"

module testbench;
  bit clk;
  bit rstn;
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 0;
    rstn = 1;
    #5; 
    rstn = 0;
  end
  fifo_if vif(clk, rstn);
  
  synchronous_fifo dut(.clk(vif.clk), .rstn(vif.rstn), .wr_en(vif.wr_en), .rd_en(vif.rd_en), .data_in(vif.data_in), .data_out(vif.data_out), .full(vif.full), .empty(vif.empty));
  
  initial begin
    // set interface in config_db
    uvm_config_db#(virtual fifo_if)::set(uvm_root::get(), "*", "vif", vif);
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, testbench);
  end
  
  initial begin
    run_test("fifo_base_test");
  end
endmodule