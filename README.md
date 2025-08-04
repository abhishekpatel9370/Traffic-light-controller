# Traffic Light Controller (FPGA)

## Overview
This project implements a **traffic light controller** using Verilog HDL on an FPGA board.  
The controller manages two-way traffic (North-South and East-West) with the following sequence:
- **NS Green → NS Yellow → EW Green → EW Yellow → repeat**

The design includes:
- **Clock divider** to convert a 100 MHz FPGA clock to 1 Hz.
- **Finite State Machine (FSM)** for light control.
- **Synchronous reset** to initialize the system.

---

## Features
- **North-South (NS) and East-West (EW) traffic lights**:
  - `3-bit` output for each direction:
    - Bit `[2]` → Red
    - Bit `[1]` → Yellow
    - Bit `[0]` → Green
- **Timing**:
  - NS Green: 5 seconds
  - NS Yellow: 2 seconds
  - EW Green: 5 seconds
  - EW Yellow: 2 seconds
- Designed for human-visible LED blinking on FPGA.

  ## How It Works
### FSM States
- **S_NS_GREEN** → NS = Green, EW = Red (5s)
- **S_NS_YELLOW** → NS = Yellow, EW = Red (2s)
- **S_EW_GREEN** → NS = Red, EW = Green (5s)
- **S_EW_YELLOW** → NS = Red, EW = Yellow (2s)

### Clock Divider
- Converts 100 MHz clock to 1 Hz.
- Generates `one_sec_tick` for state timing.

---

## Requirements
- **Xilinx Vivado (2020.2 or later)** or equivalent version.
- FPGA board (tested on **Basys3 / Nexys A7**).
- USB JTAG cable and drivers installed.

---

## Steps to Run
1. **Clone the repository** or copy source files.
2. **Open Vivado** and create a new project.
3. **Add the Verilog source file** (`traffic_controller.v`) and constraints file (`traffic_controller.xdc`).
4. **Synthesize, implement, and generate bitstream**:

    launch_runs synth_1
    launch_runs impl_1 -to_step write_bitstream
    open_hw_manager
    launch_hw_server
    connect_hw_server
    open_hw_target
    program_hw_devices
