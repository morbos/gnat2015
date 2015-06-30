with Ada.Unchecked_Conversion;
with Accessor;    use Accessor;
package body Rm46Rti is

   --  RTIGCTRL defines
   CNT0EN   : constant HiLo := (0, 0);
   CNT1EN   : constant HiLo := (1, 1);
   COS      : constant HiLo := (15, 15);
   NTUSEL   : constant HiLo := (19, 16);
   --  RTITBCTRL
   TBEXT    : constant HiLo := (0, 0);
   INC      : constant HiLo := (1, 1);
   --  RTICAPCTRL
   CAPCNTR0 : constant HiLo := (0, 0);
   CAPCNTR1 : constant HiLo := (1, 1);
   --  RTICOMPCTRL
   COMPSEL0 : constant HiLo := (0, 0);
   COMPSEL1 : constant HiLo := (4, 4);
   COMPSEL2 : constant HiLo := (8, 8);
   COMPSEL3 : constant HiLo := (12, 12);
   --  RTIINTFLAG
   INT0    : constant HiLo := (0, 0);
   INT1    : constant HiLo := (1, 1);
   INT2    : constant HiLo := (2, 2);
   INT3    : constant HiLo := (3, 3);
   TBINT   : constant HiLo := (16, 16);
   OVL0INT : constant HiLo := (17, 17);
   OVL1INT : constant HiLo := (18, 18);

   --  RTICLEARINTENA
   CLEARINT0    : constant HiLo := (0, 0);
   CLEARINT1    : constant HiLo := (1, 1);
   CLEARINT2    : constant HiLo := (2, 2);
   CLEARINT3    : constant HiLo := (3, 3);
   CLEARDMA0    : constant HiLo := (8, 8);
   CLEARDMA1    : constant HiLo := (9, 9);
   CLEARDMA2    : constant HiLo := (10, 10);
   CLEARDMA3    : constant HiLo := (11, 11);
   CLEARTBINT   : constant HiLo := (16, 16);
   CLEAROVL0INT : constant HiLo := (17, 17);
   CLEAROVL1INT : constant HiLo := (18, 18);

   procedure RtiInit is
   begin
      --  Setup NTU source, debug options and disable both counter blocks
      Rmw(RTI.RTIGCTRL, CNT0EN, 0);
      Rmw(RTI.RTIGCTRL, CNT1EN, 0);
      Rmw(RTI.RTIGCTRL, COS, 0);
      Rmw(RTI.RTIGCTRL, NTUSEL, 16#a#);

      --  Setup timebase for free running counter 0
      Rmw(RTI.RTITBCTRL, TBEXT, 0);
      Rmw(RTI.RTITBCTRL, INC, 0);

      --  Enable/Disable capture event sources for both counter blocks
      Rmw(RTI.RTICAPCTRL, CAPCNTR0, 0);
      Rmw(RTI.RTICAPCTRL, CAPCNTR1, 0);

      --  Setup input source compare 0-3
      Rmw(RTI.RTICOMPCTRL, COMPSEL0, 0);
      Rmw(RTI.RTICOMPCTRL, COMPSEL1, 0);
      Rmw(RTI.RTICOMPCTRL, COMPSEL2, 1);
      Rmw(RTI.RTICOMPCTRL, COMPSEL3, 1);

      for I in RTI.RTICNT'Range loop
         -- Reset up counter
         Rmw(RTI.RTICNT(I).RTIUC, 31, 0, 0);

         --  Reset free running counter
         Rmw(RTI.RTICNT(I).RTIFRC, 31, 0, 0);

         --  Setup up counter compare value
         --    - 0x00000000: Divide by 2^32
         --    - 0x00000001-0xFFFFFFFF: Divide by (CPUCx + 1)
         --
         Rmw(RTI.RTICNT(I).RTICPUC, 31, 0, 10);
      end loop;

      --  Setup compare 0 value. This value is compared with selected free running counter.
      Rmw(RTI.RTICMP(0).RTICOMP, 31, 0, 1000000);

      --  Setup update compare 0 value. This value is added to the compare 0 value on each compare match.
      Rmw(RTI.RTICMP(0).RTIUDCP, 31, 0, 1000000);

      --  Setup compare 1 value. This value is compared with selected free running counter.
      Rmw(RTI.RTICMP(1).RTICOMP, 31, 0, 50000);

      --  Setup update compare 1 value. This value is added to the compare 1 value on each compare match.
      Rmw(RTI.RTICMP(1).RTIUDCP, 31, 0, 50000);

      --  Setup compare 2 value. This value is compared with selected free running counter.
      Rmw(RTI.RTICMP(2).RTICOMP, 31, 0, 80000);

      --  Setup update compare 2 value. This value is added to the compare 2 value on each compare match.
      Rmw(RTI.RTICMP(2).RTIUDCP, 31, 0, 80000);

      --  Setup compare 3 value. This value is compared with selected free running counter.
      Rmw(RTI.RTICMP(3).RTICOMP, 31, 0, 100000);

      --  Setup update compare 3 value. This value is added to the compare 3 value on each compare match.
      Rmw(RTI.RTICMP(3).RTIUDCP, 31, 0, 100000);


      --  Clear all pending interrupts
      Rmw(RTI.RTIINTFLAG, INT0, 1);
      Rmw(RTI.RTIINTFLAG, INT1, 1);
      Rmw(RTI.RTIINTFLAG, INT2, 1);
      Rmw(RTI.RTIINTFLAG, INT3, 1);
      Rmw(RTI.RTIINTFLAG, TBINT, 1);
      Rmw(RTI.RTIINTFLAG, OVL0INT, 1);
      Rmw(RTI.RTIINTFLAG, OVL1INT, 1);

      Rmw(RTI.RTICLEARINTENA, CLEARINT0, 1);
      Rmw(RTI.RTICLEARINTENA, CLEARINT1, 1);
      Rmw(RTI.RTICLEARINTENA, CLEARINT2, 1);
      Rmw(RTI.RTICLEARINTENA, CLEARINT3, 1);
      Rmw(RTI.RTICLEARINTENA, CLEARDMA0, 1);
      Rmw(RTI.RTICLEARINTENA, CLEARDMA1, 1);
      Rmw(RTI.RTICLEARINTENA, CLEARDMA2, 1);
      Rmw(RTI.RTICLEARINTENA, CLEARDMA3, 1);
      Rmw(RTI.RTICLEARINTENA, CLEARTBINT, 1);
      Rmw(RTI.RTICLEARINTENA, CLEAROVL0INT, 1);
      Rmw(RTI.RTICLEARINTENA, CLEAROVL1INT, 1);

   end RtiInit;

   procedure RtiStartCounter ( Counter : RTI_Counter_Range) is
      Bitpos : Bits32;
   begin
      Bitpos := Bits32 (Counter);
      --  Setup NTU source, debug options and disable both counter blocks
      Rmw(RTI.RTIGCTRL, Bitpos, Bitpos, 1);
   end RtiStartCounter;

   function As_Bits32 is new Ada.Unchecked_Conversion
     (Source => Notifications, Target => Bits32);

   procedure RtiEnableNotification ( Notification : Notifications) is
      Bitpos : Bits32;
   begin
      Bitpos := As_Bits32 (Notification);
      Rmw(RTI.RTIINTFLAG, Bitpos, Bitpos, 1);

   end RtiEnableNotification;

end Rm46Rti;
