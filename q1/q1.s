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
