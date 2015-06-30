pragma Ada_95;
pragma Restrictions (No_Exception_Propagation);
with System;
package ada_main is
   pragma Warnings (Off);


   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2015 (20150428-49)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_demo" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure main;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#31850e29#;
   pragma Export (C, u00001, "demoB");
   u00002 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00002, "adaS");
   u00003 : constant Version_32 := 16#d3a2eabd#;
   pragma Export (C, u00003, "ada__text_ioB");
   u00004 : constant Version_32 := 16#c034cb2a#;
   pragma Export (C, u00004, "ada__text_ioS");
   u00005 : constant Version_32 := 16#aa6d6fbd#;
   pragma Export (C, u00005, "systemS");
   u00006 : constant Version_32 := 16#bb62f616#;
   pragma Export (C, u00006, "system__text_ioB");
   u00007 : constant Version_32 := 16#df5f3f4c#;
   pragma Export (C, u00007, "system__text_ioS");
   u00008 : constant Version_32 := 16#6033a23f#;
   pragma Export (C, u00008, "interfacesS");
   u00009 : constant Version_32 := 16#2b577a23#;
   pragma Export (C, u00009, "driverB");
   u00010 : constant Version_32 := 16#537bb1a2#;
   pragma Export (C, u00010, "driverS");
   u00011 : constant Version_32 := 16#48fa1cf9#;
   pragma Export (C, u00011, "ada__real_timeB");
   u00012 : constant Version_32 := 16#cf4a25c2#;
   pragma Export (C, u00012, "ada__real_timeS");
   u00013 : constant Version_32 := 16#0814fe07#;
   pragma Export (C, u00013, "system__task_primitivesS");
   u00014 : constant Version_32 := 16#8bef9683#;
   pragma Export (C, u00014, "system__os_interfaceS");
   u00015 : constant Version_32 := 16#225a076b#;
   pragma Export (C, u00015, "system__bbS");
   u00016 : constant Version_32 := 16#88beaa26#;
   pragma Export (C, u00016, "system__bb__board_supportB");
   u00017 : constant Version_32 := 16#c731b4f5#;
   pragma Export (C, u00017, "system__bb__board_supportS");
   u00018 : constant Version_32 := 16#f99aa6e6#;
   pragma Export (C, u00018, "system__bb__parametersS");
   u00019 : constant Version_32 := 16#06b05c14#;
   pragma Export (C, u00019, "system__rm46S");
   u00020 : constant Version_32 := 16#39a03df9#;
   pragma Export (C, u00020, "system__storage_elementsB");
   u00021 : constant Version_32 := 16#87ae25b9#;
   pragma Export (C, u00021, "system__storage_elementsS");
   u00022 : constant Version_32 := 16#3735cb7d#;
   pragma Export (C, u00022, "system__unsigned_typesS");
   u00023 : constant Version_32 := 16#335d5416#;
   pragma Export (C, u00023, "system__bb__cpu_primitivesB");
   u00024 : constant Version_32 := 16#64d5531d#;
   pragma Export (C, u00024, "system__bb__cpu_primitivesS");
   u00025 : constant Version_32 := 16#5e68f5cc#;
   pragma Export (C, u00025, "ada__exceptionsB");
   u00026 : constant Version_32 := 16#ceceee8a#;
   pragma Export (C, u00026, "ada__exceptionsS");
   u00027 : constant Version_32 := 16#f22a3c08#;
   pragma Export (C, u00027, "system__bb__cpu_primitives__multiprocessorsB");
   u00028 : constant Version_32 := 16#71f00eda#;
   pragma Export (C, u00028, "system__bb__cpu_primitives__multiprocessorsS");
   u00029 : constant Version_32 := 16#84f3a776#;
   pragma Export (C, u00029, "system__multiprocessorsB");
   u00030 : constant Version_32 := 16#28feafb8#;
   pragma Export (C, u00030, "system__multiprocessorsS");
   u00031 : constant Version_32 := 16#8d26105b#;
   pragma Export (C, u00031, "interfaces__cS");
   u00032 : constant Version_32 := 16#38ad5969#;
   pragma Export (C, u00032, "system__bb__protectionB");
   u00033 : constant Version_32 := 16#7cbd1653#;
   pragma Export (C, u00033, "system__bb__protectionS");
   u00034 : constant Version_32 := 16#29b69048#;
   pragma Export (C, u00034, "system__bb__threadsB");
   u00035 : constant Version_32 := 16#25df3fc0#;
   pragma Export (C, u00035, "system__bb__threadsS");
   u00036 : constant Version_32 := 16#89e68bc8#;
   pragma Export (C, u00036, "system__bb__threads__queuesB");
   u00037 : constant Version_32 := 16#d0270049#;
   pragma Export (C, u00037, "system__bb__threads__queuesS");
   u00038 : constant Version_32 := 16#632757ae#;
   pragma Export (C, u00038, "system__bb__timeB");
   u00039 : constant Version_32 := 16#54dfd416#;
   pragma Export (C, u00039, "system__bb__timeS");
   u00040 : constant Version_32 := 16#b5993228#;
   pragma Export (C, u00040, "ada__tagsB");
   u00041 : constant Version_32 := 16#7410f4f0#;
   pragma Export (C, u00041, "ada__tagsS");
   u00042 : constant Version_32 := 16#a56b3ef3#;
   pragma Export (C, u00042, "system__secondary_stackB");
   u00043 : constant Version_32 := 16#237e4ffb#;
   pragma Export (C, u00043, "system__secondary_stackS");
   u00044 : constant Version_32 := 16#a7e82125#;
   pragma Export (C, u00044, "system__bb__interruptsB");
   u00045 : constant Version_32 := 16#e78a25b8#;
   pragma Export (C, u00045, "system__bb__interruptsS");
   u00046 : constant Version_32 := 16#88c1d75a#;
   pragma Export (C, u00046, "system__bb__timing_eventsB");
   u00047 : constant Version_32 := 16#4015fc61#;
   pragma Export (C, u00047, "system__bb__timing_eventsS");
   u00048 : constant Version_32 := 16#ec2092fc#;
   pragma Export (C, u00048, "system__multiprocessors__fair_locksB");
   u00049 : constant Version_32 := 16#a70e2885#;
   pragma Export (C, u00049, "system__multiprocessors__fair_locksS");
   u00050 : constant Version_32 := 16#9621e181#;
   pragma Export (C, u00050, "system__multiprocessors__spin_locksB");
   u00051 : constant Version_32 := 16#9ac42bf1#;
   pragma Export (C, u00051, "system__multiprocessors__spin_locksS");
   u00052 : constant Version_32 := 16#c0ab394a#;
   pragma Export (C, u00052, "system__parametersB");
   u00053 : constant Version_32 := 16#63933ce2#;
   pragma Export (C, u00053, "system__parametersS");
   u00054 : constant Version_32 := 16#a5d61473#;
   pragma Export (C, u00054, "system__machine_codeS");
   u00055 : constant Version_32 := 16#a12451c2#;
   pragma Export (C, u00055, "system__task_primitives__operationsB");
   u00056 : constant Version_32 := 16#f0ec23ba#;
   pragma Export (C, u00056, "system__task_primitives__operationsS");
   u00057 : constant Version_32 := 16#168b7360#;
   pragma Export (C, u00057, "system__taskingB");
   u00058 : constant Version_32 := 16#b057396a#;
   pragma Export (C, u00058, "system__taskingS");
   u00059 : constant Version_32 := 16#e0fce7f8#;
   pragma Export (C, u00059, "system__task_infoB");
   u00060 : constant Version_32 := 16#2a77d2bc#;
   pragma Export (C, u00060, "system__task_infoS");
   u00061 : constant Version_32 := 16#0f8eba36#;
   pragma Export (C, u00061, "system__tasking__debugB");
   u00062 : constant Version_32 := 16#8e39484d#;
   pragma Export (C, u00062, "system__tasking__debugS");
   u00063 : constant Version_32 := 16#13da4b8a#;
   pragma Export (C, u00063, "ada__real_time__delaysB");
   u00064 : constant Version_32 := 16#6fcba83e#;
   pragma Export (C, u00064, "ada__real_time__delaysS");
   u00065 : constant Version_32 := 16#fb1ccc40#;
   pragma Export (C, u00065, "ada__synchronous_task_controlB");
   u00066 : constant Version_32 := 16#3fa04991#;
   pragma Export (C, u00066, "ada__synchronous_task_controlS");
   u00067 : constant Version_32 := 16#839cb425#;
   pragma Export (C, u00067, "gioportsB");
   u00068 : constant Version_32 := 16#2c377f10#;
   pragma Export (C, u00068, "gioportsS");
   u00069 : constant Version_32 := 16#5e17fd6f#;
   pragma Export (C, u00069, "accessorB");
   u00070 : constant Version_32 := 16#e362701f#;
   pragma Export (C, u00070, "accessorS");
   u00071 : constant Version_32 := 16#4767effe#;
   pragma Export (C, u00071, "system__tasking__restricted__stagesB");
   u00072 : constant Version_32 := 16#57e13518#;
   pragma Export (C, u00072, "system__tasking__restricted__stagesS");
   u00073 : constant Version_32 := 16#4d5ecdbf#;
   pragma Export (C, u00073, "system__tasking__restrictedS");
   u00074 : constant Version_32 := 16#1fdce7e9#;
   pragma Export (C, u00074, "initB");
   u00075 : constant Version_32 := 16#e225b111#;
   pragma Export (C, u00075, "initS");
   u00076 : constant Version_32 := 16#ec9f6a70#;
   pragma Export (C, u00076, "sysB");
   u00077 : constant Version_32 := 16#07cdead7#;
   pragma Export (C, u00077, "sysS");
   u00078 : constant Version_32 := 16#3b74241d#;
   pragma Export (C, u00078, "sys__muxB");
   u00079 : constant Version_32 := 16#02c39103#;
   pragma Export (C, u00079, "sys__muxS");
   u00080 : constant Version_32 := 16#ca409a85#;
   pragma Export (C, u00080, "sys__periphB");
   u00081 : constant Version_32 := 16#4ccff17c#;
   pragma Export (C, u00081, "sys__periphS");
   u00082 : constant Version_32 := 16#2ad78674#;
   pragma Export (C, u00082, "sys__pllB");
   u00083 : constant Version_32 := 16#526e2e8f#;
   pragma Export (C, u00083, "sys__pllS");
   u00084 : constant Version_32 := 16#b8e4440a#;
   pragma Export (C, u00084, "last_chance_handlerB");
   u00085 : constant Version_32 := 16#703c9fb9#;
   pragma Export (C, u00085, "last_chance_handlerS");
   u00086 : constant Version_32 := 16#570325c8#;
   pragma Export (C, u00086, "system__img_intB");
   u00087 : constant Version_32 := 16#a8b68f7f#;
   pragma Export (C, u00087, "system__img_intS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  interfaces.c%s
   --  system%s
   --  ada.exceptions%s
   --  ada.exceptions%b
   --  system.bb%s
   --  system.bb.parameters%s
   --  system.bb.cpu_primitives%s
   --  system.bb.protection%s
   --  system.img_int%s
   --  system.img_int%b
   --  system.machine_code%s
   --  system.multiprocessors%s
   --  system.multiprocessors%b
   --  system.bb.cpu_primitives.multiprocessors%s
   --  system.bb.cpu_primitives.multiprocessors%b
   --  system.bb.interrupts%s
   --  system.bb.board_support%s
   --  system.bb.time%s
   --  system.multiprocessors.spin_locks%s
   --  system.multiprocessors.spin_locks%b
   --  system.multiprocessors.fair_locks%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.bb.threads%s
   --  system.bb.threads.queues%s
   --  system.bb.threads.queues%b
   --  system.bb.protection%b
   --  system.os_interface%s
   --  system.multiprocessors.fair_locks%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.bb.threads%b
   --  system.bb.interrupts%b
   --  system.bb.cpu_primitives%b
   --  ada.tags%s
   --  system.bb.timing_events%s
   --  system.bb.timing_events%b
   --  system.bb.time%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_primitives%s
   --  system.tasking%s
   --  ada.synchronous_task_control%s
   --  system.task_primitives.operations%s
   --  ada.synchronous_task_control%b
   --  system.tasking.debug%s
   --  system.tasking.debug%b
   --  system.task_primitives.operations%b
   --  system.text_io%s
   --  system.text_io%b
   --  system.unsigned_types%s
   --  system.rm46%s
   --  system.bb.board_support%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  system.secondary_stack%s
   --  system.tasking%b
   --  ada.tags%b
   --  system.secondary_stack%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  ada.real_time.delays%s
   --  ada.real_time.delays%b
   --  system.tasking.restricted%s
   --  system.tasking.restricted.stages%s
   --  system.tasking.restricted.stages%b
   --  accessor%s
   --  accessor%b
   --  sys%s
   --  sys.mux%s
   --  sys.mux%b
   --  sys.periph%s
   --  sys.periph%b
   --  sys%b
   --  sys.pll%s
   --  sys.pll%b
   --  driver%s
   --  gioports%s
   --  gioports%b
   --  driver%b
   --  init%s
   --  init%b
   --  last_chance_handler%s
   --  last_chance_handler%b
   --  demo%b
   --  END ELABORATION ORDER


end ada_main;
