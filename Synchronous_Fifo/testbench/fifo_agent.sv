class fifo_agent extends uvm_agent;
  `uvm_component_utils(fifo_agent)
  fifo_driver drv;
  fifo_seqcr seqr;
  fifo_monitor mon;
  
  function new(string name = "fifo_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(get_is_active == UVM_ACTIVE) begin 
      drv = fifo_driver::type_id::create("drv", this);
      seqr = fifo_seqcr::type_id::create("seqr", this);
    end
    
    mon = fifo_monitor::type_id::create("mon", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(get_is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction
endclass