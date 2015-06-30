package body Accessor is

   procedure Rmw (Register : in out Word;
                  Hi : Bits32;
                  Lo : Bits32;
                  Valarg : Unsigned_32) is
      Tmp     : Unsigned_32;
      Mask    : Unsigned_32;
      Masklen : Bits32p1;

      Value   : Unsigned_32;
      One     : constant Unsigned_32 := 1;
   begin
      Tmp      := Unsigned_32 (Register);
      Masklen  := (Hi - Lo) + 1;
      Mask     := Shift_Left (One, Masklen) - 1;
      Value    := Valarg and Mask;
      Value    := Shift_Left (Value, Lo);
      Mask     := Shift_Left (Mask, Lo);
      Tmp      := Tmp and not Mask;
      Tmp      := Tmp or Value;
      Register := Word (Tmp);
   exception
      when Constraint_Error =>
         Register := 0;
   end Rmw;

   procedure Rmw (Register : in out Word;
                  Template : HiLo;
                  Valarg : Unsigned_32) is
      Hi      : Bits32;
      Lo      : Bits32;
      Tmp     : Unsigned_32;
      Mask    : Unsigned_32;
      Masklen : Bits32p1;
      Value   : Unsigned_32;
      One     : constant Unsigned_32 := 1;
   begin
      Hi       := Template.Hi;
      Lo       := Template.Lo;
      Tmp      := Unsigned_32 (Register);
      Masklen  := (Hi - Lo) + 1;
      Mask     := Shift_Left (One, Masklen) - 1;
      Value    := Valarg and Mask;
      Value    := Shift_Left (Value, Lo);
      Mask     := Shift_Left (Mask, Lo);
      Tmp      := Tmp and not Mask;
      Tmp      := Tmp or Value;
      Register := Word (Tmp);
   exception
      when Constraint_Error =>
         Register := 0;
   end Rmw;
end Accessor;
