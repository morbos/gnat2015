pragma Ada_95;
pragma Restrictions (No_Exception_Propagation);
package Init is
   procedure Rm57_Init;
   pragma Export (C, Rm57_Init, "rm57_init");
end Init;
