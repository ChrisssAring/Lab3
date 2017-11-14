# If a0 equals either $a1 or $a2 set $s0 to 1. Else, 0.

# Set registers
li $a0, 1
li $a1, 4
li $a2, 1

# Call function
jal test

# Store answer in $s0
move $s0, $v0

# Call again
li $a0, 1
li $a1, 5
li $a2, 5
jal test2
move $s1, $v0

li $v0, 10
syscall

# Test function
test:
beq  $a0, $a1, If
bne  $a0, $a2, Else

If:
	addi $v0, $v0, 1
      	jr $ra
      
Else:
	addi $v0, $v0, 0
	jr $ra
