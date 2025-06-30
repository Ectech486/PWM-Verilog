# PWM-Verilog
Generator creates a 10MHz PWM signal with variable duty cycle

<p align="justify">
  **=> What is Pulse Width Modulation? :-** 
  
Pulse width modulation reduces the average power delivered by an electrical signal by converting the signal into discrete parts. In the PWM technique, the signal’s energy is distributed through a series of pulses rather than a continuously varying (analogue) signal.
</p>
<p align="justify"> 
  **=> How is a Pulse Width Modulation Signal generated? :-**
  
A pulse width modulating signal is generated using a comparator. The modulating signal forms one part of the input to the comparator, while the non-sinusoidal wave or sawtooth wave forms the other part of the input. The comparator compares two signals and generates a PWM signal as its output waveform.
  
If the sawtooth signal is more than the modulating signal, then the output signal is in a “High” state. The value of the magnitude determines the comparator output which defines the width of the pulse generated at the output.
</p>

![image alt](https://github.com/Ectech486/PWM-Verilog/blob/6d3343ff7f07d63840af990bc039990852ebefcd/pwm_waveout.png)
