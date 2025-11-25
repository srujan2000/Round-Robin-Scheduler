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
    addi s1, s1,1  # timer interrupt enabled
    csrr t2, mcause
    
    addi t0,t0,4
    addi t1,t1,8
    addi t2,t2,12
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    
    add t0,x0,x0
    add t1,x0,x0
    add t2,x0,x0

    lw t0,0(sp)
    lw t1,4(sp)
    lw t2,8(sp)
    

    #push to the stack
    #pop the the stack
    #copy pc to mepc
    mret


task1:
    addi a0,a0,1
    j task1
