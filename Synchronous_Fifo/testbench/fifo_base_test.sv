class fifo_base_test extends uvm_test;
  fifo_env env_o;
  fifo_base_seq bseq;
  `uvm_component_utils(fifo_base_test)
  
  function new(string name = "fifo_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = fifo_env::type_id::create("env_o", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    bseq = fifo_base_seq::type_id::create("bseq");
        
    #5; bseq.start(env_o.agt.seqr);
    
    phase.drop_objection(this);
    `uvm_info(get_type_name(), "End of testcase", UVM_LOW);
  endtask
endclass