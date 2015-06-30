pragma Ada_95;
pragma Restrictions (No_Exception_Propagation);
package Init is
   procedure Rm46_Init;
   pragma Export (C, Rm46_Init, "rm46_init");
end Init;
