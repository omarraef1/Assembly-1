
.text


.globl studentMain
studentMain:
	addiu 	$sp, $sp, -24	# allocate stack space -- default of 24 here
	sw 	$fp, 0($sp) 	# save caller's frame pointer
	sw 	$ra, 4($sp) 	# save return address
	addiu 	$fp, $sp, 20 	# setup main's frame pointer
	
	
	la $s0, alpha		# s0 = &alpha
	lw $s0, 0($s0)		# s0 = alpha
	
	la $s1, bravo 		# s1 = &bravo
	lw $s1, 0($s1) 		# s1 = bravo
	
	la $s2, charlie		# s2 = &charlie
	lw $s2, 0($s2) 		# s2 = charlie
	
	la $s3, delta 		# s3 = &delta
	lw $s3, 0($s3)		# s3 = delta

	la $s4, sort 		# s4 = &sort
	lw $s4, 0($s4)		# s4 = sort
	
	la $s5, compare		# s5 = &compare
	lw $s5, 0($s5)		# s5 = compare
	
	la $s6, swap 		# s6 = &swap
	lw $s6, 0($s6)		# s6 = swap
	
	la $s7, print		# s7 = &print	
	lw $s7, 0($s7)		# s7 = print
	
	
	addi $t0, $zero, 1	# $t0 = 1
	
	beq $s4, $zero, ELSE	# if sort != 1
	
.data
textSort: .asciiz "Sort Results: "
space: .asciiz " "
newL: .asciiz "\n"

.text	

	add $t1, $zero, $s0	# val1 = alpha
	add $t2, $zero, $s1 	# val2 = bravo
	add $t3, $zero, $s2	# val3 = charlie
	add $t4, $zero, $s3	# val4 = delta
	
	addi $t5, $zero, 1
	addi $t6, $zero, 1
	
	LOOP:	bne $t5, $t6, EXIT
		
			slt $t8, $t2, $t1
			bne $t8, $t5, Later
		
			add $t7, $zero, $t1
			add $t1, $zero, $t2
			add $t2, $zero, $t7 	# val2 = tmp
			
			j LOOP
		
		Later:				# else if #1
			slt $t8, $t3, $t2
			bne $t8, $t5, LaterTwo
			
			sub $t7, $t7, $t7
			add $t7, $zero, $t2
			add $t2, $zero, $t3
			add $t3, $zero, $t7 	# val3 = tmp
			
			j LOOP
			
		LaterTwo:
		
			slt $t8, $t4, $t3
			bne $t8, $t5, LaterThree
			
			sub $t7, $t7, $t7
			add $t7, $zero, $t3
			add $t3, $zero, $t4
			add $t4, $zero, $t7 	# val4 = tmp
			
			j LOOP
			
		LaterThree:
			j EXIT
		
		
	EXIT:
	# print here!!!!
	
	addi $v0, $zero, 4
	la $a0, textSort
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, space
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t2
	syscall
	
	addi $v0, $zero, 4
	la $a0, space
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t3
	syscall
	
	addi $v0, $zero, 4
	la $a0, space
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t4
	syscall
	
	addi $v0, $zero, 4
	la $a0, newL
	syscall
	
	# compare
ELSE: 
	
.data
less: 
	.asciiz "LESS\n"
same:
	.asciiz "SAME\n"
more: 
	.asciiz "MORE\n"
	
	
.text
	addi $t0, $zero, 1
	
	beq $s5, $zero, ELSETwo
	
		slt $t8, $s1, $s2
	
		bne $t8, $t0, ElseIn
		
		addi $v0, $zero, 4
		la $a0, less
		syscall
		# print "LESS"
		# print new line
		ElseIn:
		
		bne $s1, $s2, ElseInTwo
		
		addi $v0, $zero, 4
		la $a0, same
		syscall
		# print "SAME"
		# print new line
		
		ElseInTwo:
		
		slt $t8, $s2, $s1
		
		bne $t8, $t0, ElseInThree
		
		addi $v0, $zero, 4
		la $a0, more
		syscall
		# print "MORE"
		# print new line
		
		ElseInThree:
		
		j ELSETwo
		
	
	ELSETwo:

	
	#addi $t0, $zero, 1
	
	beq $s6, $zero, elseGO
	
	# swap task
	
	add $t8, $zero, $s0 	# s0 alpha s1 bravo s2 charlie s3 delta
	add $t0, $zero, $s1
	add $t1, $zero, $t8
	la $s0, alpha
	sw $t0, 0($s0)
	la $s1, bravo
	sw $t1, 0($s1)
	
	
	add $t9, $zero, $s2
	add $t2, $zero, $s3
	add $t3, $zero, $t9
	la $s2, charlie
	sw $t2, 0($s2)
	la $s3, delta
	sw $t3, 0($s3)
	
		
elseGO:
	# Print task
.data
ourValues: .asciiz "Cur Values: "
newLine: .asciiz "\n"
spaceX: .asciiz " "

.text
	
	#addi $t0, $zero, 1
	beq $s7, $zero, DONE
	
	la $t0, alpha		# s0 = &alpha
	lw $t0, 0($t0)		# s0 = alpha

	la $t1, bravo 		# s1 = &bravo
	lw $t1, 0($t1) 		# s1 = bravo
	
	la $t2, charlie		# s2 = &charlie
	lw $t2, 0($t2) 		# s2 = charlie
	
	la $t3, delta 		# s3 = &delta
	lw $t3, 0($t3)		# s3 = delta
	
	addi $v0, $zero, 4
	la $a0, ourValues
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t0
	syscall
	
	addi $v0, $zero, 4
	la $a0, spaceX
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 4
	la $a0, spaceX
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t2
	syscall
	
	addi $v0, $zero, 4
	la $a0, spaceX
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t3
	syscall
	
	addi $v0, $zero, 4
	la $a0, newLine
	syscall
	
DONE: 	# Epilogue for main -- restore stack frame pointer and return
	lw 	$ra, 4($sp) 	# get return address from stack
	lw 	$fp, 0($sp)	# restore the caller's frame pointer
	addiu 	$sp, $sp, 24 	# restore the caller's stack pointer
	jr 	$ra 		# return to caller's code
