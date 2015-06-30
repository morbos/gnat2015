with Interfaces; use Interfaces;
with Accessor;   use Accessor;

package body Sys.Flash is

   procedure Flash_Init is
   begin
      Rmw (FLASH.FRDCNTL, 31, 0, 16#403#);

      Rmw (FLASH.FSM_WR_ENA, 31, 0, 5);

      Rmw (FLASH.EEPROM_CONFIG, 31, 0, 16#A_0002#);

      Rmw (FLASH.FSM_WR_ENA, 31, 0, 2);

      Rmw (FLASH.FBPWRMODE, 31, 0, Shift_Left(3, 14) or Shift_Left(3, 2) or 3);

   end Flash_Init;

end Sys.Flash;
