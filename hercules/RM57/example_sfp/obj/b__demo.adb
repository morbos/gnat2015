pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__demo.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__demo.adb");
pragma Suppress (Overflow_Check);

package body ada_main is
   pragma Warnings (Off);

   E04 : Short_Integer; pragma Import (Ada, E04, "ada__text_io_E");
   E12 : Short_Integer; pragma Import (Ada, E12, "ada__real_time_E");
   E72 : Short_Integer; pragma Import (Ada, E72, "system__tasking__restricted__stages_E");
   E83 : Short_Integer; pragma Import (Ada, E83, "sys__flash_E");
   E10 : Short_Integer; pragma Import (Ada, E10, "driver_E");
   E75 : Short_Integer; pragma Import (Ada, E75, "init_E");
   E89 : Short_Integer; pragma Import (Ada, E89, "last_chance_handler_E");


   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");

   begin
      Main_Priority := 0;

      Ada.Text_Io'Elab_Body;
      E04 := E04 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E12 := E12 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E72 := E72 + 1;
      Sys.Flash'Elab_Spec;
      E83 := E83 + 1;
      Driver'Elab_Spec;
      Driver'Elab_Body;
      E10 := E10 + 1;
      E89 := E89 + 1;
      E75 := E75 + 1;
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
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/sys-flash.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/sys-mux.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/sys-periph.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/sys.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/sys-pll.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/gioports.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/driver.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/last_chance_handler.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/demo.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/sys-vim.o
   --   /rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/init.o
   --   -L/rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/
   --   -L/rnasbkup/gnat2015/hercules/RM57/example_sfp/obj/
   --   -L/bkup/ada/gnat2015/ravenscar-sfp-rm57/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
