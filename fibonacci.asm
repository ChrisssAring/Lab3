main:

li $a0, 6
jal fib
move $s0, $v0

# End
li $v0, 10
syscall

fib:
beq $a0, 0, zero
beq $a0, 1 , one

sub $sp, $sp, 4
sw $ra, 0($sp)

add $a0, $a0, -1
jal fib
add $a0, $a0, 1

lw $ra, 0($sp)
add $sp, $sp, 4
add $sp, $sp, -4
sw $v0, 0($sp)

add $sp, $sp, -4
sw $ra, 0($sp)

add $a0, $a0, -2
jal fib
add $a0, $a0, 2

lw $ra, 0($sp)
add $sp, $sp, 4

lw $s0, 0($sp)
add $sp, $sp, 4

add $v0, $v0, $s0
jr $ra

zero:
li $v0, 0
jr $ra

one:
li $v0, 1
jr $ra
