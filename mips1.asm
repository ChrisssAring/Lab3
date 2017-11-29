addi $a1, $zero, 1
addi $a2, $zero, 2
addi $a3, $zero, 3

add $s0, $a1, $a2
sub $s1, $a3, $a1

slt $s2, $a2, $a1
slt $s3, $a1, $a3
xori $s4, $a2, 113
