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

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   procedure main;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#1b52aab4#;
   pragma Export (C, u00001, "demoB");
   u00002 : constant Version_32 := 16#cf9eba42#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#79fde7e4#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#d3a2eabd#;
   pragma Export (C, u00005, "ada__text_ioB");
   u00006 : constant Version_32 := 16#c034cb2a#;
   pragma Export (C, u00006, "ada__text_ioS");
   u00007 : constant Version_32 := 16#7a1c5ef5#;
   pragma Export (C, u00007, "systemS");
   u00008 : constant Version_32 := 16#4e0af81e#;
   pragma Export (C, u00008, "system__text_ioB");
   u00009 : constant Version_32 := 16#0f2e0e04#;
   pragma Export (C, u00009, "system__text_ioS");
   u00010 : constant Version_32 := 16#6033a23f#;
   pragma Export (C, u00010, "interfacesS");
   u00011 : constant Version_32 := 16#59f2ba18#;
   pragma Export (C, u00011, "driverB");
   u00012 : constant Version_32 := 16#830a80ea#;
   pragma Export (C, u00012, "driverS");
   u00013 : constant Version_32 := 16#86ccdb37#;
   pragma Export (C, u00013, "ada__real_timeB");
   u00014 : constant Version_32 := 16#cf4a25c2#;
   pragma Export (C, u00014, "ada__real_timeS");
   u00015 : constant Version_32 := 16#d865cf4f#;
   pragma Export (C, u00015, "system__task_primitivesS");
   u00016 : constant Version_32 := 16#5b9ea7cb#;
   pragma Export (C, u00016, "system__os_interfaceS");
   u00017 : constant Version_32 := 16#f22b3623#;
   pragma Export (C, u00017, "system__bbS");
   u00018 : constant Version_32 := 16#d930e645#;
   pragma Export (C, u00018, "system__bb__board_supportB");
   u00019 : constant Version_32 := 16#c731b4f5#;
   pragma Export (C, u00019, "system__bb__board_supportS");
   u00020 : constant Version_32 := 16#41d04c37#;
   pragma Export (C, u00020, "system__bb__parametersS");
   u00021 : constant Version_32 := 16#05469f0f#;
   pragma Export (C, u00021, "system__rm57S");
   u00022 : constant Version_32 := 16#39a03df9#;
   pragma Export (C, u00022, "system__storage_elementsB");
   u00023 : constant Version_32 := 16#57df14f1#;
   pragma Export (C, u00023, "system__storage_elementsS");
   u00024 : constant Version_32 := 16#e744fa35#;
   pragma Export (C, u00024, "system__unsigned_typesS");
   u00025 : constant Version_32 := 16#552f1d8f#;
   pragma Export (C, u00025, "system__bb__cpu_primitivesB");
   u00026 : constant Version_32 := 16#0cee8884#;
   pragma Export (C, u00026, "system__bb__cpu_primitivesS");
   u00027 : constant Version_32 := 16#46b79a2a#;
   pragma Export (C, u00027, "ada__exceptionsB");
   u00028 : constant Version_32 := 16#241f88bc#;
   pragma Export (C, u00028, "ada__exceptionsS");
   u00029 : constant Version_32 := 16#7cd18938#;
   pragma Export (C, u00029, "ada__exceptions__last_chance_handlerB");
   u00030 : constant Version_32 := 16#3aac8c92#;
   pragma Export (C, u00030, "ada__exceptions__last_chance_handlerS");
   u00031 : constant Version_32 := 16#fd2ad2f1#;
   pragma Export (C, u00031, "gnatS");
   u00032 : constant Version_32 := 16#a1bbde3d#;
   pragma Export (C, u00032, "gnat__debug_utilitiesB");
   u00033 : constant Version_32 := 16#84272bbf#;
   pragma Export (C, u00033, "gnat__debug_utilitiesS");
   u00034 : constant Version_32 := 16#a56b3ef3#;
   pragma Export (C, u00034, "system__secondary_stackB");
   u00035 : constant Version_32 := 16#f30f7eb3#;
   pragma Export (C, u00035, "system__secondary_stackS");
   u00036 : constant Version_32 := 16#37ec8d54#;
   pragma Export (C, u00036, "system__ioB");
   u00037 : constant Version_32 := 16#e45ea9ba#;
   pragma Export (C, u00037, "system__ioS");
   u00038 : constant Version_32 := 16#570325c8#;
   pragma Export (C, u00038, "system__img_intB");
   u00039 : constant Version_32 := 16#78c7be37#;
   pragma Export (C, u00039, "system__img_intS");
   u00040 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00040, "ada__exceptions__tracebackB");
   u00041 : constant Version_32 := 16#5b6d87c9#;
   pragma Export (C, u00041, "ada__exceptions__tracebackS");
   u00042 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00042, "system__traceback_entriesB");
   u00043 : constant Version_32 := 16#7a47a885#;
   pragma Export (C, u00043, "system__traceback_entriesS");
   u00044 : constant Version_32 := 16#0d526ee4#;
   pragma Export (C, u00044, "system__exception_tableB");
   u00045 : constant Version_32 := 16#d40538e0#;
   pragma Export (C, u00045, "system__exception_tableS");
   u00046 : constant Version_32 := 16#9d5b8a83#;
   pragma Export (C, u00046, "system__soft_linksB");
   u00047 : constant Version_32 := 16#b65b58eb#;
   pragma Export (C, u00047, "system__soft_linksS");
   u00048 : constant Version_32 := 16#a12451c2#;
   pragma Export (C, u00048, "system__task_primitives__operationsB");
   u00049 : constant Version_32 := 16#3edae474#;
   pragma Export (C, u00049, "system__task_primitives__operationsS");
   u00050 : constant Version_32 := 16#d8bdb4ae#;
   pragma Export (C, u00050, "system__taskingB");
   u00051 : constant Version_32 := 16#fc400485#;
   pragma Export (C, u00051, "system__taskingS");
   u00052 : constant Version_32 := 16#84f3a776#;
   pragma Export (C, u00052, "system__multiprocessorsB");
   u00053 : constant Version_32 := 16#40c57421#;
   pragma Export (C, u00053, "system__multiprocessorsS");
   u00054 : constant Version_32 := 16#8d26105b#;
   pragma Export (C, u00054, "interfaces__cS");
   u00055 : constant Version_32 := 16#c0ab394a#;
   pragma Export (C, u00055, "system__parametersB");
   u00056 : constant Version_32 := 16#b3e20daa#;
   pragma Export (C, u00056, "system__parametersS");
   u00057 : constant Version_32 := 16#e0fce7f8#;
   pragma Export (C, u00057, "system__task_infoB");
   u00058 : constant Version_32 := 16#fa06e3f4#;
   pragma Export (C, u00058, "system__task_infoS");
   u00059 : constant Version_32 := 16#0f8eba36#;
   pragma Export (C, u00059, "system__tasking__debugB");
   u00060 : constant Version_32 := 16#8e39484d#;
   pragma Export (C, u00060, "system__tasking__debugS");
   u00061 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00061, "system__exceptionsB");
   u00062 : constant Version_32 := 16#127f3303#;
   pragma Export (C, u00062, "system__exceptionsS");
   u00063 : constant Version_32 := 16#70453398#;
   pragma Export (C, u00063, "system__exceptions__machineS");
   u00064 : constant Version_32 := 16#b895431d#;
   pragma Export (C, u00064, "system__exceptions_debugB");
   u00065 : constant Version_32 := 16#c9fe474b#;
   pragma Export (C, u00065, "system__exceptions_debugS");
   u00066 : constant Version_32 := 16#fd945b97#;
   pragma Export (C, u00066, "system__tracebackB");
   u00067 : constant Version_32 := 16#d82b7181#;
   pragma Export (C, u00067, "system__tracebackS");
   u00068 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00068, "system__wch_conB");
   u00069 : constant Version_32 := 16#61617c27#;
   pragma Export (C, u00069, "system__wch_conS");
   u00070 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00070, "system__wch_stwB");
   u00071 : constant Version_32 := 16#4c705026#;
   pragma Export (C, u00071, "system__wch_stwS");
   u00072 : constant Version_32 := 16#92b797cb#;
   pragma Export (C, u00072, "system__wch_cnvB");
   u00073 : constant Version_32 := 16#6ed6c6d4#;
   pragma Export (C, u00073, "system__wch_cnvS");
   u00074 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00074, "system__wch_jisB");
   u00075 : constant Version_32 := 16#eea6dff5#;
   pragma Export (C, u00075, "system__wch_jisS");
   u00076 : constant Version_32 := 16#f22a3c08#;
   pragma Export (C, u00076, "system__bb__cpu_primitives__multiprocessorsB");
   u00077 : constant Version_32 := 16#71f00eda#;
   pragma Export (C, u00077, "system__bb__cpu_primitives__multiprocessorsS");
   u00078 : constant Version_32 := 16#80e7b3b8#;
   pragma Export (C, u00078, "system__bb__protectionB");
   u00079 : constant Version_32 := 16#7cbd1653#;
   pragma Export (C, u00079, "system__bb__protectionS");
   u00080 : constant Version_32 := 16#91fc7a99#;
   pragma Export (C, u00080, "system__bb__threadsB");
   u00081 : constant Version_32 := 16#f5ae0e88#;
   pragma Export (C, u00081, "system__bb__threadsS");
   u00082 : constant Version_32 := 16#89e68bc8#;
   pragma Export (C, u00082, "system__bb__threads__queuesB");
   u00083 : constant Version_32 := 16#d0270049#;
   pragma Export (C, u00083, "system__bb__threads__queuesS");
   u00084 : constant Version_32 := 16#db6dbd7f#;
   pragma Export (C, u00084, "system__bb__timeB");
   u00085 : constant Version_32 := 16#54dfd416#;
   pragma Export (C, u00085, "system__bb__timeS");
   u00086 : constant Version_32 := 16#12c8cd7d#;
   pragma Export (C, u00086, "ada__tagsB");
   u00087 : constant Version_32 := 16#ce72c228#;
   pragma Export (C, u00087, "ada__tagsS");
   u00088 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00088, "system__htableB");
   u00089 : constant Version_32 := 16#fedeed1f#;
   pragma Export (C, u00089, "system__htableS");
   u00090 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00090, "system__string_hashB");
   u00091 : constant Version_32 := 16#5c808661#;
   pragma Export (C, u00091, "system__string_hashS");
   u00092 : constant Version_32 := 16#b44f9ae7#;
   pragma Export (C, u00092, "system__val_unsB");
   u00093 : constant Version_32 := 16#f7ec170e#;
   pragma Export (C, u00093, "system__val_unsS");
   u00094 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00094, "system__val_utilB");
   u00095 : constant Version_32 := 16#d6bce80b#;
   pragma Export (C, u00095, "system__val_utilS");
   u00096 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00096, "system__case_utilB");
   u00097 : constant Version_32 := 16#5e153722#;
   pragma Export (C, u00097, "system__case_utilS");
   u00098 : constant Version_32 := 16#a7e82125#;
   pragma Export (C, u00098, "system__bb__interruptsB");
   u00099 : constant Version_32 := 16#8fb1fe21#;
   pragma Export (C, u00099, "system__bb__interruptsS");
   u00100 : constant Version_32 := 16#308b3d8b#;
   pragma Export (C, u00100, "system__bb__timing_eventsB");
   u00101 : constant Version_32 := 16#4015fc61#;
   pragma Export (C, u00101, "system__bb__timing_eventsS");
   u00102 : constant Version_32 := 16#ec2092fc#;
   pragma Export (C, u00102, "system__multiprocessors__fair_locksB");
   u00103 : constant Version_32 := 16#a70e2885#;
   pragma Export (C, u00103, "system__multiprocessors__fair_locksS");
   u00104 : constant Version_32 := 16#9621e181#;
   pragma Export (C, u00104, "system__multiprocessors__spin_locksB");
   u00105 : constant Version_32 := 16#9ac42bf1#;
   pragma Export (C, u00105, "system__multiprocessors__spin_locksS");
   u00106 : constant Version_32 := 16#75a7253b#;
   pragma Export (C, u00106, "system__machine_codeS");
   u00107 : constant Version_32 := 16#13da4b8a#;
   pragma Export (C, u00107, "ada__real_time__delaysB");
   u00108 : constant Version_32 := 16#6fcba83e#;
   pragma Export (C, u00108, "ada__real_time__delaysS");
   u00109 : constant Version_32 := 16#fb1ccc40#;
   pragma Export (C, u00109, "ada__synchronous_task_controlB");
   u00110 : constant Version_32 := 16#f1968e5f#;
   pragma Export (C, u00110, "ada__synchronous_task_controlS");
   u00111 : constant Version_32 := 16#c1e742f9#;
   pragma Export (C, u00111, "gioportsB");
   u00112 : constant Version_32 := 16#a95b5f68#;
   pragma Export (C, u00112, "gioportsS");
   u00113 : constant Version_32 := 16#38c683e4#;
   pragma Export (C, u00113, "accessorB");
   u00114 : constant Version_32 := 16#5634fcc7#;
   pragma Export (C, u00114, "accessorS");
   u00115 : constant Version_32 := 16#4767effe#;
   pragma Export (C, u00115, "system__tasking__restricted__stagesB");
   u00116 : constant Version_32 := 16#57e13518#;
   pragma Export (C, u00116, "system__tasking__restricted__stagesS");
   u00117 : constant Version_32 := 16#83680a71#;
   pragma Export (C, u00117, "system__tasking__restrictedS");
   u00118 : constant Version_32 := 16#9c512d98#;
   pragma Export (C, u00118, "initB");
   u00119 : constant Version_32 := 16#188324c4#;
   pragma Export (C, u00119, "initS");
   u00120 : constant Version_32 := 16#c05d8c1c#;
   pragma Export (C, u00120, "sysB");
   u00121 : constant Version_32 := 16#07cdead7#;
   pragma Export (C, u00121, "sysS");
   u00122 : constant Version_32 := 16#4fba5718#;
   pragma Export (C, u00122, "sys__muxB");
   u00123 : constant Version_32 := 16#a58a1055#;
   pragma Export (C, u00123, "sys__muxS");
   u00124 : constant Version_32 := 16#fc5e76fa#;
   pragma Export (C, u00124, "sys__periphB");
   u00125 : constant Version_32 := 16#a195e8cd#;
   pragma Export (C, u00125, "sys__periphS");
   u00126 : constant Version_32 := 16#69287125#;
   pragma Export (C, u00126, "sys__flashB");
   u00127 : constant Version_32 := 16#cfb7fb0f#;
   pragma Export (C, u00127, "sys__flashS");
   u00128 : constant Version_32 := 16#2c265f8f#;
   pragma Export (C, u00128, "sys__pllB");
   u00129 : constant Version_32 := 16#ec5b707b#;
   pragma Export (C, u00129, "sys__pllS");
   u00130 : constant Version_32 := 16#e3b58255#;
   pragma Export (C, u00130, "sys__vimB");
   u00131 : constant Version_32 := 16#5bf32048#;
   pragma Export (C, u00131, "sys__vimS");
   u00132 : constant Version_32 := 16#b8e4440a#;
   pragma Export (C, u00132, "last_chance_handlerB");
   u00133 : constant Version_32 := 16#a04daef1#;
   pragma Export (C, u00133, "last_chance_handlerS");
   u00134 : constant Version_32 := 16#4aa4186c#;
   pragma Export (C, u00134, "system__memoryB");
   u00135 : constant Version_32 := 16#236138c1#;
   pragma Export (C, u00135, "system__memoryS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  gnat%s
   --  interfaces%s
   --  interfaces.c%s
   --  system%s
   --  gnat.debug_utilities%s
   --  system.bb%s
   --  system.bb.parameters%s
   --  system.bb.cpu_primitives%s
   --  system.bb.protection%s
   --  system.case_util%s
   --  system.case_util%b
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.htable%s
   --  system.img_int%s
   --  system.img_int%b
   --  system.io%s
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
   --  system.standard_library%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.bb.threads%b
   --  system.bb.interrupts%b
   --  ada.tags%s
   --  system.bb.timing_events%s
   --  system.bb.timing_events%b
   --  system.bb.time%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_primitives%s
   --  system.text_io%s
   --  system.text_io%b
   --  system.io%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  system.bb.cpu_primitives%b
   --  system.exceptions.machine%s
   --  system.soft_links%s
   --  system.tasking%s
   --  ada.synchronous_task_control%s
   --  system.task_primitives.operations%s
   --  ada.synchronous_task_control%b
   --  system.soft_links%b
   --  system.tasking.debug%s
   --  system.tasking.debug%b
   --  system.task_primitives.operations%b
   --  system.unsigned_types%s
   --  system.rm57%s
   --  system.bb.board_support%b
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.traceback%s
   --  ada.text_io%s
   --  ada.text_io%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.secondary_stack%s
   --  system.tasking%b
   --  ada.tags%b
   --  gnat.debug_utilities%b
   --  system.secondary_stack%b
   --  ada.exceptions.traceback%b
   --  ada.exceptions.last_chance_handler%b
   --  system.tasking.restricted%s
   --  system.tasking.restricted.stages%s
   --  system.tasking.restricted.stages%b
   --  system.traceback%s
   --  ada.exceptions%b
   --  system.traceback%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  ada.real_time.delays%s
   --  ada.real_time.delays%b
   --  accessor%s
   --  accessor%b
   --  sys%s
   --  sys.flash%s
   --  sys.flash%b
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
   --  last_chance_handler%s
   --  last_chance_handler%b
   --  demo%b
   --  sys.vim%s
   --  sys.vim%b
   --  init%b
   --  END ELABORATION ORDER


end ada_main;
