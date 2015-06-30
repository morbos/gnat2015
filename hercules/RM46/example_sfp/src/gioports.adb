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

package body GioPorts is

   procedure GioInit is
   begin
      -- bring GIO module out of reset
      Rmw (GIO.GIOGCR0, 0, 0, 1);
      Rmw (GIO.GIOENACLR, GIOENACLR0, 16#ff#);
      Rmw (GIO.GIOLVLCLR, GIOLVLCLR0, 16#ff#);

      for I in GIO.GIOx'Range loop
         Rmw(GIO.GIOx(I).GIODOUT, 7, 0, 16#0#);
         Rmw(GIO.GIOx(I).GIODIR, 7, 0, 16#0#);
         Rmw(GIO.GIOx(I).GIOPDR, 7, 0, 16#0#);
         Rmw(GIO.GIOx(I).GIOPSL, 7, 0, 16#0#);
         Rmw(GIO.GIOx(I).GIOPULDIS, 7, 0, 16#0#);
      end loop;

      -- Fixup the 1 diff for the eval board
      Rmw(GIO.GIOx(GIO_B).GIODIR, 7, 0, 16#7#);

   end;

   procedure GioSetBit(Port : GIO_Range; Bit : Bits32; Value : Boolean) is
   begin

      Rmw(GIO.GIOx(Port).GIODOUT, Bit, Bit, (if Value then 1 else 0));
   exception
      when Constraint_Error =>
         null; -- This cannot happen as the caller will use GIO_Range
   end;

end GioPorts;
