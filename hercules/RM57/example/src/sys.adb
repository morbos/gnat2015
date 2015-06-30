with Sys.Periph;   use Sys.Periph;
with Sys.Mux;      use Sys.Mux;
package body Sys is
   procedure Sys_Init is
   begin
      Periph_Init;
      Mux_Init;
   end;
end Sys;
