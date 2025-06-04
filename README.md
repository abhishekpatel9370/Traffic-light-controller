# 🚦 Traffic Light Controller (Verilog)

This project implements an intelligent **Traffic Light Controller** using Verilog HDL, designed to efficiently manage traffic at an intersection between a **highway road** and a **city street**.

## 📘 Project Overview

In traditional traffic light systems, the timer-based red and green signals operate independently of real-time traffic conditions. For example, even when no vehicle is present on the city road, the highway may still receive a red signal for a fixed 60 seconds, causing unnecessary delays.

This project addresses this inefficiency by integrating **vehicle sensors** on both roads. Based on vehicle presence, the controller adjusts the signal timers dynamically to reduce waiting time and improve traffic flow.

## 🧠 Key Features

- **Sensor-Based Logic:**  
  Sensors detect the presence or absence of vehicles on both city and highway roads.

- **Dynamic Timer Adjustment:**  
  - Default highway signal duration: **60 seconds**  
  - Default city signal duration: **50 seconds**  
  - If **no vehicle** is detected on the city road, highway timer increases by **10 seconds**
  - Similarly, if **no vehicle** is on the highway, the city timer increases by **10 seconds**

- **Optimized Waiting Time:**  
  Prevents unnecessary delays by skipping green signals where no vehicle is waiting.

## ⚙️ How It Works

1. **Initialization:**  
   Timers are set to their default durations: 60s for highway, 50s for city road.

2. **Sensor Input Evaluation:**  
   At each cycle, vehicle presence is evaluated from sensors.

3. **Timer Adjustment Logic:**  
   - If a road has no vehicle detected, the opposite road gets an extended green signal by 10s.
   - Normal signal sequence continues otherwise.

4. **Signal Switching:**  
   Traffic lights toggle between red, yellow, and green based on current timer and sensor inputs.

## 📂 Files

- `traffic_light.v`: Main Verilog module for traffic light control logic.
- `testbench.v`: Testbench to simulate and verify traffic behavior.
- `README.md`: Project documentation.

## 🧪 Simulation & Testing

Use ModelSim, Vivado, or any Verilog simulation tool to run the testbench and visualize the signal changes using waveforms or console outputs.

## 🛠 Tools Used

- Verilog HDL
- ModelSim / Vivado
- FPGA-ready design logic

## 📈 Impact

This controller improves real-world traffic efficiency by:

- Minimizing vehicle idle time
- Reducing fuel wastage and pollution
- Enhancing intelligent traffic management in smart cities

---

Feel free to clone, modify, and deploy this controller for research or practical implementations. 🚗💡🚦
