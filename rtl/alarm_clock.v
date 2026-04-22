// ============================================
// Module:      alarm_clock
// Description: 24-hour digital alarm clock with
//              reset and alarm functionality
// Course:      EE411L      
// Date:        2025
// ============================================

module alarm_clock(
    input        clk,           // Clock input
    input        rst,           // Active-high synchronous reset
    input  [5:0] rst_min,       // Reset minute value (valid range: 0-59)
    input  [4:0] rst_hr,        // Reset hour value   (valid range: 0-23)
    input  [5:0] a_min,         // Alarm minute setting (valid range: 0-59)
    input  [4:0] a_hr,          // Alarm hour setting   (valid range: 0-23)
    output [5:0] sec,           // Current seconds output
    output [5:0] min,           // Current minutes output
    output [4:0] hr,            // Current hours output
    output       alarm_flag     // High when current time matches alarm time
);

    // ---- Internal Time Registers ----
    // sec/min: 6-bit to hold values 0-59 (2^6 - 1 = 63)
    // hr:      5-bit to hold values 0-23 (2^5 - 1 = 31)
    reg [5:0] curr_sec;
    reg [5:0] curr_min;
    reg [4:0] curr_hr;

    // ---- Sequential Logic: Time Counting & Reset ----
    // Note: rst_min and rst_hr are assumed to be valid (0-59 and 0-23
    // respectively). No hardware clamping is implemented; ensure inputs
    // are constrained at the system level.
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // On reset: seconds cleared, minutes and hours
            // set to user-defined values
            curr_sec <= 6'd0;
            curr_min <= rst_min;
            curr_hr  <= rst_hr;
        end else begin

            // ---- Seconds Counter ----
            if (curr_sec == 6'd59) begin
                curr_sec <= 6'd0;

                // ---- Minutes Counter ----
                if (curr_min == 6'd59) begin
                    curr_min <= 6'd0;

                    // ---- Hours Counter (24-hour format) ----
                    if (curr_hr == 5'd23)
                        curr_hr <= 5'd0;
                    else
                        curr_hr <= curr_hr + 1'b1;

                end else begin
                    curr_min <= curr_min + 1'b1;
                end

            end else begin
                curr_sec <= curr_sec + 1'b1;
            end

        end
    end

    // ---- Combinational Logic: Output Assignments ----
    assign sec = curr_sec;
    assign min = curr_min;
    assign hr  = curr_hr;

    // ---- Combinational Logic: Alarm Detection ----
    // alarm_flag is kept outside the always block to ensure
    // it responds immediately to time updates without a
    // one-cycle delay (avoids nonblocking assignment issue)
    assign alarm_flag = ((curr_min == a_min) && (curr_hr == a_hr)) ? 1'b1 : 1'b0;

endmodule
