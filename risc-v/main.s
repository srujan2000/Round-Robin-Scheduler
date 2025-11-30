.section .text,"ax"
.globl main

.section .text
.type main, %function
main:
  li   t0, 0x1802 # interrupt enable and previous privilege mode as m-mode
  csrs mstatus, t0
  li   t0, 0x80   # timer interrupt enable
  csrs mie, t0
  la   t0, interrupt_handler #load interrupt handler address in mtvec
  csrw  mtvec, t0 
  li    t0, 0x4000 # set mtime to 0x10000000
  li    t1, 0x80000000
  add   sp, t0,t1  #setting up stack pointer
  li    t0, 5000000
  li    t1, 0x2004000  #mtimecmp address
  sw    t0, 0(t1)

.section .text
.type interrupt_handler, %function
interrupt_handler:
    sw ra, 0(sp)
    sw sp, 4(sp)
    sw gp, 8(sp)
    sw tp, 12(sp)
    sw t0, 16(sp)
    sw t1, 20(sp)
    sw t2, 24(sp)
    sw s0, 28(sp)
    sw s1, 32(sp)
    sw a1, 36(sp)
    sw a2, 40(sp)
    sw a3, 44(sp)
    sw a4, 48(sp)
    sw a5, 52(sp)
    sw a6, 56(sp)
    sw a7, 60(sp)
    sw s2, 64(sp)
    sw s3, 68(sp)
    sw s4, 72(sp)
    sw s5, 76(sp)
    sw s6, 80(sp)
    sw s7, 84(sp)
    sw s8, 88(sp)
    sw s9, 92(sp)
    sw s10, 96(sp)
    sw s11, 100(sp)
    sw t3, 104(sp)
    sw t4, 108(sp)
    sw t5, 112(sp)
    sw t6, 116(sp)


    lw ra, 0(sp)
    lw gp, 8(sp)
    lw tp, 12(sp)
    lw t0, 16(sp)
    lw t1, 20(sp)
    lw t2, 24(sp)
    lw s0, 28(sp)
    lw s1, 32(sp)
    lw a1, 36(sp)
    lw a2, 40(sp)
    lw a3, 44(sp)
    lw a4, 48(sp)
    lw a5, 52(sp)
    lw a6, 56(sp)
    lw a7, 60(sp)
    lw s2, 64(sp)
    lw s3, 68(sp)
    lw s4, 72(sp)
    lw s5, 76(sp)
    lw s6, 80(sp)
    lw s7, 84(sp)
    lw s8, 88(sp)
    lw s9, 92(sp)
    lw s10, 96(sp)
    lw s11, 100(sp)
    lw t3, 104(sp)
    lw t4, 108(sp)
    lw t5, 112(sp)
    lw t6, 116(sp)
    /* restore sp last to avoid changing base mid-restores */
    lw sp, 4(sp)

    #push to the stack
    #pop the the stack
    #copy pc to mepc
    ret

.section .text
task1:
    addi a0,a0,1
    j task1

.section .data
.align 4
stack1:
    .word task1
    .word stack1
    .word 0x02
    .word 0x03
    .word 0x04
    .word 0x05
    .word 0x06
    .word 0x07
    .word 0x08
    .word 0x09
    .word 0x0a
    .word 0x0b
    .word 0x0c
    .word 0x0d
    .word 0x0e
    .word 0x0f
    .word 0x10
    .word 0x11
    .word 0x12
    .word 0x13
    .word 0x14
    .word 0x15
    .word 0x16
    .word 0x17
    .word 0x18
    .word 0x19
    .word 0x1a
    .word 0x1b
    .word 0x1c
    .word 0x1d
    .word 0x1e
    .word 0x1f


