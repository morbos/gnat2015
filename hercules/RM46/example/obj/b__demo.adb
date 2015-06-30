pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__demo.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__demo.adb");
pragma Suppress (Overflow_Check);

package body ada_main is
   pragma Warnings (Off);

   E087 : Short_Integer; pragma Import (Ada, E087, "ada__tags_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "system__bb__timing_events_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "system__soft_links_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__text_io_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "system__exception_table_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "system__tasking__restricted__stages_E");
   E014 : Short_Integer; pragma Import (Ada, E014, "ada__real_time_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "driver_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "init_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "last_chance_handler_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := 0;
      Time_Slice_Value := 0;
      WC_Encoding := 'b';
      Locking_Policy := 'C';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := 'F';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 1;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      System.Bb.Timing_Events'Elab_Spec;
      E101 := E101 + 1;
      System.Soft_Links'Elab_Spec;
      E047 := E047 + 1;
      Ada.Text_Io'Elab_Body;
      E006 := E006 + 1;
      System.Exception_Table'Elab_Body;
      E045 := E045 + 1;
      Ada.Tags'Elab_Body;
      E087 := E087 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E116 := E116 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E014 := E014 + 1;
      Driver'Elab_Spec;
      Driver'Elab_Body;
      E012 := E012 + 1;
      E119 := E119 + 1;
      E129 := E129 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_demo");

   procedure main is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
   end;

--  BEGIN Object file/option list
   --   /rnasbkup/gnat2015/hercules/RM46/example/obj/sys-mux.o
   --   /rnasbkup/gnat2015/hercules/RM46/example/obj/sys-periph.o
   --   /rnasbkup/gnat2015/hercules/RM46/example/obj/sys.o
   --   /rnasbkup/gnat2015/hercules/RM46/example/obj/sys-pll.o
   --   /rnasbkup/gnat2015/hercules/RM46/example/obj/gioports.o
   --   /rnasbkup/gnat2015/hercules/RM46/example/obj/driver.o
   --   /rnasbkup/gnat2015/hercules/RM46/example/obj/init.o
   --   /rnasbkup/gnat2015/hercules/RM46/example/obj/last_chance_handler.o
   --   /rnasbkup/gnat2015/hercules/RM46/example/obj/demo.o
   --   -L/rnasbkup/gnat2015/hercules/RM46/example/obj/
   --   -L/rnasbkup/gnat2015/hercules/RM46/example/obj/
   --   -L/bkup/ada/gnat2015/ravenscar-full-rm46/adalib/
--  END Object file/option list   

end ada_main;
