with GioPorts;      use GioPorts;
with Sys;           use Sys;
with Sys.Pll;       use Sys.Pll;
with Sys.Flash;     use Sys.Flash;
with Sys.Vim;       use Sys.Vim;
package body Init is
   procedure Rm57_Init is
   begin
      Vim_Init;
      Initialize_Clocks;
      Flash_Init;
      Pll_Spinup;
      Sys_Init;
      GioInit;
   end Rm57_Init;
end Init;

