with System;
with RM46;           use RM46;

package Rm46Rti is

   type RTI_Counter is record
      RTIFRC          : Word; --  RTI Free Running Counter Register
      RTIUC           : Word; --  RTI Up Counter Register
      RTICPUC         : Word; --  RTI Compare Up Counter Register
      RTICAFRC        : Word; --  RTI Capture Free Running Counter Register
      RTICAUC         : Word; --  RTI Capture Up Counter Register
   end record;

   type RTI_Counter_Range is range 0 .. 1;

   type RTI_Counter_Block is array(RTI_Counter_Range) of RTI_Counter;

   RTI_COUNTER_BLOCK0 : constant RTI_Counter_Range := 0;
   RTI_COUNTER_BLOCK1 : constant RTI_Counter_Range := 1;

   type RTI_Compare is record
      RTICOMP         : Word; --  RTI Compare Register
      RTIUDCP         : Word; --  RTI Update Compare Register
   end record;

   type RTI_Compare_Range is range 0 .. 3;

   type RTI_Compare_Block is array(RTI_Compare_Range) of RTI_Compare;

   type RTI_Registers is record
      RTIGCTRL        : Word; --  RTI Global Control Register 16#00#
      RTITBCTRL       : Word; --  RTI Timebase Control Register 16#04#
      RTICAPCTRL      : Word; --  RTI Capture Control Register 16#08#
      RTICOMPCTRL     : Word; --  RTI Compare Control Register 16#0C#
      RTICNT          : RTI_Counter_Block;
      RTICMP          : RTI_Compare_Block;
      RTITBLCOMP      : Word; --  RTI Timebase Low Compare Register 16#70#
      RTITBHCOMP      : Word; --  RTI Timebase High Compare Register 16#74#
      RTISETINTENA    : Word; --  RTI Set Interrupt Enable Register 16#80#
      RTICLEARINTENA  : Word; --  RTI Clear Interrupt Enable Register 16#84#
      RTIINTFLAG      : Word; --  RTI Interrupt Flag Register 16#88#
      RTIDWDCTRL      : Word; --  Digital Watchdog Control Register 16#90#
      RTIDWDPRLD      : Word; --  Digital Watchdog Preload Register 16#94#
      RTIWDSTATUS     : Word; --  Watchdog Status Register 16#98#
      RTIWDKEY        : Word; --  RTI Watchdog Key Register 16#9C#
      RTIDWDCNTR      : Word; --  RTI Digital Watchdog Down Counter Register 16#A0#
      RTIWWDRXNCTRL   : Word; --  Digital Windowed Watchdog Reaction Control Register 16#A4#
      RTIWWDSIZECTRL  : Word; --  Digital Windowed Watchdog Window Size Control Register 16#A8#
      RTIINTCLRENABLE : Word; --  RTI Compare Interrupt Clear Enable Register 16#AC#
      RTICOMP0CLR     : Word; --  RTI Compare 0 Clear Register 16#B0#
      RTICOMP1CLR     : Word; --  RTI Compare 1 Clear Register 16#B4#
      RTICOMP2CLR     : Word; --  RTI Compare 2 Clear Register 16#B8#
      RTICOMP3CLR     : Word; --  RTI Compare 3 Clear Register 16#BC#
   end record;

   RTI : RTI_Registers with Volatile, Address
     => System'To_Address (RTI_Base);

   type Notifications is (RTI_NOTIFICATION_COMPARE0, RTI_NOTIFICATION_COMPARE1,
                          RTI_NOTIFICATION_COMPARE2, RTI_NOTIFICATION_COMPARE3,
                          RTI_NOTIFICATION_TIMEBASE, RTI_NOTIFICATION_COUNTER0,
                          RTI_NOTIFICATION_COUNTER1);
   for Notifications use
     (RTI_NOTIFICATION_COMPARE0 => 0,   -- RTI compare 0 notification
      RTI_NOTIFICATION_COMPARE1 => 1,   -- RTI compare 1 notification
      RTI_NOTIFICATION_COMPARE2 => 2,   -- RTI compare 2 notification
      RTI_NOTIFICATION_COMPARE3 => 3,   -- RTI compare 3 notification
      RTI_NOTIFICATION_TIMEBASE => 16,  -- RTI Timebase notification
      RTI_NOTIFICATION_COUNTER0 => 17,  -- RTI counter 0 overflow notification
      RTI_NOTIFICATION_COUNTER1 => 18); -- RTI counter 1 overflow notification

--   for Notifications use
--     (RTI_NOTIFICATION_COMPARE0 => Shift_Left(1, 0),   -- RTI compare 0 notification
--      RTI_NOTIFICATION_COMPARE1 => Shift_Left(1, 1),   -- RTI compare 1 notification
--      RTI_NOTIFICATION_COMPARE2 => Shift_Left(1, 2),   -- RTI compare 2 notification
--      RTI_NOTIFICATION_COMPARE3 => Shift_Left(1, 3),   -- RTI compare 3 notification
--      RTI_NOTIFICATION_TIMEBASE => Shift_Left(1, 16),  -- RTI Timebase notification
--      RTI_NOTIFICATION_COUNTER0 => Shift_Left(1, 17),  -- RTI counter 0 overflow notification
--      RTI_NOTIFICATION_COUNTER1 => Shift_Left(1, 18));  -- RTI counter 1 overflow notification

   procedure RtiInit;

   procedure RtiStartCounter ( Counter : RTI_Counter_Range);

   procedure RtiEnableNotification ( Notification : Notifications);

end Rm46Rti;
