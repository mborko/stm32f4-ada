pragma Ada_95;
pragma Warnings (Off);
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

package body ada_main is

   E005 : Short_Integer; pragma Import (Ada, E005, "ada__real_time_E");
   E089 : Short_Integer; pragma Import (Ada, E089, "system__tasking__protected_objects_E");
   E093 : Short_Integer; pragma Import (Ada, E093, "system__tasking__protected_objects__multiprocessors_E");
   E085 : Short_Integer; pragma Import (Ada, E085, "system__tasking__restricted__stages_E");
   E067 : Short_Integer; pragma Import (Ada, E067, "last_chance_handler_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "leds_E");
   E076 : Short_Integer; pragma Import (Ada, E076, "lis3dsh_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "lis3dsh__spi_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "stm32__adc_E");
   E106 : Short_Integer; pragma Import (Ada, E106, "stm32__dac_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "stm32__exti_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "stm32__gpio_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "stm32__i2c_E");
   E130 : Short_Integer; pragma Import (Ada, E130, "stm32__spi_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "stm32__syscfg_E");
   E135 : Short_Integer; pragma Import (Ada, E135, "stm32__usarts_E");
   E069 : Short_Integer; pragma Import (Ada, E069, "serial_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "stm32__device_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "stm32__board_E");


   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");

      procedure Start_Slave_CPUs;
      pragma Import (C, Start_Slave_CPUs, "__gnat_start_slave_cpus");
   begin
      Main_Priority := 0;

      Ada.Real_Time'Elab_Body;
      E005 := E005 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E089 := E089 + 1;
      System.Tasking.Protected_Objects.Multiprocessors'Elab_Body;
      E093 := E093 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E085 := E085 + 1;
      leds'elab_spec;
      E076 := E076 + 1;
      E096 := E096 + 1;
      STM32.ADC'ELAB_SPEC;
      E103 := E103 + 1;
      E106 := E106 + 1;
      E119 := E119 + 1;
      E130 := E130 + 1;
      E112 := E112 + 1;
      STM32.DEVICE'ELAB_SPEC;
      E099 := E099 + 1;
      E135 := E135 + 1;
      E117 := E117 + 1;
      E124 := E124 + 1;
      STM32.BOARD'ELAB_SPEC;
      E073 := E073 + 1;
      E069 := E069 + 1;
      leds'elab_body;
      E141 := E141 + 1;
      E067 := E067 + 1;
      Start_Slave_CPUs;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   procedure main is
      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      adainit;
      Ada_Main_Program;
   end;

--  BEGIN Object file/option list
   --   /home/mike/repositories/ada_/stm32f4-ada/uart/build/main.o
   --   /home/mike/repositories/ada_/stm32f4-ada/uart/build/serial.o
   --   /home/mike/repositories/ada_/stm32f4-ada/uart/build/leds.o
   --   /home/mike/repositories/ada_/stm32f4-ada/uart/build/last_chance_handler.o
   --   -L/home/mike/repositories/ada_/stm32f4-ada/uart/build/
   --   -L/home/mike/repositories/ada_/stm32f4-ada/uart/build/
   --   -L/home/mike/repositories/ada_/stm32f4-ada/Ada_Drivers_Library/boards/lib/stm32f407disco/ravenscar-sfp/Debug/
   --   -L/home/mike/repositories/ada_/stm32f4-ada/Ada_Drivers_Library/boards/stm32f407_discovery/lib/stm32f407disco/ravenscar-sfp/Debug/
   --   -L/home/mike/repositories/ada_/stm32f4-ada/Ada_Drivers_Library/embedded-runtimes/ravenscar-stm32f407disco/sfp/adalib/
   --   -L/home/mike/repositories/ada_/stm32f4-ada/Ada_Drivers_Library/ARM/STM32/lib/stm32f407disco/ravenscar-sfp/Debug/
   --   -L/home/mike/repositories/ada_/stm32f4-ada/Ada_Drivers_Library/hal/lib/stm32f407disco/ravenscar-sfp/Debug/
   --   -L/home/mike/repositories/ada_/stm32f4-ada/Ada_Drivers_Library/ARM/cortex_m/lib/cortex-m4f/stm32f407disco/ravenscar-sfp/Debug/
   --   -L/home/mike/repositories/ada_/stm32f4-ada/Ada_Drivers_Library/components/lib/stm32f407disco/ravenscar-sfp/Debug/
   --   -L/home/mike/repositories/ada_/stm32f4-ada/Ada_Drivers_Library/services/lib/stm32f407disco/ravenscar-sfp/Debug/
   --   -L/home/mike/opt/gnat-gpl-2016-arm-elf-linux-bin/arm-eabi/lib/gnat/ravenscar-sfp-stm32f4/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
