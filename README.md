# Snake Game on an FPGA

This project implements our version of Snake on the Digilent Zedboard Zynq-7000 FPGA using the Veriog HDL and Vivado. Some features of this implementation are:
- Changing border type using the hardware switches on the FPGA, adjusting the game difficulty
- Flashing LED lights and red screen on the FPGA on Game Over
- 640x480 game resolution (25MHz pixel clock) and 25Hz update frequency
- Psuedorandom apple generation using the pixel clock

Some elements of this project have been designd for this FPGA, such as the clock dividers, flashing LEDs, and constraints. To implement on a different FPGA,
some changes will be required.
