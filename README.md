# stm32f4-ada
Coding examples in Ada for STM32F4-Discovery

To be able to compile the examples you have to download the [GNAT GPL Ada][https://www.adacore.com/download] from AdaCore. Be aware to put the **./bin** Directory to your PATH variable.

For the HAL and Library Support use the [GitHub Repository][https://github.com/AdaCore/Ada_Drivers_Library] from AdaCore:

## Ada Drivers Library
You should clone the AdaCore Libraries with the *--recursive* option (and afterwards link to it):

    git clone --recursive https://github.com/AdaCore/Ada_Drivers_Library.git

Don't forget to compile the embedded-runtimes with **make all**!

	cd Ada_Drivers_Library/embedded-runtimes
    make all

## Compiling and running the examples
After linking the Ada_Drivers_Library and setting up the gpr-tools, the Makefiles in the subdirectories will help to compile and flash the code to the STM-Board.
