// ============================================
// Module:      alarm_clock_TB
// Description: Testbench for 24-hour digital alarm
//              clock with reset and alarm functionality
// Course:      EE411L      
// Date:        April 2025
// ============================================

module alarm_clock_TB;

  // ---- Testbench Signal Declarations ----
  reg clk;
  reg rst;
  reg [5:0] rst_min;
  reg [4:0] rst_hr;
  reg [5:0] a_min;
  reg [4:0] a_hr;
  wire [5:0] sec;
  wire [5:0] min;
  wire [4:0] hr;
  wire alarm_flag;

  // ---- DUT Instantiation ----
  alarm_clock dut (
    .clk(clk),
    .rst(rst),
    .rst_min(rst_min),
    .rst_hr(rst_hr),
    .a_min(a_min),
    .a_hr(a_hr),
    .sec(sec),
    .min(min),
    .hr(hr),
    .alarm_flag(alarm_flag)
  );
  
  // ---- Clock Generation ----
  // Clock toggles every 1 time unit -> period = 2 time units
  // Each positive edge represents 1 second of clock time
  initial clk = 0;
  always #1 clk = ~clk;

  // ---- Stimulus ----
  initial begin
    
    // Waveform dumping for Cadence simulation
    $shm_open("shm.db", 1);
    $shm_probe("AS");

    // ---- Initialization ---- 
    rst = 0;
    rst_min = 6'd0; // Start at 0 minutes
    rst_hr = 5'd0; // Start at 0 hours
    a_min = 6'd2; // Alarm at 2 minutes
    a_hr = 5'd0;

    // ---- Reset Sequence ----
    // Assert reset at 5 time units, deassert at 10 time units
    // This clears seconds and loads rst_min/rst_hr into the clock
    #5 rst = 1; // Apply reset
    #5 rst = 0; // Release reset

    // ---- Run Simulation ----
    // 300 time units is sufficient to observe:
    // - Normal time counting (seconds -> minutes)
    // - Alarm flag assertion at 00:02:00
    // - Alarm flag deassertion after 1 minute
    #300 $finish;
  end
endmodule
