interface fifo_if (input clk, input rstn);
	logic wr_en;
	logic rd_en;
  	logic [7:0] data_in;
  	logic [7:0] data_out;
	logic empty;
	logic full;
endinterface