pragma Ada_95;
pragma Warnings (Off);
pragma Restrictions (No_Exception_Propagation);
with System;
package ada_main is


   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2016 (20160515-49)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure main;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#9ea81875#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#0bedc8d1#;
   pragma Export (C, u00002, "systemS");
   u00003 : constant Version_32 := 16#669e66b4#;
   pragma Export (C, u00003, "adaS");
   u00004 : constant Version_32 := 16#500583ea#;
   pragma Export (C, u00004, "ada__real_timeB");
   u00005 : constant Version_32 := 16#786da119#;
   pragma Export (C, u00005, "ada__real_timeS");
   u00006 : constant Version_32 := 16#4cf52eb9#;
   pragma Export (C, u00006, "system__task_primitivesS");
   u00007 : constant Version_32 := 16#a42390a4#;
   pragma Export (C, u00007, "system__os_interfaceS");
   u00008 : constant Version_32 := 16#bf33852c#;
   pragma Export (C, u00008, "system__bbS");
   u00009 : constant Version_32 := 16#ab2fb15d#;
   pragma Export (C, u00009, "system__bb__board_supportB");
   u00010 : constant Version_32 := 16#6c151b88#;
   pragma Export (C, u00010, "system__bb__board_supportS");
   u00011 : constant Version_32 := 16#eadacb78#;
   pragma Export (C, u00011, "system__bb__parametersS");
   u00012 : constant Version_32 := 16#5ab55268#;
   pragma Export (C, u00012, "interfacesS");
   u00013 : constant Version_32 := 16#82e7b966#;
   pragma Export (C, u00013, "interfaces__stm32S");
   u00014 : constant Version_32 := 16#6801d319#;
   pragma Export (C, u00014, "interfaces__stm32__rccS");
   u00015 : constant Version_32 := 16#e721877b#;
   pragma Export (C, u00015, "interfaces__bit_typesS");
   u00016 : constant Version_32 := 16#3f6bb452#;
   pragma Export (C, u00016, "system__unsigned_typesS");
   u00017 : constant Version_32 := 16#f96dcd41#;
   pragma Export (C, u00017, "system__bb__board_parametersS");
   u00018 : constant Version_32 := 16#201451fa#;
   pragma Export (C, u00018, "system__bb__mcu_parametersB");
   u00019 : constant Version_32 := 16#6dac22e3#;
   pragma Export (C, u00019, "system__bb__mcu_parametersS");
   u00020 : constant Version_32 := 16#be01e125#;
   pragma Export (C, u00020, "interfaces__stm32__pwrS");
   u00021 : constant Version_32 := 16#d9102d1f#;
   pragma Export (C, u00021, "system__stm32B");
   u00022 : constant Version_32 := 16#6becc10a#;
   pragma Export (C, u00022, "system__stm32S");
   u00023 : constant Version_32 := 16#0456b31f#;
   pragma Export (C, u00023, "system__machine_codeS");
   u00024 : constant Version_32 := 16#09705416#;
   pragma Export (C, u00024, "system__bb__cpu_primitivesB");
   u00025 : constant Version_32 := 16#7f0da441#;
   pragma Export (C, u00025, "system__bb__cpu_primitivesS");
   u00026 : constant Version_32 := 16#5e68f5cc#;
   pragma Export (C, u00026, "ada__exceptionsB");
   u00027 : constant Version_32 := 16#362ca14a#;
   pragma Export (C, u00027, "ada__exceptionsS");
   u00028 : constant Version_32 := 16#35088633#;
   pragma Export (C, u00028, "system__bb__threadsB");
   u00029 : constant Version_32 := 16#e1088a5c#;
   pragma Export (C, u00029, "system__bb__threadsS");
   u00030 : constant Version_32 := 16#b3720068#;
   pragma Export (C, u00030, "system__bb__protectionB");
   u00031 : constant Version_32 := 16#40543378#;
   pragma Export (C, u00031, "system__bb__protectionS");
   u00032 : constant Version_32 := 16#5b35ed67#;
   pragma Export (C, u00032, "system__bb__threads__queuesB");
   u00033 : constant Version_32 := 16#63341024#;
   pragma Export (C, u00033, "system__bb__threads__queuesS");
   u00034 : constant Version_32 := 16#1a7dc503#;
   pragma Export (C, u00034, "system__bb__cpu_primitives__multiprocessorsB");
   u00035 : constant Version_32 := 16#127f1e3a#;
   pragma Export (C, u00035, "system__bb__cpu_primitives__multiprocessorsS");
   u00036 : constant Version_32 := 16#5a83c3a4#;
   pragma Export (C, u00036, "system__multiprocessorsB");
   u00037 : constant Version_32 := 16#84179424#;
   pragma Export (C, u00037, "system__multiprocessorsS");
   u00038 : constant Version_32 := 16#9d9a565c#;
   pragma Export (C, u00038, "system__bb__timeB");
   u00039 : constant Version_32 := 16#eae8218f#;
   pragma Export (C, u00039, "system__bb__timeS");
   u00040 : constant Version_32 := 16#5080ab39#;
   pragma Export (C, u00040, "ada__tagsB");
   u00041 : constant Version_32 := 16#8cf2bb30#;
   pragma Export (C, u00041, "ada__tagsS");
   u00042 : constant Version_32 := 16#a56b3ef3#;
   pragma Export (C, u00042, "system__secondary_stackB");
   u00043 : constant Version_32 := 16#82fee897#;
   pragma Export (C, u00043, "system__secondary_stackS");
   u00044 : constant Version_32 := 16#dcb9a4e8#;
   pragma Export (C, u00044, "system__storage_elementsB");
   u00045 : constant Version_32 := 16#262e82d5#;
   pragma Export (C, u00045, "system__storage_elementsS");
   u00046 : constant Version_32 := 16#ce253456#;
   pragma Export (C, u00046, "system__bb__interruptsB");
   u00047 : constant Version_32 := 16#778a3b0f#;
   pragma Export (C, u00047, "system__bb__interruptsS");
   u00048 : constant Version_32 := 16#f588a4c0#;
   pragma Export (C, u00048, "system__bb__timing_eventsB");
   u00049 : constant Version_32 := 16#fe2209f8#;
   pragma Export (C, u00049, "system__bb__timing_eventsS");
   u00050 : constant Version_32 := 16#0941e52e#;
   pragma Export (C, u00050, "system__multiprocessors__fair_locksB");
   u00051 : constant Version_32 := 16#a70e2885#;
   pragma Export (C, u00051, "system__multiprocessors__fair_locksS");
   u00052 : constant Version_32 := 16#5f7c11fe#;
   pragma Export (C, u00052, "system__multiprocessors__spin_locksB");
   u00053 : constant Version_32 := 16#9ac42bf1#;
   pragma Export (C, u00053, "system__multiprocessors__spin_locksS");
   u00054 : constant Version_32 := 16#c0ab394a#;
   pragma Export (C, u00054, "system__parametersB");
   u00055 : constant Version_32 := 16#c2139b8e#;
   pragma Export (C, u00055, "system__parametersS");
   u00056 : constant Version_32 := 16#4190faa9#;
   pragma Export (C, u00056, "system__task_primitives__operationsB");
   u00057 : constant Version_32 := 16#a4cb5653#;
   pragma Export (C, u00057, "system__task_primitives__operationsS");
   u00058 : constant Version_32 := 16#e0fce7f8#;
   pragma Export (C, u00058, "system__task_infoB");
   u00059 : constant Version_32 := 16#8bf775d0#;
   pragma Export (C, u00059, "system__task_infoS");
   u00060 : constant Version_32 := 16#3de333df#;
   pragma Export (C, u00060, "system__taskingB");
   u00061 : constant Version_32 := 16#3c1e2214#;
   pragma Export (C, u00061, "system__taskingS");
   u00062 : constant Version_32 := 16#0f8eba36#;
   pragma Export (C, u00062, "system__tasking__debugB");
   u00063 : constant Version_32 := 16#6b583f9f#;
   pragma Export (C, u00063, "system__tasking__debugS");
   u00064 : constant Version_32 := 16#6a4c6cb2#;
   pragma Export (C, u00064, "ada__real_time__delaysB");
   u00065 : constant Version_32 := 16#64efb39b#;
   pragma Export (C, u00065, "ada__real_time__delaysS");
   u00066 : constant Version_32 := 16#45637594#;
   pragma Export (C, u00066, "last_chance_handlerB");
   u00067 : constant Version_32 := 16#d1bc38d5#;
   pragma Export (C, u00067, "last_chance_handlerS");
   u00068 : constant Version_32 := 16#7194282b#;
   pragma Export (C, u00068, "serialB");
   u00069 : constant Version_32 := 16#4b0abdf7#;
   pragma Export (C, u00069, "serialS");
   u00070 : constant Version_32 := 16#8c7590dd#;
   pragma Export (C, u00070, "stm32S");
   u00071 : constant Version_32 := 16#e5fbbce6#;
   pragma Export (C, u00071, "halS");
   u00072 : constant Version_32 := 16#06d2b0f2#;
   pragma Export (C, u00072, "stm32__boardB");
   u00073 : constant Version_32 := 16#878f58a1#;
   pragma Export (C, u00073, "stm32__boardS");
   u00074 : constant Version_32 := 16#2d3bc7df#;
   pragma Export (C, u00074, "hal__spiS");
   u00075 : constant Version_32 := 16#29e6d65a#;
   pragma Export (C, u00075, "lis3dshB");
   u00076 : constant Version_32 := 16#a24cac57#;
   pragma Export (C, u00076, "lis3dshS");
   u00077 : constant Version_32 := 16#748adc27#;
   pragma Export (C, u00077, "system__assertionsB");
   u00078 : constant Version_32 := 16#c660e445#;
   pragma Export (C, u00078, "system__assertionsS");
   u00079 : constant Version_32 := 16#800bd20c#;
   pragma Export (C, u00079, "ada__interruptsB");
   u00080 : constant Version_32 := 16#aa9baec2#;
   pragma Export (C, u00080, "ada__interruptsS");
   u00081 : constant Version_32 := 16#51078933#;
   pragma Export (C, u00081, "ada__task_identificationB");
   u00082 : constant Version_32 := 16#2232cf53#;
   pragma Export (C, u00082, "ada__task_identificationS");
   u00083 : constant Version_32 := 16#858ee8bc#;
   pragma Export (C, u00083, "system__tasking__restrictedS");
   u00084 : constant Version_32 := 16#3ef1c8c6#;
   pragma Export (C, u00084, "system__tasking__restricted__stagesB");
   u00085 : constant Version_32 := 16#57e13518#;
   pragma Export (C, u00085, "system__tasking__restricted__stagesS");
   u00086 : constant Version_32 := 16#0a6637d7#;
   pragma Export (C, u00086, "system__interruptsB");
   u00087 : constant Version_32 := 16#38e9971b#;
   pragma Export (C, u00087, "system__interruptsS");
   u00088 : constant Version_32 := 16#86882935#;
   pragma Export (C, u00088, "system__tasking__protected_objectsB");
   u00089 : constant Version_32 := 16#7670502d#;
   pragma Export (C, u00089, "system__tasking__protected_objectsS");
   u00090 : constant Version_32 := 16#1ab029f2#;
   pragma Export (C, u00090, "system__tasking__protected_objects__single_entryB");
   u00091 : constant Version_32 := 16#c7328e25#;
   pragma Export (C, u00091, "system__tasking__protected_objects__single_entryS");
   u00092 : constant Version_32 := 16#1ff5c9d4#;
   pragma Export (C, u00092, "system__tasking__protected_objects__multiprocessorsB");
   u00093 : constant Version_32 := 16#01c3fc38#;
   pragma Export (C, u00093, "system__tasking__protected_objects__multiprocessorsS");
   u00094 : constant Version_32 := 16#9741839e#;
   pragma Export (C, u00094, "ada__interrupts__namesS");
   u00095 : constant Version_32 := 16#b1ba2b9a#;
   pragma Export (C, u00095, "lis3dsh__spiB");
   u00096 : constant Version_32 := 16#e094444a#;
   pragma Export (C, u00096, "lis3dsh__spiS");
   u00097 : constant Version_32 := 16#9e4511cd#;
   pragma Export (C, u00097, "hal__gpioS");
   u00098 : constant Version_32 := 16#ac8c7965#;
   pragma Export (C, u00098, "stm32__deviceB");
   u00099 : constant Version_32 := 16#ffd4f194#;
   pragma Export (C, u00099, "stm32__deviceS");
   u00100 : constant Version_32 := 16#a7e86f3a#;
   pragma Export (C, u00100, "stm32_svdS");
   u00101 : constant Version_32 := 16#711e70f4#;
   pragma Export (C, u00101, "stm32_svd__rccS");
   u00102 : constant Version_32 := 16#cc8e2d5d#;
   pragma Export (C, u00102, "stm32__adcB");
   u00103 : constant Version_32 := 16#5f252dda#;
   pragma Export (C, u00103, "stm32__adcS");
   u00104 : constant Version_32 := 16#f9b22828#;
   pragma Export (C, u00104, "stm32_svd__adcS");
   u00105 : constant Version_32 := 16#2fc6827b#;
   pragma Export (C, u00105, "stm32__dacB");
   u00106 : constant Version_32 := 16#523edfc0#;
   pragma Export (C, u00106, "stm32__dacS");
   u00107 : constant Version_32 := 16#f795811c#;
   pragma Export (C, u00107, "stm32_svd__dacS");
   u00108 : constant Version_32 := 16#9ebf6e55#;
   pragma Export (C, u00108, "stm32__dmaB");
   u00109 : constant Version_32 := 16#22be680d#;
   pragma Export (C, u00109, "stm32__dmaS");
   u00110 : constant Version_32 := 16#095774a8#;
   pragma Export (C, u00110, "stm32_svd__dmaS");
   u00111 : constant Version_32 := 16#05513b91#;
   pragma Export (C, u00111, "stm32__gpioB");
   u00112 : constant Version_32 := 16#3383558f#;
   pragma Export (C, u00112, "stm32__gpioS");
   u00113 : constant Version_32 := 16#51901316#;
   pragma Export (C, u00113, "stm32__rccB");
   u00114 : constant Version_32 := 16#6a01afcc#;
   pragma Export (C, u00114, "stm32__rccS");
   u00115 : constant Version_32 := 16#29099406#;
   pragma Export (C, u00115, "stm32_svd__pwrS");
   u00116 : constant Version_32 := 16#aff1d329#;
   pragma Export (C, u00116, "stm32__syscfgB");
   u00117 : constant Version_32 := 16#26ad7892#;
   pragma Export (C, u00117, "stm32__syscfgS");
   u00118 : constant Version_32 := 16#8e7e9ca4#;
   pragma Export (C, u00118, "stm32__extiB");
   u00119 : constant Version_32 := 16#4e29fc64#;
   pragma Export (C, u00119, "stm32__extiS");
   u00120 : constant Version_32 := 16#ceb0aaa4#;
   pragma Export (C, u00120, "stm32_svd__extiS");
   u00121 : constant Version_32 := 16#3021b05a#;
   pragma Export (C, u00121, "stm32_svd__syscfgS");
   u00122 : constant Version_32 := 16#c3807a48#;
   pragma Export (C, u00122, "stm32_svd__gpioS");
   u00123 : constant Version_32 := 16#15ac9957#;
   pragma Export (C, u00123, "stm32__i2cB");
   u00124 : constant Version_32 := 16#e0ce2492#;
   pragma Export (C, u00124, "stm32__i2cS");
   u00125 : constant Version_32 := 16#3014bd41#;
   pragma Export (C, u00125, "stm32_svd__i2cS");
   u00126 : constant Version_32 := 16#ec78c2bf#;
   pragma Export (C, u00126, "system__img_unsB");
   u00127 : constant Version_32 := 16#a09f88a5#;
   pragma Export (C, u00127, "system__img_unsS");
   u00128 : constant Version_32 := 16#e43f6615#;
   pragma Export (C, u00128, "hal__i2cS");
   u00129 : constant Version_32 := 16#d07533c6#;
   pragma Export (C, u00129, "stm32__spiB");
   u00130 : constant Version_32 := 16#e72e7d46#;
   pragma Export (C, u00130, "stm32__spiS");
   u00131 : constant Version_32 := 16#e1b7426c#;
   pragma Export (C, u00131, "stm32_svd__spiS");
   u00132 : constant Version_32 := 16#bb6fd13a#;
   pragma Export (C, u00132, "stm32__timersB");
   u00133 : constant Version_32 := 16#ff6b7fef#;
   pragma Export (C, u00133, "stm32__timersS");
   u00134 : constant Version_32 := 16#2cba2d71#;
   pragma Export (C, u00134, "stm32__usartsB");
   u00135 : constant Version_32 := 16#816193fa#;
   pragma Export (C, u00135, "stm32__usartsS");
   u00136 : constant Version_32 := 16#408fbb67#;
   pragma Export (C, u00136, "stm32_svd__usartS");
   u00137 : constant Version_32 := 16#3c7ea57b#;
   pragma Export (C, u00137, "hal__uartS");
   u00138 : constant Version_32 := 16#6c2f8802#;
   pragma Export (C, u00138, "system__img_intB");
   u00139 : constant Version_32 := 16#09362813#;
   pragma Export (C, u00139, "system__img_intS");
   u00140 : constant Version_32 := 16#ffb23c0c#;
   pragma Export (C, u00140, "ledsB");
   u00141 : constant Version_32 := 16#669f6ac5#;
   pragma Export (C, u00141, "ledsS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  interfaces.bit_types%s
   --  system%s
   --  ada.exceptions%s
   --  ada.exceptions%b
   --  interfaces.stm32%s
   --  interfaces.stm32.pwr%s
   --  system.bb%s
   --  system.bb.board_parameters%s
   --  system.bb.mcu_parameters%s
   --  system.bb.mcu_parameters%b
   --  system.bb.protection%s
   --  system.img_int%s
   --  system.img_int%b
   --  system.machine_code%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  ada.tags%s
   --  system.task_info%s
   --  system.task_info%b
   --  system.unsigned_types%s
   --  interfaces.stm32.rcc%s
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.stm32%s
   --  system.bb.parameters%s
   --  system.stm32%b
   --  system.bb.cpu_primitives%s
   --  system.multiprocessors%s
   --  system.multiprocessors%b
   --  system.bb.cpu_primitives.multiprocessors%s
   --  system.bb.cpu_primitives.multiprocessors%b
   --  system.bb.interrupts%s
   --  system.bb.board_support%s
   --  system.bb.board_support%b
   --  system.bb.time%s
   --  system.bb.threads%s
   --  system.bb.threads.queues%s
   --  system.bb.threads.queues%b
   --  system.bb.threads%b
   --  system.bb.interrupts%b
   --  system.bb.cpu_primitives%b
   --  system.bb.protection%b
   --  system.bb.timing_events%s
   --  system.bb.timing_events%b
   --  system.multiprocessors.spin_locks%s
   --  system.multiprocessors.spin_locks%b
   --  system.multiprocessors.fair_locks%s
   --  system.bb.time%b
   --  system.os_interface%s
   --  system.multiprocessors.fair_locks%b
   --  system.task_primitives%s
   --  system.tasking%s
   --  ada.task_identification%s
   --  system.task_primitives.operations%s
   --  system.tasking.debug%s
   --  system.tasking.debug%b
   --  system.task_primitives.operations%b
   --  system.assertions%s
   --  system.assertions%b
   --  system.secondary_stack%s
   --  system.tasking%b
   --  ada.tags%b
   --  system.secondary_stack%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  ada.real_time.delays%s
   --  ada.real_time.delays%b
   --  system.tasking.protected_objects%s
   --  system.tasking.protected_objects%b
   --  system.tasking.protected_objects.multiprocessors%s
   --  system.tasking.protected_objects.multiprocessors%b
   --  system.tasking.protected_objects.single_entry%s
   --  system.tasking.protected_objects.single_entry%b
   --  system.tasking.restricted%s
   --  system.tasking.restricted.stages%s
   --  system.tasking.restricted.stages%b
   --  ada.task_identification%b
   --  system.interrupts%s
   --  system.interrupts%b
   --  ada.interrupts%s
   --  ada.interrupts%b
   --  ada.interrupts.names%s
   --  hal%s
   --  stm32%s
   --  stm32_svd%s
   --  stm32_svd.adc%s
   --  stm32_svd.dac%s
   --  stm32_svd.dma%s
   --  stm32_svd.exti%s
   --  stm32_svd.gpio%s
   --  stm32_svd.i2c%s
   --  stm32_svd.pwr%s
   --  stm32_svd.rcc%s
   --  stm32_svd.spi%s
   --  stm32_svd.syscfg%s
   --  stm32_svd.usart%s
   --  hal.gpio%s
   --  hal.i2c%s
   --  hal.spi%s
   --  hal.uart%s
   --  last_chance_handler%s
   --  leds%s
   --  lis3dsh%s
   --  lis3dsh%b
   --  lis3dsh.spi%s
   --  lis3dsh.spi%b
   --  stm32.adc%s
   --  stm32.adc%b
   --  stm32.dac%s
   --  stm32.dac%b
   --  stm32.dma%s
   --  stm32.dma%b
   --  stm32.exti%s
   --  stm32.exti%b
   --  stm32.gpio%s
   --  stm32.i2c%s
   --  stm32.rcc%s
   --  stm32.spi%s
   --  stm32.spi%b
   --  stm32.syscfg%s
   --  stm32.gpio%b
   --  stm32.timers%s
   --  stm32.timers%b
   --  stm32.usarts%s
   --  serial%s
   --  stm32.device%s
   --  stm32.device%b
   --  stm32.usarts%b
   --  stm32.syscfg%b
   --  stm32.rcc%b
   --  stm32.i2c%b
   --  main%b
   --  stm32.board%s
   --  stm32.board%b
   --  serial%b
   --  leds%b
   --  last_chance_handler%b
   --  END ELABORATION ORDER


end ada_main;
