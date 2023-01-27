  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text
main:
	li	$a0,16  	# change this to test different values

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

  # You can write your own code for hexasc here
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
 	
 
 
 	
 	
 	
 	
 	
 	
 	

