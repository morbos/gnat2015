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

--  This file provides register definitions for the RM46 (ARM Cortex R4F)
--  microcontrollers from Texas Instruments

pragma Restrictions (No_Elaboration_Code);

with System.Storage_Elements;
package System.RM46 is
   pragma Preelaborate;

   subtype Address is System.Address;
   type Word is mod 2**32;

   type Bits_1 is mod 2**1 with Size => 1;
   type Bits_2 is mod 2**2 with Size => 2;
   type Bits_4 is mod 2**4 with Size => 4;
   type Bits_16 is mod 2**16 with Size => 16;

   type Bits_32x1 is array (0 .. 31) of Bits_1 with Pack, Size => 32;
   type Bits_16x2 is array (0 .. 15) of Bits_2 with Pack, Size => 32;
   type Bits_8x4 is array (0 ..  7) of Bits_4 with Pack, Size => 32;

   --  Define address bases for the various system components

   System_Modules     : constant := 16#fff8_0000#;
   Peripherals_Frame1 : constant := 16#ff00_0000#;
   Peripherals_Frame2 : constant := 16#fc00_0000#;
   EMIF               : constant := 16#8000_0000#;
   EMIF_Async_CS4     : constant := 16#6c00_0000#;
   EMIF_Async_CS3     : constant := 16#6800_0000#;
   EMIF_Async_CS2     : constant := 16#6400_0000#;
   EMIF_Async_POM     : constant := 16#6000_0000#;
   Flash_Mirror       : constant := 16#2000_0000#;
   RAM_ECC_Base       : constant := 16#0840_0000#;
   RAM_Base           : constant := 16#0800_0000#;
   Flash_Base         : constant := 16#0000_0000#;

   HTU1_Base    : constant := Peripherals_Frame1 + 16#00F7_A400#;
   HTU2_Base    : constant := Peripherals_Frame1 + 16#00F7_A500#;
   N2HET1_Base  : constant := Peripherals_Frame1 + 16#00F7_B800#;
   N2HET2_Base  : constant := Peripherals_Frame1 + 16#00F7_B900#;
   GIO_Base     : constant := Peripherals_Frame1 + 16#00F7_BC00#;
   MIBADC1_Base : constant := Peripherals_Frame1 + 16#00F7_C000#;
   MIBADC2_Base : constant := Peripherals_Frame1 + 16#00F7_C200#;
   I2C_Base     : constant := Peripherals_Frame1 + 16#00F7_D400#;
   DCAN1_Base   : constant := Peripherals_Frame1 + 16#00F7_DC00#;
   DCAN2_Base   : constant := Peripherals_Frame1 + 16#00F7_DE00#;
   DCAN3_Base   : constant := Peripherals_Frame1 + 16#00F7_E000#;
   LIN_Base     : constant := Peripherals_Frame1 + 16#00F7_E400#;
   SCI_Base     : constant := Peripherals_Frame1 + 16#00F7_E500#;
   MibSPI1_Base : constant := Peripherals_Frame1 + 16#00F7_F400#;
   SPI2_Base    : constant := Peripherals_Frame1 + 16#00F7_F600#;
   MibSPI3_Base : constant := Peripherals_Frame1 + 16#00F7_F800#;
   SPI4_Base    : constant := Peripherals_Frame1 + 16#00F7_FA00#;
   MibSPI5_Base : constant := Peripherals_Frame1 + 16#00F7_FC00#;

   DMA_RAM_Base         : constant := System_Modules;
   VIM_RAM_Base         : constant := System_Modules + 16#0_2000#;
   Flash_Wrapper_Base   : constant := System_Modules + 16#0_2000#;
   EFuse_Farm_Ctl_Base  : constant := System_Modules + 16#0_c000#;
   PMM_Base             : constant := System_Modules + 16#7_0000#;
   FMTM_Base            : constant := System_Modules + 16#7_0400#;
   PCR_Base             : constant := System_Modules + 16#7_e000#;
   SMF2_Base            : constant := System_Modules + 16#7_e100#;
   PBIST_Base           : constant := System_Modules + 16#7_e400#;
   STC_Base             : constant := System_Modules + 16#7_e600#;
   IOMM_Base            : constant := System_Modules + 16#7_ea00#;
   DCC1_Base            : constant := System_Modules + 16#7_ea00#;
   DMA_Base             : constant := System_Modules + 16#7_f000#;
   DCC2_Base            : constant := System_Modules + 16#7_f400#;
   ESM_Base             : constant := System_Modules + 16#7_f500#;
   CCMR4_Base           : constant := System_Modules + 16#7_f600#;
   RAM_ECC_Even_Base    : constant := System_Modules + 16#7_f800#;
   RAM_ECC_Odd_Base     : constant := System_Modules + 16#7_f900#;
   RTI_Base             : constant := System_Modules + 16#7_fc00#;
   VIM_Parity_Base      : constant := System_Modules + 16#7_fd00#;
   VIM_Base             : constant := System_Modules + 16#7_fe00#;
   SMF1_Base            : constant := System_Modules + 16#7_ff00#;

   ---------------------------------
   -- RCC Reset and Clock Control --
   ---------------------------------

   type SMF1_Registers is record
      SYSPC1         : Word;  --  SYS Pin Control Register 1 at 16#00#
      SYSPC2         : Word;  --  SYS Pin Control Register 2 at 16#04#
      SYSPC3         : Word;  --  SYS Pin Control Register 3 at 16#08#
      SYSPC4         : Word;  --  SYS Pin Control Register 4 at 16#0c#
      SYSPC5         : Word;  --  SYS Pin Control Register 5 at 16#10#
      SYSPC6         : Word;  --  SYS Pin Control Register 6 at 16#14#
      SYSPC7         : Word;  --  SYS Pin Control Register 7 at 16#18#
      SYSPC8         : Word;  --  SYS Pin Control Register 8 at 16#1c#
      SYSPC9         : Word;  --  SYS Pin Control Register 9 at 16#20#
      Reserved_1     : Word;  --  reserved at 16#24#
      Reserved_2     : Word;  --  reserved at 16#28#
      Reserved_3     : Word;  --  reserved at 16#2c#
      CSDIS          : Word;  --  Clock Source Disable Register at 16#30#
      CSDISSET       : Word;  --  Clock Source Disable Set Register at 16#34#
      CSDISCLR       : Word;  --  Clock Source Disable Clear Register at 16#38#
      CDDIS          : Word;  --  Clock Domain Disable Register at 16#3c#
      CDDISSET       : Word;  --  Clock Domain Disable Set Register at 16#40#
      CDDISCLR       : Word;  --  Clock Domain Disable Clear Register at 16#44#
      GHVSRC         : Word;  --  GCLK, HCLK, VCLK, VCLK2 Source Reg at 16#48#
      VCLKASRC       : Word;  --  Periph aync clk src register at 16#4c#
      RCLKSRC        : Word;  --  RTI Clock Source Register at 16#50#
      CSVSTAT        : Word;  --  Clock Source Valid Status Register at 16#54#
      MSTGCR         : Word;  --  mem self-test glbl ctl reg at 16#58#
      MINITGCR       : Word;  --  mem hw init glbl ctl reg at 16#5c#
      MSIENA         : Word;  --  mem self-test/init enable reg at 16#60#
      MSTFAIL        : Word;  --  Memory Self-Test Fail Status Register 16#64#
      MSTCGSTAT      : Word;  --  MSTC Global Status Register 16#68#
      MINISTAT       : Word;  --  Memory Hardware Init Status Reg 16#6c#
      PLLCTL1        : Word;  --  PLL Control Register 1 16#70#
      PLLCTL2        : Word;  --  PLL Control Register 2 16#74#
      SYSPC10        : Word;  --  SYS Pin Control Register 10 16#78#
      DIEIDL         : Word;  --  Die Identification Reg, Lower Word 16#7c#
      DIEIDH         : Word;  --  Die Identification Reg, Upper Word 16#80#
      Reserved_4     : Word;  --  reserved at 16#84#
      LPOMONCTL      : Word;  --  LPO/Clock Monitor Control Register 16#88#
      CLKTEST        : Word;  --  Clock Test Register 16#8c#
      DFTCTRLREG     : Word;  --  DFT Control Register 16#90#
      DFTCTRLREG2    : Word;  --  DFT Control Register 2 16#94#
      Reserved_5     : Word;  --  reserved at 16#98#
      Reserved_6     : Word;  --  reserved at 16#9c#
      GPREG1         : Word;  --  General Purpose Register 16#a0#
      Reserved_7     : Word;  --  reserved at 16#a4#
      IMPFASTS       : Word;  --  Imprecise Fault Status Register 16#a8#
      IMPFTADD       : Word;  --  Imprecise Fault Write Address Reg 16#ac#
      SSIR1          : Word;  --  System Software Interrupt Req 1 Reg 16#b0#
      SSIR2          : Word;  --  System Software Interrupt Req 2 Reg 16#b4#
      SSIR3          : Word;  --  System Software Interrupt Req 3 Reg 16#b8#
      SSIR4          : Word;  --  System Software Interrupt Req 4 Reg 16#bc#
      RAMGCR         : Word;  --  RAM Control Register 16#c0#
      BMMCR1         : Word;  --  Bus Matrix Module Control Register 1 16#c4#
      Reserved_8     : Word;  --  reserved at 16#c8#
      CPURSTCR       : Word;  --  CPU Reset Control Register 16#cc#
      CLKCNTL        : Word;  --  Clock Control Register 16#d0#
      ECPCNTL        : Word;  --  ECP Control Register 16#d4#
      Reserved_9     : Word;  --  reserved at 16#d8#
      DEVCR1         : Word;  --  DEV Parity Control Register 1 16#dc#
      SYSECR         : Word;  --  System Exception Control Register 16#e0#
      SYSESR         : Word;  --  System Exception Status Register 16#e4#
      SYSTASR        : Word;  --  System Test Abort Status Register 16#e8#
      GLBSTAT        : Word;  --  Global Status Register 16#ec#
      DEVID          : Word;  --  Device Identification Register 16#f0#
      SSIVEC         : Word;  --  Software Interrupt Vector Register 16#f4#
      SSIF           : Word;  --  System Software Interrupt Flag Reg 16#f8#
   end record;

   SMF1 : SMF1_Registers with Volatile, Address
     => System'To_Address (SMF1_Base);

   type SMF2_Registers is record
      PLLCTL3     : Word;  --  PLL Control Register 3 16#00#;
      Reserved_1  : Word;  --  reserved 16#04#;
      STCCLKDIV   : Word;  --  CPU Logic BIST Clock Divider 16#08#;
      Reserved_2  : Word;  --  reserved 16#0c#;
      Reserved_3  : Word;  --  reserved 16#10#;
      Reserved_4  : Word;  --  reserved 16#14#;
      Reserved_5  : Word;  --  reserved 16#18#;
      Reserved_6  : Word;  --  reserved 16#1c#;
      Reserved_7  : Word;  --  reserved 16#20#;
      ECPCNTL     : Word;  --  ECP Control Register 16#24#;
      Reserved_8  : Word;  --  reserved 16#28#;
      Reserved_9  : Word;  --  reserved 16#2c#;
      Reserved_10 : Word;  --  reserved 16#30#;
      Reserved_11 : Word;  --  reserved 16#34#;
      Reserved_12 : Word;  --  reserved 16#38#;
      CLK2CNTRL   : Word;  --  Clock 2 Control Register 16#3C#;
      VCLKACON1   : Word;  --  Peripheral Async Clock Config 1 Reg 16#40#;
      Reserved_13 : Word;  --  reserved 16#44#;
      Reserved_14 : Word;  --  reserved 16#48#;
      Reserved_15 : Word;  --  reserved 16#4c#;
      Reserved_16 : Word;  --  reserved 16#50#;
      Reserved_17 : Word;  --  reserved 16#54#;
      Reserved_18 : Word;  --  reserved 16#58#;
      Reserved_19 : Word;  --  reserved 16#5c#;
      Reserved_20 : Word;  --  reserved 16#60#;
      Reserved_21 : Word;  --  reserved 16#64#;
      Reserved_22 : Word;  --  reserved 16#68#;
      Reserved_23 : Word;  --  reserved 16#6c#;
      CLKSLIP     : Word;  --  Clock Slip Register 16#70#;
      Reserved_24 : Word;  --  reserved 16#70#;
      Reserved_25 : Word;  --  reserved 16#74#;
      Reserved_26 : Word;  --  reserved 16#78#;
      Reserved_27 : Word;  --  reserved 16#7c#;
      Reserved_28 : Word;  --  reserved 16#80#;
      Reserved_29 : Word;  --  reserved 16#84#;
      Reserved_30 : Word;  --  reserved 16#88#;
      Reserved_31 : Word;  --  reserved 16#8c#;
      Reserved_32 : Word;  --  reserved 16#90#;
      Reserved_33 : Word;  --  reserved 16#94#;
      Reserved_34 : Word;  --  reserved 16#98#;
      Reserved_35 : Word;  --  reserved 16#9c#;
      Reserved_36 : Word;  --  reserved 16#a0#;
      Reserved_37 : Word;  --  reserved 16#a4#;
      Reserved_38 : Word;  --  reserved 16#a8#;
      Reserved_39 : Word;  --  reserved 16#ac#;
      Reserved_40 : Word;  --  reserved 16#b0#;
      Reserved_41 : Word;  --  reserved 16#b4#;
      Reserved_42 : Word;  --  reserved 16#b8#;
      Reserved_43 : Word;  --  reserved 16#bc#;
      Reserved_44 : Word;  --  reserved 16#c0#;
      Reserved_45 : Word;  --  reserved 16#c4#;
      Reserved_46 : Word;  --  reserved 16#c8#;
      Reserved_47 : Word;  --  reserved 16#cc#;
      Reserved_48 : Word;  --  reserved 16#d0#;
      Reserved_49 : Word;  --  reserved 16#d4#;
      Reserved_50 : Word;  --  reserved 16#d8#;
      Reserved_51 : Word;  --  reserved 16#dc#;
      Reserved_52 : Word;  --  reserved 16#e0#;
      Reserved_53 : Word;  --  reserved 16#e4#;
      Reserved_54 : Word;  --  reserved 16#e8#;
      EFC_CTLREG  : Word;  --  EFUSE Controller Control Register 16#EC#;
      DIEIDL_REG0 : Word;  --  Die Identification Register Lower Word 16#F0#;
      DIEIDH_REG1 : Word;  --  Die Identification Register Upper Word 16#F4#;
      DIEIDL_REG2 : Word;  --  Die Identification Register Lower Word 16#F8#;
      DIEIDH_REG3 : Word;  --  Die Identification Register Upper Word 16#FC#;
   end record;

   SMF2 : SMF2_Registers with Volatile, Address
     => System'To_Address (SMF2_Base);

   type PCR_Registers is record
      PMPROTSET0    : Word; -- Peripheral Mem Prot Set Reg 0 16#00#
      PMPROTSET1    : Word; -- Peripheral Mem Prot Set Reg 1 16#04#
      Reserved_1    : Word; -- reserved 16#08#;
      Reserved_2    : Word; -- reserved 16#0c#;
      PMPROTCLR0    : Word; -- Peripheral Mem Prot Clear Reg 0 16#10#
      PMPROTCLR1    : Word; -- Peripheral Mem Prot Clear Reg 1 16#14#
      Reserved_3    : Word; -- reserved 16#18#;
      Reserved_4    : Word; -- reserved 16#1c#;
      PPROTSET0     : Word; -- Peripheral Prot Set Register 0 16#20#
      PPROTSET1     : Word; -- Peripheral Prot Set Register 1 16#24#
      PPROTSET2     : Word; -- Peripheral Prot Set Register 2 16#28#
      PPROTSET3     : Word; -- Peripheral Prot Set Register 3 16#2C#
      Reserved_5    : Word; -- reserved 16#30#;
      Reserved_6    : Word; -- reserved 16#34#;
      Reserved_7    : Word; -- reserved 16#38#;
      Reserved_8    : Word; -- reserved 16#3c#;
      PPROTCLR0     : Word; -- Peripheral Prot Clear Register 0 16#40#
      PPROTCLR1     : Word; -- Peripheral Prot Clear Register 1 16#44#
      PPROTCLR2     : Word; -- Peripheral Prot Clear Register 2 16#48#
      PPROTCLR3     : Word; -- Peripheral Prot Clear Register 3 16#4C#
      Reserved_9    : Word; -- reserved 16#50#;
      Reserved_10   : Word; -- reserved 16#54#;
      Reserved_11   : Word; -- reserved 16#58#;
      Reserved_12   : Word; -- reserved 16#5c#;
      PCSPWRDWNSET0 : Word; -- Peripheral Mem Power-Down Set Reg 0 16#60#
      PCSPWRDWNSET1 : Word; -- Peripheral Mem Power-Down Set Reg 1 16#64#
      Reserved_13   : Word; -- reserved 16#68#;
      Reserved_14   : Word; -- reserved 16#6c#;
      PCSPWRDWNCLR0 : Word; -- Peripheral Mem Power-Down Clr Reg 0 16#70#
      PCSPWRDWNCLR1 : Word; -- Peripheral Mem Power-Down Clr Reg 1 16#74#
      Reserved_15   : Word; -- reserved 16#78#;
      Reserved_16   : Word; -- reserved 16#7c#;
      PSPWRDWNSET0  : Word; -- Peripheral Power-Down Set Register 0 16#80#
      PSPWRDWNSET1  : Word; -- Peripheral Power-Down Set Register 1 16#84#
      PSPWRDWNSET2  : Word; -- Peripheral Power-Down Set Register 2 16#88#
      PSPWRDWNSET3  : Word; -- Peripheral Power-Down Set Register 3 16#8C#
      Reserved_17   : Word; -- reserved 16#90#;
      Reserved_18   : Word; -- reserved 16#94#;
      Reserved_19   : Word; -- reserved 16#98#;
      Reserved_20   : Word; -- reserved 16#9c#;
      PSPWRDWNCLR0  : Word; -- Peripheral Power-Down Clear Register 0 16#A0#
      PSPWRDWNCLR1  : Word; -- Peripheral Power-Down Clear Register 1 16#A4#
      PSPWRDWNCLR2  : Word; -- Peripheral Power-Down Clear Register 2 16#A8#
      PSPWRDWNCLR3  : Word; -- Peripheral Power-Down Clear Register 3 16#AC#
   end record;

   PCR : PCR_Registers with Volatile, Address
     => System'To_Address (PCR_Base);

   type Reserved_Block1 is array (1 .. 7) of Word;
   type Reserved_Block2 is array (1 .. 40) of Word;
   type Reserved_Block3 is array (1 .. 21) of Word;
   type PINMMR_Block    is array (0 .. 47) of Word;

   type IOMM_Registers is record
      REVISION_REG            : Word; --  Revision Register 16#0#;
      Reserved1               : Reserved_Block1;
      ENDIAN_REG              : Word; -- Device Endianness Register 16#20#;
      KICK_REG0               : Word; -- Kicker Register 0 16#38#;
      KICK_REG1               : Word; -- Kicker Register 1 16#3C#;
      Reserved2               : Reserved_Block2;
      ERR_RAW_STATUS_REG      : Word; -- Error Raw Status / Set Reg 16#E0#;
      ERR_ENABLED_STATUS_REG  : Word; -- Error Ena Status / Clear Reg 16#E4#;
      ERR_ENABLE_REG          : Word; -- Error Signaling Ena Reg 16#E8#;
      ERR_ENABLE_CLR_REG      : Word; -- Error Signaling Ena Clear Reg 16#EC#;
      FAULT_ADDRESS_REG       : Word; -- Fault Address Register 16#F4#;
      FAULT_STATUS_REG        : Word; -- Fault Status Register 16#F8#;
      FAULT_CLEAR_REG         : Word; -- Fault Clear Register 16#FC#;
      Reserved3               : Reserved_Block2;
      PINMMR                  : PINMMR_Block; -- Pin Mux Control Reg
   end record;

   IOMM : IOMM_Registers with Volatile, Address
     => System'To_Address (IOMM_Base);

   type GIO_Unit is record
      GIODIR    : Word; -- GIO Data Direction Register
      GIODIN    : Word; -- GIO Data Input Register
      GIODOUT   : Word; -- GIO Data Output Register
      GIODSET   : Word; -- GIO Data Set Register
      GIODCLR   : Word; -- GIO Data Clear Register
      GIOPDR    : Word; -- GIO Open Drain Register
      GIOPULDIS : Word; -- GIO Pull Disable Register
      GIOPSL    : Word; -- GIO Pull Select Register
   end record;

   type GIO_Range is (GIO_A, GIO_B);
   for GIO_Range use (GIO_A => 0, GIO_B => 1);

   --  This range can be 0..7 on some SoCs vvvvvv
   type GIO_Block is array (GIO_Range) of GIO_Unit;

   type GIO_Register is record
      GIOGCR0   : Word; -- GIO Global Control Register #00#
      Reserved1 : Word; -- reserved 16#04#
      GIOINTDET : Word; -- GIO Interrupt Detect Register #08#
      GIOPOL    : Word; -- GIO Interrupt Polarity Register #0C#
      GIOENASET : Word; -- GIO Interrupt Enable #10#
      GIOENACLR : Word; -- GIO Interrupt Enable Clear Register #14#
      GIOLVLSET : Word; -- GIO Interrupt Priority #18#
      GIOLVLCLR : Word; -- GIO Interrupt Priority Clear Register #1C#
      GIOFLG    : Word; -- GIO Interrupt Flag Register #20#
      GIOOFF1   : Word; -- GIO Offset 1 Register #24#
      GIOOFF2   : Word; -- GIO Offset 2 Register #28#
      GIOEMU1   : Word; -- GIO Emulation 1 Register #2C#
      GIOEMU2   : Word; -- GIO Emulation 2 Register #30#
      GIOx      : GIO_Block;
   end record;

   GIO : GIO_Register with Volatile, Address
     => System'To_Address (GIO_Base);

   type VIM_Parity_Reserved_Block is array (1 .. 59) of Word;
   type VIM_Parity_Register is record
      Reserved1 : VIM_Parity_Reserved_Block;
      PARFLG    : Word; -- Interrupt Vector Table Parity Flag Register 16#EC#;
      PARCTL    : Word; -- Interrupt Vector Table Parity Control Reg 16#F0#;
      ADDERR    : Word; -- Address Parity Error Register 16#F4#;
      FBPARERR  : Word; -- Fall-Back Address Parity Error Register 16#F8#;
   end record;

   VIM_Parity : VIM_Parity_Register with Volatile, Address
     => System'To_Address (VIM_Parity_Base);

   type VIM_Chan_Range is range 0 .. 23;
   type VIM_Chan_Block is array (VIM_Chan_Range) of Word;

   type VIM_Register is record
      IRQINDEX    : Word; -- IRQ Index Offset Vector Register 16#00#;
      FIQINDEX    : Word; -- FIQ Index Offset Vector Register 16#04#;
      Reserved1   : Word; -- reserved 16#08#
      Reserved2   : Word; -- reserved 16#0c#
      FIRQPR0     : Word; -- FIQ/IRQ Program Control Register 0 16#10#;
      FIRQPR1     : Word; -- FIQ/IRQ Program Control Register 1 16#14#;
      FIRQPR2     : Word; -- FIQ/IRQ Program Control Register 2 16#18#;
      FIRQPR3     : Word; -- FIQ/IRQ Program Control Register 3 16#1C#;
      INTREQ0     : Word; -- Pending Interrupt Read Location Register 0 16#20#;
      INTREQ1     : Word; -- Pending Interrupt Read Location Register 1 16#24#;
      INTREQ2     : Word; -- Pending Interrupt Read Location Register 2 16#28#;
      INTREQ3     : Word; -- Pending Interrupt Read Location Register 3 16#2C#;
      REQENASET0  : Word; -- Interrupt Enable Set Register 0 16#30#;
      REQENASET1  : Word; -- Interrupt Enable Set Register 1 16#34#;
      REQENASET2  : Word; -- Interrupt Enable Set Register 2 16#38#;
      REQENASET3  : Word; -- Interrupt Enable Set Register 3 16#3C#;
      REQENACLR0  : Word; -- Interrupt Enable Clear Register 0 16#40#;
      REQENACLR1  : Word; -- Interrupt Enable Clear Register 1 16#44#;
      REQENACLR2  : Word; -- Interrupt Enable Clear Register 2 16#48#;
      REQENACLR3  : Word; -- Interrupt Enable Clear Register 3 16#4C#;
      WAKEENASET0 : Word; -- Wake-up Enable Set Register 0 16#50#;
      WAKEENASET1 : Word; -- Wake-up Enable Set Register 1 16#54#;
      WAKEENASET2 : Word; -- Wake-up Enable Set Register 2 16#58#;
      WAKEENASET3 : Word; -- Wake-up Enable Set Register 3 16#5C#;
      WAKEENACLR0 : Word; -- Wake-up Enable Clear Register 0 16#60#;
      WAKEENACLR1 : Word; -- Wake-up Enable Clear Register 1 16#64#;
      WAKEENACLR2 : Word; -- Wake-up Enable Clear Register 2 16#68#;
      WAKEENACLR3 : Word; -- Wake-up Enable Clear Register 3 16#6C#;
      IRQVECREG   : Word; -- IRQ Interrupt Vector Register 16#70#;
      FIQVECREG   : Word; -- FIQ Interrupt Vector Register 16#74#;
      CAPEVT      : Word; -- Capture Event Register 16#78#;
      CHANCTRL    : VIM_Chan_Block; -- 80 + 24*4 = e0
   end record;

   VIMp  : VIM_Register with Volatile, Address
     => System'To_Address (VIM_Base);

   type HandlerT is access procedure;

   type VIM_RAM_Block is array (0 .. 95) of HandlerT;

   VIM_RAM : VIM_RAM_Block with Volatile, Address
     => System'To_Address (VIM_RAM_Base);
   pragma Import (Ada, VIM_RAM);

end System.RM46;
