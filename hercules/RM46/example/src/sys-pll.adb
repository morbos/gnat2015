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

--  This initialization procedure mainly initializes the PLLs and
--  all derived clocks. For now it also initializes the first USART.
--  To be moved to s-textio, but needs clock info ???

with Interfaces; use Interfaces;

package body Sys.Pll is

   --  Clock sources
   SYS_OSC         : constant Unsigned_32 := 0;
   SYS_PLL1        : constant Unsigned_32 := 1;
   SYS_EXTERNAL1   : constant Unsigned_32 := 3;
   SYS_LPO_LOW     : constant Unsigned_32 := 4;
   SYS_LPO_HIGH    : constant Unsigned_32 := 5;
   SYS_PLL2        : constant Unsigned_32 := 6;
   SYS_EXTERNAL2   : constant Unsigned_32 := 7;
   SYS_VCLK        : constant Unsigned_32 := 9;
   pragma Unreferenced (SYS_EXTERNAL1);
   pragma Unreferenced (SYS_LPO_LOW);
   pragma Unreferenced (SYS_LPO_HIGH);
   pragma Unreferenced (SYS_PLL2);
   pragma Unreferenced (SYS_EXTERNAL2);

   --  GLBSTAT defines
   OSCFAIL    : constant HiLo := (0, 0);
   RFSLIP     : constant HiLo := (8, 8);
   FBSLIP     : constant HiLo := (9, 9);

   --  PLLCTL1 defines
   PLLMUL     : constant HiLo := (15, 0);
   REFCLKDIF  : constant HiLo := (21, 16);
   ROF        : constant HiLo := (23, 23);
   PLLDIV     : constant HiLo := (28, 24);
   MASK_SLIP  : constant HiLo := (30, 29);
   ROS        : constant HiLo := (31, 31);
   pragma Unreferenced (ROF);
   pragma Unreferenced (MASK_SLIP);
   pragma Unreferenced (ROS);

   --  GHVSRC defines
   GHVSOURCE  : constant HiLo := (7, 0);
   HVLPM      : constant HiLo := (19, 16);
   GHWAKE     : constant HiLo := (27, 24);

   --  PLLCTL2 defines
   SPR_AMOUNT    : constant HiLo := (8, 0);
   ODPLL         : constant HiLo := (11, 9);
   MULMOD        : constant HiLo := (20, 12);
   SPREADINGRATE : constant HiLo := (30, 22);
   FMENA         : constant HiLo := (31, 31);
   pragma Unreferenced (FMENA);

   --  PLLCTL3 defines
   PLL_MUL2   : constant HiLo := (15, 0);
   REFCLKDIV2 : constant HiLo := (21, 16);
   PLLDIV2    : constant HiLo := (28, 24);
   ODPLL2     : constant HiLo := (31, 29);

   --  CLKCNTL defines
   VCLK2R : constant HiLo := (27, 24);
   VCLKR  : constant HiLo := (19, 16);
   PENA   : constant HiLo := (8, 8);
   pragma Unreferenced (PENA);

   --  RCLKSRC defines
   RCLKSRCR1 : constant HiLo := (25, 24);
   RCLKSRCR2 : constant HiLo := (25, 24);
   RTI1DIV   : constant HiLo := (9, 8);
   RTI1SRC   : constant HiLo := (3, 0);

   --  VCLKASRC defines
   VCLKA2S   : constant HiLo := (11, 8);
   VCLKA1S   : constant HiLo := (3, 0);

   --  VCLKACON1 defines
   VCLKA4R            : constant HiLo := (26, 24);
   VCLKA4R_DIV_CDDIS  : constant HiLo := (20, 20);
   VCLKA4S            : constant HiLo := (19, 16);
   VCLKA3R            : constant HiLo := (10, 8);
   VCLKA3R_DIV_CDDIS  : constant HiLo := (4, 4);
   VCLKA3S            : constant HiLo := (3, 0);

   --  CDDIS defines
   VCLKA4OFF   : constant HiLo := (11, 11);
   VCLKA3OFF   : constant HiLo := (10, 10);
   VCLK3OFF    : constant HiLo := (8, 8);
   RTICLK1OFF  : constant HiLo := (6, 6);
   VCLKA2OFF   : constant HiLo := (5, 5);
   VCLKA1OFF   : constant HiLo := (4, 4);
   VCLK2OFF    : constant HiLo := (3, 3);
   VCLKPOFF    : constant HiLo := (2, 2);
   HCLKOFF     : constant HiLo := (1, 1);
   GCLKOFF     : constant HiLo := (0, 0);
   pragma Unreferenced (RTICLK1OFF);
   pragma Unreferenced (VCLK2OFF);
   pragma Unreferenced (VCLKPOFF);
   pragma Unreferenced (HCLKOFF);
   pragma Unreferenced (GCLKOFF);

   -----------
   -- Reset --
   -----------
   procedure Reset (Register : in out Word; Mask : Word) is
   begin
      Register := Register and not Mask;
   end Reset;

   ---------
   -- Set --
   ---------

   procedure Set (Register : in out Word; Mask : Word) is
   begin
      Register := Register or Mask;
   end Set;

   -----------------------
   -- Initialize_Clocks --
   -----------------------

   procedure Initialize_Clocks is
      PLL_Mult    : constant Unsigned_32 := 165 - 1;
      Refclkdiv   : constant Unsigned_32 := 6 - 1;
   begin
      --  Disable PLL1 and PLL2

      Rmw (SMF1.CSDISSET, 1, 0, 2);  -- CLKSR1 disabled
      Rmw (SMF1.CSDISSET, 7, 3, 8);  -- CLKSR6 disabled

      --  SAFETYMCUSW 28 D MR:NA <APPROVED> "Hardware status bit read check"
      loop
         exit when (SMF1.CSDIS and 16#42#) = 16#42#;
      end loop;

      --  Clear Global Status Register
      Rmw (SMF1.GLBSTAT, OSCFAIL, 1);
      Rmw (SMF1.GLBSTAT, RFSLIP, 1);
      Rmw (SMF1.GLBSTAT, FBSLIP, 1);

      Rmw (SMF1.PLLCTL1, PLLMUL,  Shift_Left (PLL_Mult, 8));
      Rmw (SMF1.PLLCTL1, REFCLKDIF, Refclkdiv);
      Rmw (SMF1.PLLCTL1, PLLDIV, 16#1f#);

      Rmw (SMF1.PLLCTL2, SPR_AMOUNT, 61);
      Rmw (SMF1.PLLCTL2, ODPLL, 2 - 1);
      Rmw (SMF1.PLLCTL2, MULMOD, 7);
      Rmw (SMF1.PLLCTL2, SPREADINGRATE, 255);

      Rmw (SMF2.PLLCTL3, PLL_MUL2, Shift_Left (165 - 1, 8));
      Rmw (SMF2.PLLCTL3, REFCLKDIV2, 6 - 1);
      Rmw (SMF2.PLLCTL3, PLLDIV2, 16#1f#);
      Rmw (SMF2.PLLCTL3, ODPLL2, 2 - 1);

      Rmw (SMF1.CSDIS, 7, 0, 16#88#);

   end Initialize_Clocks;

   ----------------
   -- Pll_Spinup --
   ----------------

   procedure Pll_Spinup is
      Sys_Csvstat : Word;
      Sys_Csdis   : Word;
   begin

      Rmw (SMF1.CDDIS, VCLKA4OFF, 0);
      Rmw (SMF1.CDDIS, VCLKA3OFF, 0);
      Rmw (SMF1.CDDIS, VCLK3OFF, 0);
      Rmw (SMF1.CDDIS, VCLKA2OFF, 1);
      Rmw (SMF1.CDDIS, VCLKA1OFF, 0);

      loop
         Sys_Csvstat := SMF1.CSVSTAT;
         Sys_Csdis := SMF1.CSDIS;
         exit when (Sys_Csvstat and (Sys_Csdis xor 16#ff#)) =
           ((Sys_Csdis xor 16#ff#) and 16#ff#);
      end loop;

      --  Now the PLLs are locked and the PLL outputs can be sped up
      --  The R-divider was programmed to be 0xF. Now this divider
      --  is changed to programmed value
      Rmw (SMF1.PLLCTL1, PLLDIV, 16#1#);
      Rmw (SMF2.PLLCTL3, PLLDIV2, 16#1#);

      --  Enable/Disable Frequency modulation
      Rmw (SMF1.PLLCTL2, 31, 31, 0);

      --  Map device clock domains to desired sources and configure
      --  top-level dividers. All clock domains are working off the
      --  default clock sources until now.
      --  Setup GCLK, HCLK and VCLK clock source for normal operation,
      --  power down mode and after wakeup

      Rmw (SMF1.GHVSRC, GHWAKE, SYS_OSC);
      Rmw (SMF1.GHVSRC, HVLPM, SYS_OSC);
      Rmw (SMF1.GHVSRC, GHVSOURCE, SYS_PLL1);

      Rmw (SMF1.CLKCNTL, VCLK2R, 1);
      Rmw (SMF1.CLKCNTL, VCLKR, 1);

      Rmw (SMF2.CLK2CNTRL, 7, 4, 1);  --  This is marked
                                      --  reserved. Halcogen emits
                                      --  code for it....
      Rmw (SMF2.CLK2CNTRL, 3, 0, 1);

      Rmw (SMF1.RCLKSRC, RCLKSRCR1, 1);

      Rmw (SMF1.RCLKSRC, RCLKSRCR2, SYS_VCLK);

      Rmw (SMF1.RCLKSRC, RTI1DIV, 1);
      Rmw (SMF1.RCLKSRC, RTI1SRC, SYS_VCLK);

      Rmw (SMF1.VCLKASRC, VCLKA2S, SYS_VCLK);
      Rmw (SMF1.VCLKASRC, VCLKA1S, SYS_VCLK);

      Rmw (SMF2.VCLKACON1, VCLKA4R, 0);
      Rmw (SMF2.VCLKACON1, VCLKA4R_DIV_CDDIS, 0);
      Rmw (SMF2.VCLKACON1, VCLKA4S, SYS_VCLK);
      Rmw (SMF2.VCLKACON1, VCLKA3R, 0);
      Rmw (SMF2.VCLKACON1, VCLKA3R_DIV_CDDIS, 0);
      Rmw (SMF2.VCLKACON1, VCLKA3S, SYS_VCLK);

   end Pll_Spinup;

end Sys.Pll;
