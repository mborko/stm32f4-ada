pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__demo.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__demo.adb");
pragma Suppress (Overflow_Check);

package body ada_main is
   pragma Warnings (Off);

   E06 : Short_Integer; pragma Import (Ada, E06, "ada__real_time_E");
   E73 : Short_Integer; pragma Import (Ada, E73, "system__tasking__protected_objects_E");
   E77 : Short_Integer; pragma Import (Ada, E77, "system__tasking__protected_objects__multiprocessors_E");
   E71 : Short_Integer; pragma Import (Ada, E71, "system__tasking__restricted__stages_E");
   E03 : Short_Integer; pragma Import (Ada, E03, "driver_E");
   E87 : Short_Integer; pragma Import (Ada, E87, "last_chance_handler_E");
   E79 : Short_Integer; pragma Import (Ada, E79, "registers_E");
   E64 : Short_Integer; pragma Import (Ada, E64, "button_E");
   E85 : Short_Integer; pragma Import (Ada, E85, "leds_E");


   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");

      procedure Install_Restricted_Handlers_Sequential;
      pragma Import (C,Install_Restricted_Handlers_Sequential, "__gnat_attach_all_handlers");

      Partition_Elaboration_Policy : Character;
      pragma Import (C, Partition_Elaboration_Policy, "__gnat_partition_elaboration_policy");

      procedure Activate_All_Tasks_Sequential;
      pragma Import (C, Activate_All_Tasks_Sequential, "__gnat_activate_all_tasks");
   begin
      Main_Priority := 0;
      Partition_Elaboration_Policy := 'S';

      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E06 := E06 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E73 := E73 + 1;
      System.Tasking.Protected_Objects.Multiprocessors'Elab_Body;
      E77 := E77 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E71 := E71 + 1;
      Driver'Elab_Spec;
      Registers'Elab_Spec;
      E79 := E79 + 1;
      Button'Elab_Body;
      E64 := E64 + 1;
      Leds'Elab_Body;
      E85 := E85 + 1;
      E87 := E87 + 1;
      Driver'Elab_Body;
      E03 := E03 + 1;
      Install_Restricted_Handlers_Sequential;
      Activate_All_Tasks_Sequential;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_demo");

   procedure main is
      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      adainit;
      Ada_Main_Program;
   end;

--  BEGIN Object file/option list
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/demo.o
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/stm32f4.o
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/stm32f4-gpio.o
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/stm32f4-reset_clock_control.o
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/stm32f4-sysconfig_control.o
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/registers.o
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/button.o
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/leds.o
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/last_chance_handler.o
   --   /home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/driver.o
   --   -L/home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/
   --   -L/home/mike/repositories/stm32_/stm32f4-ada/demo_leds/build/
   --   -L/home/mike/opt/gnat-gpl-2015-arm-elf-linux-bin/arm-eabi/lib/gnat/ravenscar-sfp-stm32f4/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
