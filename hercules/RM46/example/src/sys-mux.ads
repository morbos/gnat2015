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
with System.RM46; use System.RM46;
pragma Warnings (On);
with Interfaces;  use Interfaces;

package Sys.Mux is
   pragma Preelaborate;

   --  When you want to change the muxing, 2 magic values vvv neeed to be
   --  poked into a specific set of registers in the mux block. This is
   --  to guard against scribbles that change the pads around.

   KICKER0 : constant Unsigned_32 := 16#83E70B13#;
   KICKER1 : constant Unsigned_32 := 16#95A4F1E0#;

   procedure Mux_Init;

end Sys.Mux;

