#################################################################################################
#
#  Assignment #: 3
#  Name: Makenna Kidd
#  ASU email: mkidd4@asu.edu
#  Course: CSE 230 MW 3:00pm
#  Description:
#  This is MIPS Assembly assignment #3. It will load addresses of variables/values into registers, 
#  perform arithmetic and logical operations on variables entered from a user, and use syscall operations to display
#  integers and string on the console window. 
#                         It prints: 
#			     *XXX being the value within the code, not actually XXX. 
#					 " Enter a value: "
#					 "\n Enter another value: "
#					 "\n Enter one more value: "
#					 "\n Enter one more value: "
#					 "\n num2 + num4 = "
#					 "\n num3 - num1 = "
#					 "\n num2 * num3 = "
#					 "\n num1 / num4 = "
#					 "\n num2 mod num3 "
#					 "\n (num4 + ((num3 / 5) mod num1)) * num2 = "					 					 					 
#
#################################################################################################

#data declarations: declare variable names used in program, storage allocated in RAM

                 .data  
prompt1:         .asciiz " Enter a value: "
prompt2:         .asciiz "\n Enter another value: "
prompt3:         .asciiz "\n Enter one more value: "
prompt4:         .asciiz "\n Enter one more value: "
function1:       .asciiz "\n\n num2 + num4 = "
function2:       .asciiz "\n\n num3 - num1 = "
function3:       .asciiz "\n\n num2 * num3 = "
function4:       .asciiz "\n\n num1 / num4 = "
function5:       .asciiz "\n\n num2 mod num3 = "
function6:       .asciiz "\n\n(num4 + ((num3 / 5) mod num1)) * num2 = "

#program code is contained below under .text

                  .text
                  .globl    main  #define a global function main

# the program begins execution at main()
main:

				#First User Input
#Print prompt1 to console
      la          $a0, prompt1    # $a0 = address of prompt1
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()    
#Get user input of num1 value then append to prompt1
      li          $v0, 5          # $v0 = 5  --- this is to call print_string()
      syscall                     # call print_string()   
      move        $t1, $v0        # loading value of num1 address of prompt1  into $t1

				#Second User Input  
#Print prompt2 to console
      la          $a0, prompt2    # $a0 = address of prompt2
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Get user input of num2 value then append to prompt2
      li          $v0, 5          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()   
      move        $t2, $v0        # loading value of num2 address of prompt2 into $t2

				#Third User Input
#Print prompt3 to console
      la          $a0, prompt3    # $a0 = address of prompt3
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Get user input of num3 value then append to script3
      li          $v0, 5          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()  
      move        $t3, $v0        # loading value of num2 address of prompt3 into $t3 

				#Fourth User Input
#Print prompt4 to console
      la          $a0, prompt4    # $a0 = address of prompt4
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Get user input of num4 value then append to prompt4
      li          $v0, 5          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()   
      move        $t4, $v0        # loading value of num2 address of prompt4 into $t4

				#Adding and printing num2 and num4 
#Print function1 message to console
      la          $a0, function1  # $a0 = address of function1
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Function: num2 + num 4  
      add $t5, $t2, $t4
#Print sum of num2 + num 4 appended to function1
      move        $a0, $t5        # loading the sum value address of function1 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()   

				#Subtracting and printing num3 from num1
#Print function2 message to console
      la          $a0, function2  # $a0 = address of function2
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Function: num3 - num1   
      sub $t5, $t3, $t1
#Print difference of num3 - num1 appended to function2
      move        $a0, $t5        # loading the difference value address of function2 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()   

				#Multiplying and printing num2 and num3
#Print function3 message to console
      la          $a0, function3  # $a0 = address of function3
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Function: num2 * num3   
      mul $t5, $t2, $t3
#Print product of num2 * num3 appended to function3
      move        $a0, $t5        # loading the product value address of function3 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()   
      
				#Dividing and printing num1 from num4 
#Print function4 message to console
      la          $a0, function4  # $a0 = address of function4
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Function: num1 / num4   
      div $t5, $t1, $t4
#Print quotient of num1 / num4 appended to function4
      move        $a0, $t5        # loading the quotient value address of function4 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()  
      
				#Modulo and printing num2 mod num3
#Print function5 message to console
      la          $a0, function5  # $a0 = address of function5
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Function: num2 mod num3  
      rem $t5, $t2, $t3
#Print mod value num2 mod num3 appended to function5
      move        $a0, $t5        # loading the mod value address of function5 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()  
        
      				#Function and printing (num4 + ((num3 / 5) mod num1)) * num2
#Print function6 message to console
      la          $a0, function6  # $a0 = address of function6
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Function: (num4 + ((num3 / 5) mod num1)) * num2
      div $t5, $t3, 5 
      rem $t5, $t5, $t1
      add $t5, $t4, $t5
      mul $t5, $t5, $t2
#Print function value (num4 + ((num3 / 5) mod num1)) * num2 appended to function6
      move        $a0, $t5       # loading the function value address of function6 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()        
      
      jr          $ra             # return

Exit: