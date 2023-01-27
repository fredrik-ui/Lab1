  # timetemplate.asm
  # Written 2015 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

	.data
	.align 2
mytime:	.word 0x5957
timstr:	.ascii "text more text lots of text\0"
	.text
main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,2
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop

  # you can write your code for subroutine "hexasc" below this line
  #
   hexasc:
 
 
 	andi $a0, $a0, 0xf   #only take the 4 LSB
 	
 	move $t0, $a0	     # compare variable	
 	
 	li $t1, 0x9   	     #store 9 to compare
 	
 	addi $a0, $a0, 0x30  # add to get the Asci 
 	
 	bge $t1, $t0 number    # compare to see if it's > 9
 	
 	addi $a0, $a0, 0x7
 	
 number: 
 
 	move $v0, $a0  		
 	
 	jr $ra
 	
 	
 	
 delay:
  	jr $ra
  	nop
  	
  	
  	
  	
 time2string:
 
 	
 	PUSH $ra
 	
 	move $s6, $a0			# Move address 
 	
 	
 
 	andi $s1, $a1, 0xf000 		# Take 4 nibble and store it to 4 varible
 	andi $s2, $a1, 0x0f00
 	andi $s3, $a1, 0x00f0
 	andi $s4, $a1, 0x000f		
 	
 	
 	srl $a0, $s1, 12		#shift s1 right and store in a0
 	
 	
 	jal hexasc			#call hexasc
 	
 	sb $v0, 0x00($s6)		# Store byte in first index
 	
 	srl $a0, $s2, 8			# shift again
 	
 	jal hexasc
 	
 	sb $v0, 0x01($s6)		#store byte in second index
 	
 	li $s7, 0x3a			#make and store a ":"
 	
 	sb $s7, 0x02($s6)
 	
 	
 	srl $a0, $s3, 4
 	
 	jal hexasc
 	
 	sb $v0, 0x03($s6)
 	
 	move $a0, $s4
 	
 	jal hexasc
 	
 	
 	sb $v0, 0x04($s6)	
 	
 	li $s7, 0x00			#make and store null
 	
 	sb $s7, 0x05($s6)
 	
 	
 	POP $ra
 	
 	jr $ra
 	
 	
 	
 	
 	
 	
 	
