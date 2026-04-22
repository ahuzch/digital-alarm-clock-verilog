module alarm_clock(
  input clk,
  input rst,
  input [5:0] rst_min, // Max: 60
  input [4:0] rst_hr, // Max: 24
  input [5:0] a_min,
  input [4:0] a_hr,
  output [5:0] sec,
  output [5:0] min,
  output [4:0] hr,
  output alarm_flag);
  
  // Time registers
  reg [5:0] curr_sec = 0;
  reg [5:0] curr_min = 0;
  reg [4:0] curr_hr = 0;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      curr_sec <= 6'd0;
      curr_min <= rst_min;
      curr_hr <= rst_hr;
    end else begin
      if (curr_sec == 6'd59) begin
        curr_sec <= 6'd0;
        if (curr_min == 6'd59) begin
          curr_min <= 6'd0;
            
          if (curr_hr == 5'd23)
            curr_hr <= 5'd0;
          else
            curr_hr <= curr_hr + 1;
        end else begin
          curr_min <= curr_min + 1;
        end
      end else begin
        curr_sec <= curr_sec + 1;
      end
    end
  end
  
  // Assign current time
  assign sec = curr_sec;
  assign min = curr_min;
  assign hr = curr_hr;
  assign alarm_flag = (curr_min == a_min && curr_hr == a_hr) ?
1'b1 : 1'b0;

endmodule
