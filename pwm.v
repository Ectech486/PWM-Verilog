`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: keval m parmar
// 
// Create Date: 23.12.2024 15:52:50
// Design Name: 
// Module Name: 
// Project Name: Generator creates a 10MHz PWM signal with variable duty cycle
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// Two debounced buttons are used to control the duty cycle (step size: 10%)

module PWM_Generator_Verilog (
    input clk,              // 100 MHz system clock
    input increase_duty,    // Button to increase duty cycle by 10%
    input decrease_duty,    // Button to decrease duty cycle by 10%
    output PWM_OUT          // 10 MHz PWM output
);

    reg [27:0] counter_debounce = 0; // Counter for generating slow clock enable pulse (~4Hz)
    wire slow_clk_enable;            // Enable signal for debouncing flip-flops

    // Temporary signals for button debouncing
    wire tmp1, tmp2, duty_inc;
    wire tmp3, tmp4, duty_dec;

    reg [3:0] counter_PWM = 0;       // 4-bit counter for 10 MHz PWM signal (counts 0-9)
    reg [3:0] DUTY_CYCLE = 5;        // Duty cycle level (initially 50%)

    // Generate slow clock enable signal for debouncing (simulation: when counter == 1)
    always @(posedge clk) begin
        counter_debounce <= counter_debounce + 1;
        if (counter_debounce >= 1)
            counter_debounce <= 0;
    end
    assign slow_clk_enable = (counter_debounce == 1);

    // Debouncing logic for increase_duty button (rising edge detection)
    DFF_PWM PWM_DFF1(clk, slow_clk_enable, increase_duty, tmp1);
    DFF_PWM PWM_DFF2(clk, slow_clk_enable, tmp1, tmp2);
    assign duty_inc = tmp1 & ~tmp2 & slow_clk_enable;

    // Debouncing logic for decrease_duty button (rising edge detection)
    DFF_PWM PWM_DFF3(clk, slow_clk_enable, decrease_duty, tmp3);
    DFF_PWM PWM_DFF4(clk, slow_clk_enable, tmp3, tmp4);
    assign duty_dec = tmp3 & ~tmp4 & slow_clk_enable;

    // Update duty cycle on valid button press
    always @(posedge clk) begin
        if (duty_inc && DUTY_CYCLE <= 9)
            DUTY_CYCLE <= DUTY_CYCLE + 1; // Increase by 10%
        else if (duty_dec && DUTY_CYCLE >= 1)
            DUTY_CYCLE <= DUTY_CYCLE - 1; // Decrease by 10%
    end

    // Generate 10 MHz PWM signal with adjustable duty cycle
    always @(posedge clk) begin
        counter_PWM <= counter_PWM + 1;
        if (counter_PWM >= 9)
            counter_PWM <= 0;
    end
    assign PWM_OUT = (counter_PWM < DUTY_CYCLE) ? 1 : 0;

endmodule

// D Flip-Flop with enable for button debouncing
module DFF_PWM(
    input clk,      // Clock signal
    input en,       // Enable signal (slow clock)
    input D,        // Input data
    output reg Q    // Output data
);
    always @(posedge clk) begin
        if (en)
            Q <= D;
    end
endmodule
  
