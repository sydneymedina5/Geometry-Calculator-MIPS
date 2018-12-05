.data
prompt1:	.asciiz		"  	1) Vectors	2) 2D Area	3) 3D Volume of a cube or rectangular prisim "
prompt2:	.asciiz		"1) Dot Product	2) Cross Product "
prompt4:	.asciiz		"How many vertices would you like to enter? "
prompt5:	.asciiz		"You may only enter three edges for volume "
prompt6:	.asciiz		"Put the x-value then y-value then z-value with enters in between, if you would like a 2D vector leave z = 0"
prompt7:	.asciiz		"in clockwise or counter clockwise order, x-value first then y-value with enters in between"
prompt8:	.asciiz		"These are the determinates"
prompt9:	.asciiz		"The area using only vertices is "
prompt11:	.asciiz		"Put x-value then y-value then z-value with enters in between"
prompt12:	.asciiz		"The volume is "
prompt13:	.asciiz		"integer not in range"
prompt14:	.asciiz		"You can only enter 2 vectors"
prompt15:	.asciiz		"The dot product is "
prompt16:	.asciiz		"The cross product is ( "
comma:		.asciiz		", "
pare:		.asciiz		")"
par:		.asciiz		"("
buffer:		.word		0
buff2:		.word		0
vert:		.word		0
firx:		.word		0
firy:		.word		0
firz:		.word		0
secx:		.word		0
secy:		.word		0
secz:		.word		0
jumptable:	.word		L1, L2, L3
jump2:		.word		L4, L5
.align 2
vectArr:	.space		24
.align 2
vertArr:	.space		100
.align 2
volArr:		.space		36
.align 2
detArr:		.space 		100
floatValue:	.float		0.5

.text

main:

menu:
#New line
li 	$v0, 11
la 	$a0, 10
syscall 
		
# Prints menu
li 	$v0, 4
la 	$a0, prompt1
syscall

# Reads in integer
li 	$v0, 5
syscall
sw 	$v0, buffer

beq 	$v0, -1, Exit
blt	$v0, -1, menu
bgt	$v0, 3, menu


# Information for the switch statement
li 	$t2, 4 
la	$t4, jumptable 		#base address for the jump table

# Switch Statement
slt 	$t3,$v0,$zero 		# if buffer<0
bne 	$t3,$zero,Exit 		# Exit if buffer<0
slt 	$t3,$v0,$t2 		# if buffer<4
beq 	$t3,$zero,Exit 		# Exit if buffer>=4
beq 	$v0, 1, L1
beq 	$v0, 2, L2
beq 	$v0, 3, L3
j Exit

# Vectors
L1: 
	#Prints second menu
	li 	$v0, 4
	la 	$a0, prompt2
	syscall

	# Reads in integer
	li 	$v0, 5
	syscall
	sw 	$v0, buff2
	
	#another switch statement
	li 	$t5, 3
	la 	$t6, jump2 	#base address for the jump table
	
	slt 	$t3,$v0,$zero 	# if buffer<0
	bne 	$t3,$zero,End 	# Exit if buffer<0
	slt 	$t3,$v0,$t5	# if buffer<4
	beq 	$t3,$zero,End 	# Exit if buffer>=4
	beq 	$v0, 1, L4
	beq 	$v0, 2, L5

	j End
	
		#Dot Product
		L4:
		#Telling user they can only enter 2 vectors
		li 	$v0, 4
		la 	$a0, prompt14
		syscall
		
		#New line
		li 	$v0, 11
		la 	$a0, 10
		syscall 
		
		#Telling user how to enter vectors
		li 	$v0, 4
		la 	$a0, prompt6
		syscall
		
		#New line
		li	 $v0, 11
		la 	$a0, 10
		syscall 
		
		la 	$t0, vectArr 	#address of array
		li 	$t5, 0 		#counterr
		
		#user enter in the coordinates
		loop:
			 beq 	$t5,6,exitLoop 	#for(counter < 6)
			 sll 	$t6, $t5, 2
			 add 	$t1, $t0, $t6	
			 
			 li 	$v0,5 		#enter integer
			 syscall
			 
			 move 	$s0,$v0 	#move int to register
			 sw 	$s0, ($t1)
		 	 addi 	$t5, $t5, 1  	# add int 1 to counter	 
		 	 j loop 		#jump to top if counter < 6
		exitLoop:
		
		la 	$t5, vectArr
				
		# first x
		lw 	$t2, ($t5)
		
		# first y
		lw 	$t3, 4($t5)
		
		# first z
		lw 	$t4, 8($t5)
		
		# second x
		lw 	$t6, 12($t5)
		
		# second y
		lw 	$t7, 16($t5)
		
		# second z
		lw 	$t8, 20($t5)
		
		# multiplication
		mul 	$t2, $t2, $t6
		mul 	$t3, $t3, $t7
		mul 	$t4, $t4, $t8
		
		# add
		add 	$t2, $t2, $t3
		add 	$t4, $t4, $t2
		
		li 	$v0, 4
		la 	$a0, prompt15
		syscall
		  
		li 	$v0, 1
		move 	$a0, $t4
		syscall
				 	 
	j End #break 
		
		L5:
		#Telling user they can only enter 2 vectors
		li 	$v0, 4
		la 	$a0, prompt14
		syscall
		
		#New line
		li 	$v0, 11
		la 	$a0, 10
		syscall 
		
		#Telling user how to enter vectors
		li 	$v0, 4
		la 	$a0, prompt6
		syscall
		
		#New line
		li 	$v0, 11
		la 	$a0, 10
		syscall
		
		la 	$t0, vectArr 	#address of array
		li 	$t5, 0 		#counterr
		
		#user enter in the coordinates
		loop2:
			 beq 	$t5,6,exitLoop2 #for(counter < 6)
			 sll 	$t6, $t5, 2
			 add 	$t1, $t0, $t6	
			 
			 li	$v0,5 		#enter integer
			 syscall
			 
			 move 	$s0,$v0 	#move int to register
			 sw 	$s0, ($t1)
		 	 addi 	$t5, $t5, 1 #	addint 1 to counter	 
		 	 j loop2 		#jump to top if counter < 6
		exitLoop2:
		
		la	$t5, vectArr
				
		# first x
		lw 	$t2, ($t5)
		
		# first y
		lw 	$t3, 4($t5)
		
		# first z
		lw 	$t4, 8($t5)
		
		# second x
		lw 	$t6, 12($t5)
		
		# second y
		lw 	$t7, 16($t5)
		
		# second z
		lw 	$t8, 20($t5)		
		
		# multiplication
		mul 	$s1, $t3, $t8
		mul 	$s2, $t4, $t7
		# x
		sub 	$s1, $s1, $s2
		
		# multiplication
		mul 	$s3, $t4, $t6
		mul 	$s4, $t2, $t8
		
		# y
		sub 	$s3, $s3, $s4
		
		# multiplication
		mul 	$s5, $t2, $t7
		mul 	$s6, $t6, $t3
		# z
		sub 	$s5, $s5, $s6
		
		li 	$v0, 4
		la 	$a0, prompt15
		syscall
		
		li 	$v0, 4
		la 	$a0, par
		syscall
		        
		li 	$v0, 1
		move 	$a0, $s1
		syscall
		
		li 	$v0, 4
		la 	$a0, comma
		syscall
		  
		li 	$v0, 1
		move 	$a0, $s3
		syscall
		
		li 	$v0, 4
		la 	$a0, comma
		syscall
		  
		li 	$v0, 1
		move 	$a0, $s5
		syscall
		
		li 	$v0, 4
		la 	$a0, pare
		syscall
		
	#End 
	End:
	
j Exit #break

# 2D Calculations
L2: 

	# How many vertices?
	li 	$v0, 4
	la 	$a0, prompt4
	syscall
	
	# Reads in integer
	li 	$v0, 5
	syscall
	sw 	$v0, buff2
	
	move 	$t3, $v0
	mul 	$t3, $t3, 2	# 2*vert
	
	# Tells user how to input digits
	li 	$v0, 4
	la 	$a0, prompt7
	syscall
	
	#New line
	li 	$v0, 11
	la 	$a0, 10
	syscall
	
	la 	$t0, vertArr 	#address of array
	li 	$t5, 0 		#counterr
	
	loop3:
		beq 	$t5,$t3,exitLoop3 	#for(counter < userInput)
	 	sll 	$t6, $t5, 2 		#the i 
		add 	$t1, $t0, $t6 		#correct element
			 
		li 	$v0,5 			#enter integer
		syscall
		
		move 	$s0,$v0 		#move int to register
		sw 	$s0, ($t1)
		addi 	$t5, $t5, 1 		#addint 1 to counter	 
		j loop3 			#jump to top if counter < userInput
	exitLoop3:
		
		la 	$t0, vertArr 	# address of array
		la 	$t9, detArr
		li 	$t1, 0 		# counter
		li 	$t2, 2 		# modulus
		
		
		sub 	$t3, $t3, 2 	# 2*vert - 2
	
	loop4:
		beq 	$t3, $t1, exitLoop4 	# i < 2*userInt - 2
		sll 	$t6, $t1, 2
		add 	$t5, $t0, $t6 		# adding to counter
		
		div 	$t7, $t3, $t2 		# i/2
		
		beq 	$t7, $zero, exit4 	# i/2 == 0
		
		lw 	$s0, ($t5) 		# vertArr[i]
		
		addi 	$t1, $t1, 3 		# coutner add 3
		sll 	$t6, $t1, 2
		add 	$t5, $t0, $t6 		# adding to counter
		lw 	$s1, ($t5)  		# vertArr[i+3]
		
		srl 	$t6, $t1, 2
		subi 	$t1, $t1, 3 		# counter sub 3
		sub 	$t5, $t0, $t6 		# adding to counter
		
		addi 	$t1, $t1,2 		# coutner add 2
		sll 	$t6, $t1, 2
		add 	$t5, $t0, $t6 		# adding to counter
		lw 	$s2, ($t5)  		# vertArr[i+2]
				
		srl 	$t6, $t1, 2
		subi 	$t1, $t1, 2		# counter sub 2
		sub 	$t5, $t0, $t6 		# adding to counter
		
		addi 	$t1, $t1,1 		# coutner add 1
		sll 	$t6, $t1, 2
		add 	$t5, $t0, $t6 		# adding to counter
		lw 	$s3, ($t5)  		# vertArr[i+1]
				
		srl 	$t6, $t1, 2
		subi 	$t1, $t1, 1 		# counter sub 1
		sub 	$t5, $t0, $t6 		# adding to counter
		
		mul 	$s0, $s0, $s1 		# multiply first x * second y
		mul 	$s2, $s2, $s3 		# multiply second x * first y
		sub 	$s0, $s0, $s2 		# sub these above to get determinate
		
		sll 	$t8, $t1, 1
		add 	$s7, $t9, $t8 		#adding to counter
		sw 	$s0, ($s7)
		
		addi 	$t1, $t1, 1 		# counter add 1
		
		exit4:
		addi 	$t1, $t1, 1
	j loop4
	exitLoop4:
	
	la 	$t0, vertArr 	# address of vertArr
	la 	$t9, detArr 	# address of detArr
	li 	$t1, 0 		# counter = 0
		
	sll 	$t6, $t1, 2
	add 	$t5, $t0, $t6
	lw 	$s0, ($t5) 	# vertArr[0]
	
	li 	$t1, 1 		# counter = 1
	
	sll 	$t6, $t1, 2
	add 	$t5, $t0, $t6
	lw 	$s1, ($t5) 	# vertArr[1]
	
	move 	$t1, $t3 	# counter = 2*vert - 2 
		
	sll 	$t6, $t1, 2
	add 	$t5, $t0, $t6
	lw 	$s2, ($t5) 	# vertArr[vert - 2]
	
	add 	$t3, $t3, 2 	# 2*vert-2 + 2 = 2*vert
	sub 	$t3, $t3, 1 	# 2*vert - 1
	
	move 	$t1, $t3 	# counter = 2*vert-1
	
	sll 	$t6, $t1, 2
	add 	$t5, $t0, $t6
	lw 	$s3, ($t5) 	# vertArr[vert - 1]
	
	mul 	$s1, $s1, $s2
	mul 	$s3, $s3, $s0
	sub 	$s1, $s1, $s3
	
	add 	$t3, $t3, 2 	# 2*vert-1+1 = 2*vert
	div 	$t3, $t3, 2 	# vert
	sub 	$t3, $t3, 1 	# vert - 1
	move 	$t1, $t3
	
	sll 	$t8, $t1, 2
	add 	$s7, $t9, $t8 	# adding to counter
	sw 	$s1, ($s7)
	
	#New line
	li 	$v0, 11
	la 	$a0, 10
	syscall
	
	# These are the determinates prompt
	li 	$v0, 4
	la 	$a0, prompt8
	syscall
	
	#New line
	li 	$v0, 11
	la 	$a0, 10
	syscall
		
	la 	$t0, detArr 		# address of detArr
	addi 	$t1, $zero, 0 	# counter
	
	add 	$t3, $t3, 1 	# vert - 1 + 1
	li 	$t5, 0
	
	loop6:
		beq 	$t1, $t3, exitLoop6
		sll 	$t2, $t1, 2
		add 	$t2,$t2, $t0
		lw 	$s0, ($t2)		
		
		# Calculating the sum for the determinates
		add 	$t5, $t5, $s0
		
		# Prints determinates in the arrays
		li 	$v0, 1
		move 	$a0, $s0
		syscall
		
		# Prints comma
		li	$v0, 4
		la 	$a0, comma
		syscall
		
		# Adding to counter
		addi 	$t1, $t1, 1
	j loop6
	exitLoop6:
	
	# New line
	li 	$v0, 11
	la 	$a0, 10
	syscall	
	
	bltz 	$t5, negative	# check if sum is less than 0
	
	back:	
	mtc1  	$t5, $f1	# move the register $t5 to float register
	cvt.s.w $f1, $f1	
	l.s 	$f2, floatValue	# move the floatValue to a register

	mul.s 	$f0, $f1, $f2	# multiply floats
	
	# New line
	li 	$v0, 11
	la 	$a0, 10
	syscall	
	
	li 	$v0, 4		# Prints "Area is " 
	la 	$a0, prompt9
	syscall
		
	li 	$v0, 2		# Prints area
  	mov.s 	$f12, $f0   	# Move contents of register $f0 to register $f12
  	syscall
  	j Exit
  	
  	#New line
	li 	$v0, 11
	la 	$a0, 10
	syscall
  	
  	negative:
	mul 	$t5,$t5,-1	# if above is true mult by -1
	j back

j Exit #break

# 3D Volume
L3: 
	#Prompt
	li 	$v0, 4
	la 	$a0, prompt5
	syscall
	
	#New line
	li 	$v0, 11
	la 	$a0, 10
	syscall
	
	# Tells user how to input digits
	li 	$v0, 4
	la 	$a0, prompt11
	syscall
	
	#New line
	li 	$v0, 11
	la 	$a0, 10
	syscall
	
	la	$t0, vectArr 	# address of array
	li  	$t5, 0 		# counterr
		
	#user enter in the coordinates
	loop5:
		 beq 	$t5,9,exitLoop5		# for(counter < 9)
		 sll 	$t6, $t5, 2
		 add 	$t1, $t0, $t6	
		 
		 li 	$v0,5 			#enter integer
		 syscall
		 
		 move 	$s0,$v0 		#move int to register
		 sw 	$s0, ($t1)
	 	 addi 	$t5, $t5, 1 		#addint 1 to counter	 
	 	 j loop5 			#jump to top if counter < 9
	exitLoop5:
	
	la 	$t5, vectArr
				
	lw 	$t2, ($t5)	# first x element 0
			
	lw 	$t3, 4($t5)	# first y element 1	
		
	lw 	$t4, 8($t5)	# first z element 2
	
	lw 	$t6, 12($t5)	# second x element 3
	
	lw 	$t7, 16($t5)	# second y element 4
		
	lw 	$t8, 20($t5)	# second z element 5
	
	lw 	$t9, 24($t5)	# third x element 6
	
	lw 	$s1, 28($t5)	# third y element 7
	
	lw 	$s2, 32($t5)	# third z element 8
	
	mul 	$s3, $t7, $s2	# multiply sec y * third z
	mul 	$s4, $s1, $t8 	# multiply third y * sec z
	sub 	$s3, $s3, $s4	# two above subtracted
	mul 	$s3, $s3, $t2   # mult first x * sub
	
	mul 	$s4, $t6, $s2	# multiply sec x * third z
	mul 	$s5, $t8, $t9	# multiply sec z * third x
	sub 	$s4, $s4, $s5	# two above subtracted
	mul 	$s4, $s4, $t3	# mult first y * sub
	
	mul 	$s5, $t6, $s1	# multiply sec x * third y
	mul 	$s6, $t7, $t9	# multiply sec y * third x
	sub 	$s5, $s5, $s6	# two above subtracted
	mul 	$s5, $s5, $t4	# mult first z * sub
	
	add 	$s3, $s3, $s5 	# add first and third calc
	sub 	$s3, $s3, $s4 	# sub from above
	
	bltz 	$s3, neg2
	
	back2:
	li 	$v0, 4		# volume prompt
	la 	$a0, prompt12
	syscall
		  
	li 	$v0, 1		# volume
	move 	$a0, $s3
	syscall
	
	j Exit
	
	neg2:
		mul $s3, $s3, -1 # if volume is negative
		j back2

#break 
Exit:

# Exit
li $v0, 10
syscall
