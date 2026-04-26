class fifo_driver extends uvm_driver#(fifo_seq_item);
  virtual fifo_if vif;
  `uvm_component_utils(fifo_driver)
  
  function new(string name = "fifo_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_if) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction
  
  task run_phase (uvm_phase phase);
    forever begin
      fifo_seq_item fifo_seq_tx;
      // Driver to the DUT
      seq_item_port.get_next_item(fifo_seq_tx);
      uvm_report_info("FIFO_SEQUENCE ", $psprintf("Driver %s", fifo_seq_tx.txn_print()));
      @(posedge vif.clk);
      vif.wr_en <= fifo_seq_tx.wr_en;
      vif.rd_en <= fifo_seq_tx.rd_en;
      vif.data_in <= fifo_seq_tx.data_in;
      seq_item_port.item_done();
    end
  endtask
endclass