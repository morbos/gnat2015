pragma Warnings (Off);
with System.RM57; use System.RM57;
pragma Warnings (On);

package Sys.Pll is
   pragma Preelaborate;

   --  Local Subprograms
   procedure Reset (Register : in out Word; Mask : Word);
   procedure Set (Register : in out Word; Mask : Word);
   procedure Initialize_Clocks;
   procedure Pll_Spinup;
   pragma Unreferenced (Set);
   pragma Unreferenced (Reset);

end Sys.Pll;

