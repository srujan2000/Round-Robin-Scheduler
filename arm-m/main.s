.global Reset_Handler

.equ SYST_CSR,0xE000E010
.equ SYST_RVR,0xE000E014
.equ SYST_CVR,0xE000E018
.equ SYST_CALIB,0xE000E01C
.equ TIME_OUT, 0x00FFFFFF

.section .isr_vector
vector_table:
    .word 0x20001000
    .word Reset_Handler
.org 0x3C
    .word Systick_Handler
    .zero 253
    .align 1

.section .text
.type Reset_Handler, %function
Reset_Handler:
    # mov r1, #7
    # mov r2, #3
    # mov r3, #4
    # push {r1,r2,r3}
    # mov r1, #1
    # mov r2, #2
    # mov r3, #3
    # pop {r1,r2,r3}

    ldr r0, =SYST_CSR
    ldr r1, =SYST_RVR
    ldr r2, =SYST_CVR   
    ldr r3, =TIME_OUT

    str  r3, [r1]       
    mov r3,#0
    str r3, [r2]         
    mov r3,#7
    str r3, [r0] 
    bl .

.section .text
.type Systick_Handler, %function
Systick_Handler:
    push {r4-r7}

    mov r0,r8
    mov r1,r9
    mov r2,r10
    mov r3,r11

    push {r0-r3}
magic:
    ldr r4, =current_task
    ldr r5, [r4]
    add r6,r5,#4
    ldr r5,[r5]
    mov sp,r5
    ldr r6,[r6]
    ldr r0, =current_task
    str r6, [r0]
    pop {r0-r3}
    mov r8,r0
    mov r9,r1
    mov r10,r2
    mov r11,r3

    pop {r4-r7}

    bx lr

.section .text
.p2align 4
.type main1, %function
.global main1
main1:
    nop 
    add r1, r1, #1
    b main1

.section .text
.p2align 4
.type main2, %function
.global main2
main2:
    nop 
    add r2, r2, #2
    b main2

.section .text
.p2align 4
.type main3, %function
.global main3
main3:
    nop 
    add r3, r3, #3
    b main3

.section .data
    .align 4
stack_1:
    .word 0x18
    .word 0x19
    .word 0x1a
    .word 0x1b
    .word 0x14
    .word 0x15
    .word 0x16
    .word 0x17
    .word 0x10
    .word 0x11
    .word 0x12
    .word 0x13
    .word 0x1c
    .word 0x309
    .word main1
    .word 0x01000000
    .zero 64
    .align 4

.section .data
stack_2:
    .word 0x28
    .word 0x29
    .word 0x2a
    .word 0x2b
    .word 0x24
    .word 0x25
    .word 0x26
    .word 0x27
    .word 0x20
    .word 0x21
    .word 0x22
    .word 0x23
    .word 0x2c
    .word 0x309
    .word main2
    .word 0x01000000
    .zero 64
    .align 4

.section .data
stack_3:
    .word 0x38
    .word 0x39
    .word 0x3a
    .word 0x3b
    .word 0x34
    .word 0x35
    .word 0x36
    .word 0x37
    .word 0x30
    .word 0x31
    .word 0x32
    .word 0x33
    .word 0x3c
    .word 0x309
    .word main3
    .word 0x01000000
    .zero 100

.section .stackloc
stack_loc:
.word 0x20000000 
.word .+0x04
.word 0x20000080
.word . + 0x04
.word 0x20000100
.word stack_loc

current_task:
.word stack_loc

