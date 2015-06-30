## -*- asm -*- ##############################################################
#                                                                           #
#                 GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                  #
#                                                                           #
#                                 S T A R T                                 #
#                                                                           #
#                               Assembly File                               #
#                                                                           #
#                      Copyright (C) 2012-2013 AdaCore                      #
#                                                                           #
#  GNAT is free software;  you can  redistribute it  and/or modify it under #
#  terms of the  GNU General Public License as published  by the Free Soft- #
#  ware  Foundation;  either version 3,  or (at your option) any later ver- #
#  sion.  GNAT is distributed in the hope that it will be useful, but WITH- #
#  OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY #
#  or FITNESS FOR A PARTICULAR PURPOSE.                                     #
#                                                                           #
#  As a special exception under Section 7 of GPL version 3, you are granted #
#  additional permissions described in the GCC Runtime Library Exception,   #
#  version 3.1, as published by the Free Software Foundation.               #
#                                                                           #
#  You should have received a copy of the GNU General Public License and    #
#  a copy of the GCC Runtime Library Exception along with this program;     #
#  see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    #
#  <http://www.gnu.org/licenses/>.                                          #
#                                                                           #
#############################################################################

	.syntax unified
	.cpu cortex-r4
	.arm
	.text
	.section .vectors,"a"
__vectors:	
	B	_start_rom  /* 1 Reset */
        ldr     PC,=__gnat_undef_trap	@ 4
        ldr     PC, SWI_Addr		@ 8
        ldr     PC, Prefetch_Addr	@ c
        ldr     PC,=__gnat_dabt_trap		@ 10
        nop                             @ Reserved vector 14
        ldr	PC,=__gnat_irq_trap
        ldr 	PC,=__gnat_fiq_trap
        
SWI_Addr:	 .word     SWI_Handler
Prefetch_Addr:	 .word     Prefetch_Handler
	
SWI_Handler:
	b	SWI_Handler
Prefetch_Handler:
	b	Prefetch_Handler
	.text
	.arm

	.globl _start_rom
_start_rom:		
	ldr	r0,=_start_rom_t
	bx	r0
	.thumb
	.thumb_func
	.globl _start_rom_t
_start_rom_t:	
	blx	_coreInitRegisters_
	blx	_coreInitStackPointer_
	/* Copy .data */
	movw	r0,#:lower16:_data_start
	movt	r0,#:upper16:_data_start
	movw	r1,#:lower16:_data_words
	movw	r2,#:lower16:_data_load
	movt	r2,#:upper16:_data_load
	cbz	r1,1f
0:	ldr	r4,[r2],#4
	str	r4,[r0],#4
	subs	r1,r1,#1
	bne	0b

1:
	/* Clear .bss */
	movw	r0,#:lower16:__bss_start
	movt	r0,#:upper16:__bss_start
	movw	r1,#:lower16:__bss_words
	mov	r2,#0
	cbz	r1,1f
0:	str	r2,[r0],#4
	subs	r1,r1,#1
	bne	0b
1:
@	mrc	p15, #0, r3, c0, c0, #0	@ get proc id
@	mov	r0,#1
@spin:		
@	cmp	r0,#0
@	bne	spin

	bl	_mpuInit_
	
	blx	rm46_init
		
	blx	main

	blx	exit

	.global __aeabi_ldiv0
	.global __aeabi_idiv0
	.global __aeabi_unwind_cpp_pr0
	.global __aeabi_unwind_cpp_pr1
	.global __aeabi_unwind_cpp_pr2
__aeabi_unwind_cpp_pr0:
__aeabi_unwind_cpp_pr1:
__aeabi_unwind_cpp_pr2:
__aeabi_ldiv0:
__aeabi_idiv0:



_mpuInit_:
        stmfd sp!, {r0}
        @ Disable mpu
        mrc   p15, #0, r0, c1, c0, #0
        bic   r0,  r0, #1
        dsb
        mcr   p15, #0, r0, c1, c0, #0
        isb
        @ Disable background region
        mrc   p15, #0, r0,      c1, c0, #0
        bic   r0,  r0, #0x20000
        mcr   p15, #0, r0,      c1, c0, #0
        @ Setup region 1
        mov   r0,  #0
        mcr   p15, #0,    r0, c6, c2, #0
        ldr   r0,  r1Base
        mcr   p15, #0,    r0, c6, c1, #0
        mov   r0,  #0x0008
        orr   r0,  r0,    #0x1000
        mcr   p15, #0,    r0, c6, c1, #4
        movw  r0,  #((1 << 15) + (1 << 14) + (1 << 13) + (1 << 12) + (1 << 11) + (1 << 10) + (1 <<  9) + (1 <<  8) + (0x1F << 1) + (1)) 
        mcr   p15, #0,    r0, c6, c1, #2
        @ Setup region 2
        mov   r0,  #1
        mcr   p15, #0,    r0, c6, c2, #0
        ldr   r0,  r2Base
        mcr   p15, #0,    r0, c6, c1, #0
        mov   r0,  #0x0002
        orr   r0,  r0,    #0x0600
        mcr   p15, #0,    r0, c6, c1, #4
        movw  r0,  #((0 << 15) + (0 << 14) + (0 << 13) + (0 << 12) + (0 << 11) + (0 << 10) + (0 <<  9) + (0 <<  8) + (0x15 << 1) + (1))
        mcr   p15, #0,    r0, c6, c1, #2
        @ Setup region  
        mov   r0,  #2
        mcr   p15, #0,    r0, c6, c2, #0
        ldr   r0,  r3Base
        mcr   p15, #0,    r0, c6, c1, #0    
        mov   r0,  #0x000B
        orr   r0,  r0,    #0x1300
        mcr   p15, #0,    r0, c6, c1, #4
        movw  r0,  #((0 << 15) + (0 << 14) + (0 << 13) + (0 << 12) + (0 << 11) + (0 << 10) + (0 <<  9) + (0 <<  8) + (0x12 << 1) + (1))
        mcr   p15, #0,    r0, c6, c1, #2
        @ Setup region 4
        mov   r0,  #3
        mcr   p15, #0,    r0, c6, c2, #0
        ldr   r0,  r4Base
        mcr   p15, #0,    r0, c6, c1, #0
        mov   r0,  #0x0010
        orr   r0,  r0,    #0x1300
        mcr   p15, #0,    r0, c6, c1, #4
        movw  r0,  #((0 << 15) + (0 << 14) + (0 << 13) + (0 << 12) + (0 << 11) + (1 << 10) + (1 <<  9) + (1 <<  8) + (0x1A << 1) + (1))
        mcr   p15, #0,    r0, c6, c1, #2
        @ Setup region 5
        mov   r0,  #4
        mcr   p15, #0,    r0, c6, c2, #0
        ldr   r0,  r5Base
        mcr   p15, #0,    r0, c6, c1, #0
        mov   r0,  #0x0000
        orr   r0,  r0,    #0x1300
        mcr   p15, #0,    r0, c6, c1, #4
        movw  r0,  #((1 << 15) + (1 << 14) + (0 << 13) + (0 << 12) + (0 << 11) + (0 << 10) + (0 <<  9) + (0 <<  8) + (0x1B << 1) + (1))
        mcr   p15, #0,    r0, c6, c1, #2
        @ Setup region 6
        mov   r0,  #5
        mcr   p15, #0,    r0, c6, c2, #0
        ldr   r0,  r6Base
        mcr   p15, #0,    r0, c6, c1, #0
        mov   r0,  #0x0006
        orr   r0,  r0,    #0x1300
        mcr   p15, #0,    r0, c6, c1, #4
        movw  r0,  #((0 << 15) + (0 << 14) + (0 << 13) + (0 << 12) + (0 << 11) + (0 << 10) + (0 <<  9) + (0 <<  8) + (0x1A << 1) + (1))
        mcr   p15, #0,    r0, c6, c1, #2
        @ Setup region 7
        mov   r0,  #6
        mcr   p15, #0,    r0, c6, c2, #0
        ldr   r0,  r7Base
        mcr   p15, #0,    r0, c6, c1, #0
        mov   r0,  #0x0002
        orr   r0,  r0,    #0x1200
        mcr   p15, #0,    r0, c6, c1, #4
        movw  r0,  #((0 << 15) + (0 << 14) + (0 << 13) + (0 << 12) + (0 << 11) + (0 << 10) + (0 <<  9) + (0 <<  8) + (0x16 << 1) + (1))
        mcr   p15, #0,    r0, c6, c1, #2
        @ Setup region 16
        mov   r0,  #15
        mcr   p15, #0,    r0, c6, c2, #0
        ldr   r0,  r16Base
        mcr   p15, #0,    r0, c6, c1, #0
        mov   r0,  #0x0010
        orr   r0,  r0,    #0x1200
        mcr   p15, #0,    r0, c6, c1, #4
        movw  r0,  #((0 << 15) + (0 << 14) + (0 << 13) + (0 << 12) + (0 << 11) + (0 << 10) + (0 <<  9) + (0 <<  8) + (0x12 << 1) + (1))
        mcr   p15, #0,    r0, c6, c1, #2

        @ Enable mpu
        mrc   p15, #0, r0, c1, c0, #0
        orr   r0,  r0, #1
        dsb
        mcr   p15, #0, r0, c1, c0, #0
        isb
        ldmfd sp!, {r0}
        bx    lr

r1Base:  .word 0x00000000  
r2Base:  .word 0x00000000  
r3Base:  .word 0x08000000  
r4Base:  .word 0xF8000000  
r5Base:  .word 0x60000000  
r6Base:  .word 0x80000000  
r7Base:  .word 0xF0000000  
r16Base:  .word 0xFFF80000  


/*-------------------------------------------------------------------------------*/
@ Enable Mpu

    .weak     _mpuEnable_
    .type     _mpuEnable_, %function	
		
_mpuEnable_:

        stmfd sp!, {r0}
        mrc   p15, #0, r0, c1, c0, #0
        orr   r0,  r0, #1
        dsb
        mcr   p15, #0, r0, c1, c0, #0
        isb
        ldmfd sp!, {r0}		
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Disable Mpu

    .weak     _mpuDisable_
    .type     _mpuDisable_, %function	
    
_mpuDisable_:

        stmfd sp!, {r0}
        mrc   p15, #0, r0, c1, c0, #0
        bic   r0,  r0, #1
        dsb
        mcr   p15, #0, r0, c1, c0, #0
        isb
        ldmfd sp!, {r0}		
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Enable Mpu background region

    .weak     _mpuEnableBackgroundRegion_
    .type     _mpuEnableBackgroundRegion_, %function	

_mpuEnableBackgroundRegion_:

        stmfd sp!, {r0}
        mrc   p15, #0, r0,      c1, c0, #0
        orr   r0,  r0, #0x20000
        mcr   p15, #0, r0,      c1, c0, #0
        ldmfd sp!, {r0}		
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Disable Mpu background region

    .weak     _mpuDisableBackgroundRegion_
    .type     _mpuDisableBackgroundRegion_, %function	
	
_mpuDisableBackgroundRegion_:

        stmfd sp!, {r0}
        mrc   p15, #0, r0,      c1, c0, #0
        bic   r0,  r0, #0x20000
        mcr   p15, #0, r0,      c1, c0, #0
        ldmfd sp!, {r0}
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Returns number of implemented Mpu regions

    .weak     _mpuGetNumberOfRegions_
    .type     _mpuGetNumberOfRegions_, %function	
	
_mpuGetNumberOfRegions_:

        mrc   p15, #0, r0,      c0, c0, #4
        uxtb  r0,  r0, ROR #8
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Returns the type of the implemented mpu regions

    .weak     _mpuAreRegionsSeparate_
    .type     _mpuAreRegionsSeparate_, %function	
	
_mpuAreRegionsSeparate_:

        mrc   p15, #0, r0,      c0, c0, #4
        uxtb  r0,  r0
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Set mpu region number

    .weak     _mpuSetRegion_
    .type     _mpuSetRegion_, %function	
	
_mpuSetRegion_:

        mcr   p15, #0, r0, c6, c2, #0
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Get mpu region number

    .weak     _mpuGetRegion_
    .type     _mpuGetRegion_, %function	
	
_mpuGetRegion_:

        mrc   p15, #0, r0, c6, c2, #0
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Set base address

    .weak     _mpuSetRegionBaseAddress_
    .type     _mpuSetRegionBaseAddress_, %function	
	
_mpuSetRegionBaseAddress_:

        mcr   p15, #0, r0, c6, c1, #0
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Get base address

    .weak     _mpuGetRegionBaseAddress_

_mpuGetRegionBaseAddress_:

        mrc   p15, #0, r0, c6, c1, #0
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Set type and permission

    .weak     _mpuSetRegionTypeAndPermission_
    .type     _mpuSetRegionTypeAndPermission_, %function	    
	
_mpuSetRegionTypeAndPermission_:

        orr   r0,  r0, r1
        mcr   p15, #0, r0, c6, c1, #4
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Get type

    .weak     _mpuGetRegionType_
    .type     _mpuGetRegionType_, %function		
    
_mpuGetRegionType_:

        mrc   p15, #0, r0,     c6, c1, #4
        bic   r0,  r0, #0xFF00
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Get permission

    .weak     _mpuGetRegionPermission_
    .type     _mpuGetRegionPermission_, %function	
    

_mpuGetRegionPermission_:

        mrc   p15, #0, r0,   c6, c1, #4
        bic   r0,  r0, #0xFF
        bx    lr

/*-------------------------------------------------------------------------------*/
@ Set region size register value

    .weak     _mpuSetRegionSizeRegister_
    .type     _mpuSetRegionSizeRegister_, %function	
	
_mpuSetRegionSizeRegister_:

        mcr   p15, #0, r0, c6, c1, #2
        bx    lr

/*-------------------------------------------------------------------------------*/
	
@-------------------------------------------------------------------------------
@ Initialize CPU Registers
@ SourceId : CORE_SourceId_001
@ DesignId : CORE_DesignId_001
@ Requirements: HL_SR477, HL_SR476, HL_SR492
	.arm
	.globl     _coreInitRegisters_
_coreInitRegisters_:	

    @ After reset, the CPU is in the Supervisor mode (M = 10011)
        mov r0, lr
        mov r1, #0x0000
        mov r2, #0x0000
        mov r3, #0x0000
        mov r4, #0x0000
        mov r5, #0x0000
        mov r6, #0x0000
        mov r7, #0x0000
        mov r8, #0x0000
        mov r9, #0x0000
        mov r10, #0x0000
        mov r11, #0x0000
        mov r12, #0x0000
        mov r13, #0x0000
        mrs r1, cpsr
        msr spsr_cxsf, r1 
        @ Switch to FIQ mode (M = 10001)
        cps #17
        mov lr, r0
        mov r8, #0x0000
        mov r9, #0x0000
        mov r10, #0x0000
        mov r11, #0x0000
        mov r12, #0x0000
        mrs r1, cpsr
        msr spsr_cxsf, r1 
        @ Switch to IRQ mode (M = 10010)
        cps #18
        mov lr, r0
        mrs r1,cpsr
        msr spsr_cxsf, r1         
        @ Switch to Abort mode (M = 10111)
        cps #23
        mov lr, r0
        mrs r1,cpsr
        msr spsr_cxsf, r1         
        @ Switch to Undefined Instruction Mode (M = 11011)
        cps #27
        mov lr, r0
        mrs r1,cpsr
        msr spsr_cxsf, r1         
        @ Switch to System Mode ( Shares User Mode registers ) (M = 11111)
        cps #31
        mov lr, r0
        mrs r1,cpsr
        msr spsr_cxsf, r1         


        mrc   p15,#0x00,r2,c1,c0,#0x02
        orr   r2,r2,#0xF00000
        mcr   p15,#0x00,r2,c1,c0,#0x02
        mov   r2,#0x40000000
        fmxr  fpexc,r2

        fmdrr d0,         r1,     r1
        fmdrr d1,         r1,     r1
        fmdrr d2,         r1,     r1
        fmdrr d3,         r1,     r1
        fmdrr d4,         r1,     r1
        fmdrr d5,         r1,     r1
        fmdrr d6,         r1,     r1
        fmdrr d7,         r1,     r1
        fmdrr d8,         r1,     r1
        fmdrr d9,         r1,     r1
        fmdrr d10,        r1,     r1
        fmdrr d11,        r1,     r1
        fmdrr d12,        r1,     r1
        fmdrr d13,        r1,     r1
        fmdrr d14,        r1,     r1
        fmdrr d15,        r1,     r1
        bl    next1
next1:	
        bl    next2
next2:	
        bl    next3
next3:	
        bl    next4
next4:	
        bx    r0

	.globl _coreInitStackPointer_
_coreInitStackPointer_:	
        cps   #17
        ldr   sp,       fiqSp
        cps   #18
        ldr   sp,       irqSp
        cps   #19
        ldr   sp,       svcSp
        cps   #23
        ldr   sp,       abortSp
        cps   #27
        ldr   sp,       undefSp
        cps   #31
        ldr   sp,       userSp
        bx    lr

userSp:	  .word __stack_end-0x00000100-0x00000100-0x00000100-0x00000100-0x00000100
svcSp:	  .word __stack_end-0x00000100-0x00000100-0x00000100-0x00000100
fiqSp:	  .word __stack_end-0x00000100-0x00000100-0x00000100
irqSp:	  .word __stack_end-0x00000100-0x00000100
abortSp:  .word __stack_end-0x00000100
undefSp:  .word __stack_end

.weak __gnat_irq_trap
.type __gnat_irq_trap, %function
__gnat_irq_trap:
0:	b	0b
	.size __gnat_irq_trap, . - __gnat_irq_trap

.weak __gnat_fiq_trap
.type __gnat_fiq_trap, %function
__gnat_fiq_trap:
0:	b	0b
	.size __gnat_fiq_trap, . - __gnat_fiq_trap

.weak __gnat_undef_trap
.type __gnat_undef_trap, %function
__gnat_undef_trap:
0:	b	0b
	.size __gnat_undef_trap, . - __gnat_undef_trap

.weak __gnat_dabt_trap
.type __gnat_dabt_trap, %function
__gnat_dabt_trap:
0:	b	0b
	.size __gnat_dabt_trap, . - __gnat_dabt_trap
