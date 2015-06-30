with GioPorts;      use GioPorts;
with Sys;           use Sys;
with Sys.Pll;       use Sys.Pll;
package body Init is
   procedure Rm46_Init is
   begin
      Initialize_Clocks;
      Pll_Spinup;
      Sys_Init;
      GioInit;
   end Rm46_Init;
end Init;

