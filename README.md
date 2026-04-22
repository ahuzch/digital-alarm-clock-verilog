# Digital Alarm Clock — VLSI Design Project

A 24-hour digital alarm clock designed in Verilog HDL, simulated using Cadence, 
and synthesized using fast and slow standard cell libraries.

---

## File Structure
alarm_clock/
├── rtl/
│   └── alarm_clock.v
├── simulation/
│   └── alarm_clock_TB.v
├── constraint/
│   └── constraints_top.sdc
├── synthesis/
│   └── rc_script.tcl
└── reports/
├── waveforms/
│   ├── reset_function.png
│   ├── one_minute.png
│   ├── one_hour.png
│   └── alarm_flag.png
└── synthesis/
├── schematic_fast.png
├── schematic_slow.png
├── power_fast.png
├── power_slow.png
├── netlist_stats_fast.png
├── netlist_stats_slow.png
├── gate_count_fast.png
└── gate_count_slow.png
