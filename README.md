# Snake Game on an FPGA

This project implements our version of Snake on the Digilent Zedboard Zynq-7000 FPGA using the Veriog HDL and Vivado. Some features of this implementation are:
- Changing border type using the hardware switches on the FPGA, adjusting the game difficulty
- Flashing LED lights and red screen on the FPGA on Game Over
- 640x480 game resolution (25MHz pixel clock) and 25Hz update frequency
- Psuedorandom apple generation using the pixel clock

Some elements of this project have been designd for this FPGA, such as the clock dividers, flashing LEDs, and constraints. To implement on a different FPGA,
some changes will be required.


![Border1](https://user-images.githubusercontent.com/68986416/97433737-fe025100-1943-11eb-9b5a-c47ee130ec82.png)
Border Style 1







![Border2](https://user-images.githubusercontent.com/68986416/97433747-0064ab00-1944-11eb-891a-27c10ce841f0.png)
Border Style 2







![GameOver](https://user-images.githubusercontent.com/68986416/97433750-0195d800-1944-11eb-953f-0ee50814588b.png)
Game Over Screen
