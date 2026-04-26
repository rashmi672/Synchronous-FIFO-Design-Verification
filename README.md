# 🧠 Synchronous FIFO Design & Verification (SystemVerilog + UVM)

This project implements a parameterized **Synchronous FIFO** in SystemVerilog and verifies it using a structured testbench (UVM-style methodology).

---

## 📌 Features

- Parameterized FIFO (`DEPTH`, `DATA_WIDTH`)
- Circular buffer implementation
- Separate read and write pointers
- Full and Empty flag generation
- Cycle-accurate stimulus handling
- Debugged for real-world timing issues

---

## 🏗️ Design Overview

The FIFO operates synchronously with a single clock and supports:

- **Write Operation**
  - Happens when `wr_en = 1` and FIFO is not full
- **Read Operation**
  - Happens when `rd_en = 1` and FIFO is not empty

---

## 🔁 FIFO Behavior

- Circular buffer using pointers
- Pointer wrap-around is expected:

📊 Simulation Observations
- Data mismatch was due to incorrect driver timing
- Fixing driver alignment solved:
- Multi-cycle data hold issue
- Incorrect reads
- Pointer confusion


🚀 Future Improvements
- Add occupancy counter
- Improve full/empty logic (true depth usage)
- Add assertions (SVA)
- Integrate full UVM scoreboard
- Add coverage metrics

🛠️ Tools Used
- SystemVerilog
- UVM (conceptual)
- EDA Playground / Simulator

📬 Author

Rashmi Singh
Design Verification Engineer
