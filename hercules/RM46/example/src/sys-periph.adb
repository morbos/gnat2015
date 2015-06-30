------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--          Copyright (C) 2012-2013, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

pragma Ada_2012; -- To work around pre-commit check?
pragma Restrictions (No_Elaboration_Code);

with Interfaces; use Interfaces;

package body Sys.Periph is

   procedure Periph_Init is
   begin
      --  Disable Peripherals before peripheral powerup
      Rmw (SMF1.CLKCNTL, PENA, 0);

      -- Release peripherals from reset and enable clocks to all peripherals
      -- Power-up all peripherals

      Rmw (PCR.PSPWRDWNCLR0, 31, 0, not 0);
      Rmw (PCR.PSPWRDWNCLR1, 31, 0, not 0);
      Rmw (PCR.PSPWRDWNCLR2, 31, 0, not 0);
      Rmw (PCR.PSPWRDWNCLR3, 31, 0, not 0);

      --  Enable Peripherals
      Rmw (SMF1.CLKCNTL, PENA, 1);

   end;
end Sys.Periph;
