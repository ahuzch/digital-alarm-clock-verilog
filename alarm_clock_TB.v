module alarm_clock_TB;
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
  initial clk = 0;
  always #1 clk = ~clk;
  initial begin
    $shm_open("shm.db", 1);
    $shm_probe("AS");
    rst = 0;
    rst_min = 6'd0; // Start at 0 minutes
    rst_hr = 5'd0; // Start at 0 hours
    a_min = 6'd2; // Alarm at 2 minutes
    a_hr = 5'd0;
    #5 rst = 1; // Apply reset
    #5 rst = 0; // Release reset
    #300 $finish;
  end
endmodule
