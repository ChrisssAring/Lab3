li $a0, 1
li $a1, 4
li $a2, 1
jal test
move $s0, $v0

li $a0, 1
li $a1, 5
li $a2, 5
jal test2
move $s1, $v0

li $v0, 10
syscall

test:
beq  $a0, $a1, If
bne  $a0, $a2, Else

If:
	addi $v0, $v0, 1
      	jr $ra
      
Else:
	addi $v0, $v0, 0
	jr $ra
