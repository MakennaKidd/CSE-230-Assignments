#################################################################################################
#
#  Assignment #: 7
#  Name: Makenna Kidd
#  ASU email: mkidd4@asu.edu
#  Course: CSE 230 MW 3:00pm
#  Description:
#
#  This is MIPS Assembly assignment #7.  
#  write assembly language programs to:
#            -define a recursive procedure/function and call it.
#            -use syscall operations to display integers and strings on the console window
#            -use syscall operations to read integers from the keyboard.

#  The function1 is recursive and should be defined as:
#  
#   function1(n) = (n mod 7) - 11          if n <= 4
#                      = function1(n-2)*n - n*function1(n-4) - 5*n          otherwise
#
#                     				    It prints: 
#								   " Enter an integer: \n"
#								   " X "
#								   " The solution is: X "
#
#################################################################################################

#data declarations: declare variable names used in program, storage allocated in RAM

                 .data  
enterIntMsg: 				.asciiz " Enter an integer: \n "
solutionMsg: 				.asciiz " The solution is: "

#program code is contained below under .text

                 .text
                 .globl    main   #define a global function main

# the program begins execution at main()
main:

						# " Enter an integer: "
#Enter int print to console
    la			$a0, enterIntMsg  	# $a0 = address of enterIntMsg
    li			$v0, 4           	# $v0 = 4  --- this is to call print_string()
    syscall                      	# Call print_string()  
#Get user input of num1 value then append to enterIntMsg
    li			$v0, 5          	# $v0 = 5  --- this is to call print_string()
    syscall                     	# Call print_string()   
    add			$a0, $0, $v0     	# Storing value of num 1
    
	jal function1					# Jump to function1 to perform calculation     
	add 		$s0, $0, $v0		# Assign value returned from function1 to $s0
 
						# " The solution is: "
#Enter int print to console
    la			$a0, solutionMsg  	# $a0 = address of solutionMsg
    li			$v0, 4           	# $v0 = 4  --- this is to call print_string()
    syscall                      	# Call print_string()  
#Get user input of solution num value then append to solutionMsg
    add 		$a0, $0, $s0		# Storing value of solution num		
	li			$v0, 1          	# $v0 = 1  --- this is to call print_string()
    syscall                     	# Call print_string()   
   
# Exit the program
	li 			$v0, 10             # $v0 = 10  --- this is to call print_string()
	syscall                      	# Call print_string() 

############################################################################
# Procedure/Function function1
# Description: This label is used to perform the recursive calculation
# parameters: $a0 = n value
# return value: $v0 = computed value
# registers to be used:  $s0 - $s1 , $ra
############################################################################
  
#Label function1
#Function1 to perform resursion
function1:

#Branch greater than statement 
	bgt 		$a0, 4, recursion   # Branch if n is greater than 4, if so, then proceed to recursion label
#If n is less than 4, this calculation proceeds. 
	addi 		$s0, $0, 7      	# Adding value of 7 so $s0 = 7
	addi 		$s1, $0, 11    		# Adding value of 11 so $s1 = 11
	
	div 		$a0, $s0            # Dividing n by value in $s0
	mfhi 		$a0                	# Storing value of remainder from above value
	
	sub 		$a0, $a0, 11        # Subtracting  remainder of n by 11
	add 		$v0, $0, $a0		# Storing value of result int to $v0

	jr 			$ra					#Return Statement

############################################################################
# Procedure/Function recursion
# Description: This label is used to perform the recursive calculation
# parameters: $a0 = n value
# return value: $v0 = computed value
# registers to be used: $sp, $ra, $s0-$s2
############################################################################

#Label recursion
#Recursion label to perform recursion
recursion:

	sub 		$sp, $sp, 12		# Subtraction for stack value
	sw 			$ra, 0($sp)  		# Storing the return address store the return address
	sw 			$a0, 4($sp)  		# Storing the value of n in address $a0            
	addi 		$a0, $a0, -2    	# Adding value of -2 and storing value

	jal function1					# Jump to function1 to perform calculation    

	sw 			$v0, 8($sp)  		# Storing the value return from function1            
	lw 			$a0, 4($sp)			# Loading address value of $a0
	addi 		$a0, $a0, -4       	# Addition of value n int -4
	
	jal function1					# Jump to function1 to perform calculation    
                
	lw 			$s0, 8($sp)         # $s0 = function1(n-2)
	add 		$s1, $0, $v0    	# $s1 = function1(n-4)
	addi 		$s2, $0, 5      	# $s2 = 5
	
	lw 			$s4, 4($sp)			# Loading word $s4 is equal to n
	mul 		$s0, $s0, $s4       # Multiplying function from value $s4 into $s0. $s0 = function1(n-2)*n
	mul 		$s1, $s1, $s4       # Multiplying function from value $s4 into $s1. $s1 = function1(n-4)*n
	mul 		$s2, $s2, $s4       # Multiplying function from value $s4 into $s1. $s2 = 5*n
                
	add 		$v0, $0, $s0		# Adding function from $s0 and loading it into $vo
	sub 		$v0, $v0, $s1		# Adding function from $s1 and loading it into $vo
	sub 		$v0, $v0, $s2		# Adding function from $s2 and loading it into $vo

	lw 			$ra, 0($sp)			# Loading word for return address

	addi 		$sp, $sp, 12		# Additiong for adjusting stack value
	
	jr 			$ra					#Return Statement