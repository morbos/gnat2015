pragma Warnings (Off);
with System.RM57; use System.RM57;
pragma Warnings (On);
package Sys.Flash is
   pragma Preelaborate;

--   Flash_Wrapper_Base   : constant := System_Modules + 16#0_7000#;

   type Rsvd_Flash2 is array (1 .. 2) of Word;
   type Rsvd_Flash7 is array (1 .. 13) of Word;
   type Rsvd_Flash9 is array (1 .. 3) of Word;
   type Rsvd_Flash10 is array (1 .. 108) of Word;
   type Rsvd_Flash11 is array (1 .. 11) of Word;
   type Rsvd_Flash13 is array (1 .. 78) of Word;

   type Flash_Registers is record
      FRDCNTL           : Word; -- Flash Read Control Register 00h
      RESERVED1         : Word; -- 04h
      EE_FEDACCTRL1     : Word; -- EEPROM Error Correction Control Register 1 08h
      Reserved2         : Rsvd_Flash2;
      FEDAC_PASTATUS    : Word; -- Flash PortA Error and Status Register 14h
      FEDAC_PBSTATUS    : Word; -- Flash PortB Error and Status Register 18h
      FEDAC_GBLSTATUS   : Word; -- Flash Global Error and Status Register 1Ch
      RESERVED3         : Word; -- 20h
      FEDACSDIS         : Word; -- Flash Error Detection and Correction Sector Disable Register 24h
      FPRIM_ADD_TAG     : Word; -- Flash Primary Address Tag Register 28h
      FDUP_ADD_TAG      : Word; -- Flash Duplicate Address Tag Register 2Ch
      FBPROT            : Word; -- Flash Bank Protection Register 30h
      FBSE              : Word; -- Flash Bank Sector Enable Register 34h
      FBBUSY            : Word; -- Flash Bank Busy Register 38h
      FBAC              : Word; -- Flash Bank Access Control Register 3Ch
      FBPWRMODE         : Word; -- Flash Bank Power Mode Register 40h
      FBPRDY            : Word; -- Bank/Pump Ready Register 44h
      FPAC1             : Word; -- Flash Pump Access Control Register 1 48h
      RESERVED4         : Word; -- 4Ch
      FMAC              : Word; -- Flash Module Access Control Register 50h
      FMSTAT            : Word; -- Flash Module Status Register 54h
      FEMU_DMSW         : Word; -- EEPROM Emulation Data MSW Register 58h
      FEMU_DLSW         : Word; -- EEPROM Emulation Data LSW Register 5Ch
      FEMU_ECC          : Word; -- EEPROM Emulation Address Register 60h
      FLOCK             : Word; -- Flash Lock Register 64h
      FDIAGCTRL         : Word; -- Diagnostic Control Register 6Ch
      RESERVED5         : Word; -- 70h
      FRAW_ADDR         : Word; -- Raw Address 74h
      RESERVED6         : Word; -- 78h
      FPAR_OVR          : Word; -- Parity Override Register 7Ch
      Reserved7         : Rsvd_Flash7;
      RCR_VALID         : Word; -- Reset Configuration Valid Register B4h
      ACC_THRESHOLD     : Word; -- Crossbar Access Time Threshold Register B8h
      RESERVED8         : Word; -- BCh
      FEDACSDIS2        : Word; -- Flash Error Detection and Correction Sector Disable Register 2 C0h
      Reserved9         : Rsvd_Flash9;
      RCR_VALUE0        : Word; -- Lower Word of the Reset Configuration Read Register D0h
      RCR_VALUE1        : Word; -- Upper Word of the Reset Configuration Read Register D4h
      Reserved10        : Rsvd_Flash10;
      FSM_WR_ENA        : Word; -- FSM Register Write Enable Register 288h
      Reserved11        : Rsvd_Flash11;
      EEPROM_CONFIG     : Word; -- EEPROM Emulation Configuration Register 2B8h
      RESERVED12        : Word; -- 2BCh
      FSM_SECTOR1       : Word; -- FSM Sector Register 1 2C0h
      FSM_SECTOR2       : Word; -- FSM Sector Register 2 2C4h
      Reserved13        : Rsvd_Flash13;
      FCFG_BANK         : Word; -- Flash Bank Configuration Register 400h
   end record;

   FLASH : Flash_Registers with Volatile, Address
     => System'To_Address (Flash_Wrapper_Base);

   procedure Flash_Init;

end Sys.Flash;
