.section .text,"ax"
.globl main

.section .text
.type main, %function
main:
  li   t0, 0x1802 # interrupt enable and previous privilege mode as m-mode
  csrs mstatus, t0
  li   t0, 0x80   # timer interrupt enable
  csrs mie, t0
  la      t0, interrupt_handler #load interrupt handler address in mtvec
  csrw    mtvec, t0 
  li   t1, 0x80000000
  add  sp, t0,t1  #setting up stack pointer
  li      t0, 5000000
  li      t1, 0x2004000  #mtimecmp address
  sw      t0, 0(t1)

.section .text
.type interrupt_handler, %function
interrupt_handler:
    addi s1, s1,1  # timer interrupt enabled
    csrr t2, mcause

    #push to the stack
    #pop the the stack
    #copy pc to mepc
    mret


