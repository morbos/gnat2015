             gnat2015 for Hercules RM46 and RM57
             -----------------------------------

0) This tree contains the gnat2015 full and sfp ravenscar libs ported
to the Hercules RM46 and RM57 processors.

1) The code is specifically targeted to the 2 launchpad boards for
both the devices.

2) For each devices, there is an example that has 2 tasks that each
toggle and LED and an overall loop that prints at 115200 8N1 to the
LIN1 UART port.

3) To build this, first go to libre.adacore.com and DL gnat2015 tools
for ARM (choose your host, Windows or Linux).

4) Add the bin dir to your path.

5) Build the lib of interest: (example here is rm57, similar for rm46)

% cd gnat2015/ravenscar-full-rm57
% gprbuild

If all is well, you will have a library.

For the sfp lib the build is as so:

% cd gnat2015/ravenscar-sfp-rm57
% gprbuild ravenscar_build.gpr

6) Build an example (example here is rm57, similar for rm46)

% cd gnat2015/hercules/RM57/example
% make

There will be a demo.out in the obj dir that UniFlash can program.

7) Connect a UART and observe the output (also the LEDs will be
toggling).

8) GDB and beyond.

If you want to source level debug, 
a) acquire a pod, I use a JLINK clone for $10-$15 on ebay. 
b) DL openocd 0.9 

c) prepare your board for JTAG debug. You will need a Samtec
connector soldered down:

ftr-110-51-s-d-06

d) A JTAG adaper is needed. JLINK official sells these, they
convert ARM20 to CTI-20.

https://www.segger.com/jlink-adapters.html#TI20

e) DL openocd 0.9

f) Use the openocd target and board files provided.

g) You should be able to start openocd and see the target

openocd --file ti_rm57launchpad.cfg

root@bplus:~/openocd-0.9.0/tcl# ../src/openocd --file

board/ti_rm57launchpad.cfg

Open On-Chip Debugger 0.9.0 (2015-05-31-20:38)

Licensed under GNU GPL v2

For bug reports, read

        http://openocd.org/doc/doxygen/bugs.html

adapter speed: 1000 kHz

adapter speed: 1000 kHz

Info : auto-selecting first available session transport "jtag". To

override use       'transport select <transport>'.

Warn : rm57.dap: nonstandard IR mask

force hard breakpoints

trst_only separate trst_push_pull

Info : J-Link ARM V8 compiled Dec  6 2011 18:57:44

Info : J-Link caps 0xb9ff7bbf

Info : J-Link hw version 80000

Info : J-Link hw type J-Link

Info : J-Link max mem block 9440

Info : J-Link configuration

Info : USB-Address: 0x0

Info : Kickstart power on JTAG-pin 19: 0xffffffff

Info : Vref = 3.384 TCK = 1 TDI = 0 TDO = 0 TMS = 0 SRST = 1 TRST =
1

Info : J-Link JTAG Interface ready

Info : clock speed 1000 kHz

Info : JTAG tap: rm57.jrc tap/device found: 0x0b95a02f (mfg: 0x017,

part: 0xb95a      , ver: 0x0)

Info : JTAG tap: rm57.dap enabled

Info : rm57.cpu: hardware has 8 breakpoints, 8 watchpoints




