class fifo_seq_item extends uvm_sequence_item;
  rand bit [7:0] data_in;
  rand bit wr_en, rd_en;
  bit [7:0] data_out;
  bit full, empty;
  
  `uvm_object_utils(fifo_seq_item)
  
  function new(string name = "seq_item");
    super.new(name);
  endfunction
    
  constraint wr_rd_c {wr_en != rd_en;}
  
  function string txn_print();
    `uvm_info("WRITE TXN", $sformatf("data_in=%0h, wr_en=%0d, full=%0d", data_in, wr_en, full), UVM_LOW)
    `uvm_info("READ TXN", $sformatf("data_out=%0h, rd_en=%0d, empty=%0d", data_out, rd_en, empty), UVM_LOW)
  endfunction
endclass