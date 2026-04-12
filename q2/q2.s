.data
space:      .asciz " "
newline:    .asciz "\n"
fmt:        .asciz "%d "

.text
.globl main
.extern printf
.extern atoi

main:
    addi sp, sp, -8
    sd ra, 0(sp)

    mv s0, a0              
    mv s1, a1             #a1=argv 
    addi s0, s0, -1        
    mv t0, s0

    slli t1, t0, 2         

    # allocating spce for array
    sub sp, sp, t1
    mv s2, sp

    # allocating space for result
    sub sp, sp, t1
    mv s3, sp

    # allocating space for stack
    sub sp, sp, t1
    mv s4, sp


    li t2, 0
input_loop:
    bge t2, t0, input_done

    addi t3, t2, 1
    slli t3, t3, 3
    add t4, s1, t3
    ld a0, 0(t4)

    call atoi

    slli t5, t2, 2
    add t6, s2, t5
    sw a0, 0(t6)

    addi t2, t2, 1
    j input_loop

input_done:

    addi t2, t0, -1        
    li t3, -1              

cmp_loop:
    blt t2, zero, cmp_done

while_loop:
    blt t3, zero, while_done

    slli t4, t3, 2
    add t5, s4, t4
    lw t6, 0(t5)

    slli t4, t6, 2
    add t5, s2, t4
    lw t5, 0(t5)

    slli t4, t2, 2
    add t6, s2, t4
    lw t6, 0(t6)

    ble t5, t6, pop_stack
    j while_done

pop_stack:
    addi t3, t3, -1
    j while_loop

while_done:

    blt t3, zero, no_greater

    slli t4, t2, 2
    add t5, s3, t4

    slli t6, t3, 2
    add t6, s4, t6
    lw t6, 0(t6)

    sw t6, 0(t5)
    j push_stack

no_greater:
    slli t4, t2, 2
    add t5, s3, t4
    li t6, -1
    sw t6, 0(t5)

push_stack:
    addi t3, t3, 1
    slli t4, t3, 2
    add t5, s4, t4
    sw t2, 0(t5)

    addi t2, t2, -1
    j cmp_loop

cmp_done:

    li t2, 0

print_loop:
    bge t2, t0, print_done

    slli t3, t2, 2
    add t4, s3, t3
    lw a1, 0(t4)

    la a0, fmt
    call printf

    addi t2, t2, 1
    j print_loop

print_done:
    la a0, newline
    call printf

    slli t1, s0, 2
    add sp, sp, t1
    add sp, sp, t1
    add sp, sp, t1

    ld ra, 0(sp)
    addi sp, sp, 8
    li a0, 0
    ret
