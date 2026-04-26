class fifo_base_seq extends uvm_sequence#(fifo_seq_item);
  fifo_seq_item fifo_seq_tx;
  `uvm_object_utils(fifo_base_seq)
  
  function new (string name = "fifo_base_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_info(get_type_name(), "FIFO Base seq: Inside Body", UVM_LOW);
//     `uvm_do(fifo_seq_tx);
    repeat (10) begin
      fifo_seq_tx = fifo_seq_item::type_id::create("fifo_seq_tx");
      start_item(fifo_seq_tx);
      assert(fifo_seq_tx.randomize());
      finish_item(fifo_seq_tx);
      #10;
  	end
    
  endtask
endclass