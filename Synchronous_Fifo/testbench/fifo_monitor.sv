class fifo_monitor extends uvm_monitor;
  virtual fifo_if vif;
  uvm_analysis_port #(fifo_seq_item) item_collect_port;
  fifo_seq_item mon_item;
  `uvm_component_utils(fifo_monitor)
  
  function new(string name = "fifo_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_collect_port = new("item_collect_port", this);
    mon_item = new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_if) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction
  
  task run_phase (uvm_phase phase);
    `uvm_info("MON", "Monitor run_phase started", UVM_NONE)
    forever begin
      @(posedge vif.clk);
      if(!vif.rstn) continue;
      mon_item.wr_en 		= vif.wr_en;
	  mon_item.data_in 		= vif.data_in;
      mon_item.full	 		= vif.full;
      @(posedge vif.clk);
      mon_item.data_out = vif.data_out;
      mon_item.rd_en 		= vif.rd_en;
      mon_item.empty 		= vif.empty;
      item_collect_port.write(mon_item);
      `uvm_info("MON", "Transaction sent to scoreboard", UVM_NONE)
      $display("WRITE: %0h, wr_en=%0b", vif.data_in, vif.wr_en);
      $display("READ : %0h, rd_en=%0b", vif.data_out, vif.rd_en);
    end
  endtask
endclass