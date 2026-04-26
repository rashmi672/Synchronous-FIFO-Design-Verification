class fifo_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(fifo_scoreboard)
  // Analysis port
  uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) item_collect_export;

  // Reference model (queue)
  bit [7:0] ref_q[$];
  
  // FIFO usable depth = DEPTH-1
  int MAX_DEPTH = 7; // for DEPTH=8

  function new(string name = "fifo_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_collect_export = new("item_collect_export", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write(fifo_seq_item tx);

    // ---------------- WRITE ----------------
    if (tx.wr_en && !tx.full) begin
      if (ref_q.size() < MAX_DEPTH) begin
        ref_q.push_back(tx.data_in);
        `uvm_info("SCOREBOARD", $sformatf("WRITE: data_in=%0h, queue_size=%0d", tx.data_in, ref_q.size()), UVM_LOW)
      end
      else begin
        `uvm_warning("SCOREBOARD", "Write attempted when queue full (ignored)")
      end
    end

    // ---------------- READ ----------------
    if (tx.rd_en && !tx.empty) begin
      if (ref_q.size() > 0) begin
        bit [7:0] exp_data;
        exp_data = ref_q.pop_front();

        // Compare with DUT
        if (tx.data_out !== exp_data) begin
          `uvm_error("FIFO_MISMATCH", $sformatf("Expected=%0h, Got=%0h", exp_data, tx.data_out))
        end
        else begin
          `uvm_info("FIFO_MATCH", $sformatf("Match OK: data=%0h", tx.data_out), UVM_LOW)
        end
      end
      else begin
        `uvm_warning("SCOREBOARD", "Read attempted on empty queue")
      end
    end

  endfunction
  
endclass
