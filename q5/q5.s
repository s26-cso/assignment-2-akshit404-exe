.section .data
filename:   .asciz "input.txt"
yes_msg:    .asciz "Yes\n"
no_msg:     .asciz "No\n"

.section .text
.globl main
.extern printf

main:
    addi sp,sp,-16
    sd ra,8(sp)

    li a7,56 
    li a0, -100             
    la a1,filename
    li a2,0
    li a3,0
    ecall
    mv s0,a0              

    li a7, 62              
    mv a0, s0
    li a1, 0
    li a2, 2               
    ecall
    mv s1, a0              

    li t0, 0               
    addi t1, s1, -1        

loop:
    bge t0, t1, palindrome

    li a7, 62              
    mv a0, s0
    mv a1, t0
    li a2, 0               
    ecall

    li a7, 63              
    mv a0, s0
    mv a1, sp              
    li a2, 1
    ecall

    li a7, 62              
    mv a0, s0
    mv a1, t1
    li a2, 0
    ecall

    li a7, 63              
    mv a0, s0
    addi a1, sp, 1         
    li a2, 1
    ecall

    lb t2, 0(sp)
    lb t3, 1(sp)

    bne t2, t3, not_palindrome

    addi t0, t0, 1
    addi t1, t1, -1
    j loop

palindrome:
    la a0, yes_msg
    call printf
    j exit

not_palindrome:
    la a0, no_msg
    call printf

exit:
    li a7,57
    mv a0,s0
    ecall
    ld ra,8(sp)
    addi sp,sp,16
    ret
