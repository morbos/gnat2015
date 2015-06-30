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
pragma Warnings (Off);
with System.RM46;     use System.RM46;
pragma Warnings (On);
with Accessor;        use Accessor;
package GioPorts is

   --  GIOENACLR defines
   GIOENACLR0   : constant HiLo := (7, 0);
   GIOENACLR1   : constant HiLo := (15, 8);
   GIOENACLR2   : constant HiLo := (23, 16);
   GIOENACLR3   : constant HiLo := (31, 24);

   --  GIOLVLCLR defines
   GIOLVLCLR0   : constant HiLo := (7, 0);
   GIOLVLCLR1   : constant HiLo := (15, 8);
   GIOLVLCLR2   : constant HiLo := (23, 16);
   GIOLVLCLR3   : constant HiLo := (31, 24);

   procedure GioInit;
   procedure GioSetBit(Port : GIO_Range; Bit : Bits32; Value : Boolean);

end GioPorts;

