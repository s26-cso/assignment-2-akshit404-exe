<<<<<<< HEAD
.global make_node
.global insert
.global get
.global getAtMost

make_node:
    addi sp,sp,-16
    sd ra, 8(sp)
    sw a0, 0(sp)

    li a0, 24
    call malloc

    ld t0, 0(sp)
    sw t0, 0(a0)
    sd zero, 8(a0)
    sd zero, 16(a0)

    ld ra, 8(sp)
    addi sp,sp,16
    ret

insert:
    addi sp,sp,-16
    sd  ra, 8(sp)
    sd  a0, 0(sp)
    beq zero,  a0, insert_create

    lw t0, 0(a0)
    blt a1, t0, insert_left

insert_right:
    ld t1, 16(a0)
    mv a0, t1
    jal insert

    ld t2, 0(sp)
    sd a0, 16(t2)
    mv a0,t2

    ld ra, 8(sp)
    addi sp,sp,16
    ret

insert_left:
    ld t1, 8(a0)
    mv a0, t1
    jal insert

    ld t2, 0(sp)
    sd a0, 8(t2)
    mv a0,t2

    ld ra, 8(sp)
    addi sp,sp,16
    ret

insert_create:
    mv a0, a1
    jal make_node

    ld ra, 8(sp)
    addi sp, sp, 16
    ret

get:
    addi sp, sp, -16
    sd ra, 8(sp)

    beq a0, zero, give_null

    lw t0, 0(a0)
    beq t0, a1, found
    blt t0, a1, go_right
    ld a0, 8(a0)
    jal get

    ld ra, 8(sp)
    addi sp, sp, 16
    ret

go_right:
    ld a0, 16(a0)
    jal get

    ld ra, 8(sp)
    addi sp, sp, 16
    ret

found:
    ld ra, 8(sp)
    addi sp,sp,16
    ret
give_null:
    mv a0,zero
    ld ra, 8(sp)
    addi sp,sp,16
    ret

getAtMost:
    li t0, -1

loop:
    beq a1, zero, done
    lw t1, 0(a1)
    ble t1, a0, possible
    ld a1, 8(a1)
    j loop

possible:
    mv t0, t1
    ld a1, 16(a1)
    j loop
done:
    mv a0, t0
    ret
=======
.global make_node
.global insert
.global get
.global getAtMost
make_node:
    addi sp,sp,-16
    sd ra, 8(sp)
    sw a0, 4(sp)

    li a0, 24
    call malloc

    lw t0, 4(sp)
    sw t0, 0(a0)

    addi t0, x0, 0
    sd t0, 8(a0)
    sd t0, 16(a0)

    ld ra, 8(sp)
    addi sp, sp, 16
    ret



insert:
    addi sp, sp, -24
    sd ra, 16(sp)
    sd a0, 8(sp)      
    sw a1, 4(sp) 
    beq zero, a0, create_node

    lw t0, 0(a0)

    blt a1, t0, left

    ld t1, 16(a0)
    mv a0, t1
    lw a1, 4(sp)
    call insert
    ld t2, 8(sp)
    sd a0, 16(t2)     
    mv a0, t2
    j done

left:
    ld t1, 8(a0)
    mv a0, t1
    lw a1, 4(sp)
    call insert
    ld t2, 8(sp)
    sd a0, 8(t2)     
    mv a0, t2
    j done

create_node:
    lw a0, 4(sp)
    call make_node

done:
    ld ra, 16(sp)
    addi sp, sp, 24
    ret



get:
    beq zero,a0, not_found

loop:
    lw t0, 0(a0)

    beq t0, a1, found 
    blt t0, a1, right 
    ld a0, 8(a0)
    beq a0, zero, not_found
    j loop
right:
    ld a0, 16(a0)
    beq a0, zero, not_found
    j loop
found:
    ret
not_found:
    li a0, 0
    ret



getAtMost:
    li t0, -1          

loop2:
    beq a1, zero, done_most

    lw t1, 0(a1)

    blt a0, t1, go_left

    mv t0, t1
    ld a1, 16(a1)      
    j loop2

go_left:
    ld a1, 8(a1)
    j loop2

done_most:
    mv a0, t0
    ret
>>>>>>> 5cbfd74c150ad8cdcb4d86e7feb872b9aa1a1482
