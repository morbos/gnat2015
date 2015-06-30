pragma Restrictions (No_Elaboration_Code);

with Interfaces;    use Interfaces;
with System.RM46;   use System.RM46;

package Accessor is
   pragma Preelaborate;

   subtype Bits32 is Natural range 0 .. 31;
   subtype Bits32p1 is Positive range 1 .. 32;

   type HiLo is record
      Hi : Bits32;
      Lo : Bits32;
   end record;

   procedure Rmw (Register : in out Word;
                  Hi : Bits32;
                  Lo : Bits32;
                  Valarg : Unsigned_32);
   procedure Rmw (Register : in out Word;
                  Template : HiLo;
                  Valarg : Unsigned_32);
end Accessor;
