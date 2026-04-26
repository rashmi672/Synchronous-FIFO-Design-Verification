module synchronous_fifo #(parameter DEPTH=8, DATA_WIDTH=8) (
  input clk, rstn,
  input wr_en, rd_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output full, empty
);
  
  reg [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr;
  reg [DATA_WIDTH-1:0] fifo[DEPTH];
  
  // Set Default values on reset.
  always@(posedge clk) begin
    if(!rstn) begin
      wr_ptr <= 0; 
      rd_ptr <= 0;
      data_out <= 0;
    end
  end
  
  // To write data to FIFO
  always@(posedge clk) begin
    if(wr_en & !full)begin
      fifo[wr_ptr] <= data_in;
      wr_ptr <= wr_ptr + 1;
    end
  end
  
  // To read data from FIFO
  always@(posedge clk) begin
    if(rd_en & !empty) begin
      data_out <= fifo[rd_ptr];
      rd_ptr <= rd_ptr + 1;
    end
  end
  
  assign full = ((wr_ptr+1'b1) == rd_ptr);
  assign empty = (wr_ptr == rd_ptr);
endmodule
