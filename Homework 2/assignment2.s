#################################################################################################
#
#  Assignment #: 2
#  Name: Makenna Kidd
#  ASU email: mkidd4@asu.edu
#  Course: CSE 230 MW 3:00pm
#  Description:
#  This is MIPS Assembly assignment #2. It will load addresses of variables/values into registers, 
#  perform arithmetic and logical operations on variables, and use syscall operations to display
#  integers and string on the console window. 
#                         It prints: 
#			     *XXX being the value within the code, not actually XXX. 
#					 "num1 is: XXX" 
#					 "num2 is: XXX"
#					 "num1 + num2 = XXX"
#					 "num1 - num2 = XXX" 
#
#################################################################################################

#data declarations: declare variable names used in program, storage allocated in RAM

                 .data  
num1:            .word 89327
num2:            .word 0xC6E 
script1:         .asciiz " num1 is: "
script2:         .asciiz "\n num2 is: "
script3:         .asciiz "\n num1 + num2 = "
script4:         .asciiz "\n num1 - num2 = "

#program code is contained below under .text

                  .text
                  .globl    main  #define a global function main

# the program begins execution at main()
main:

#Load num1 and num2 into temp registers
      lw          $t1, num1
      lw          $t2, num2  

#Print script1 to console
      la          $a0, script1    # $a0 = address of script1
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()    
#Print value of num1 appended to script1
      move        $a0, $t1        # loading value of num1 address of script1 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()   
  
#Print script2 to console
      la          $a0, script2    # $a0 = address of script2
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Print value of num2 appended to script2
      move        $a0, $t2        # loading value of num2 address of script2 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()   

#Print script3 to console
      la          $a0, script3    # $a0 = address of script3
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Adding num1 and num2: $t3 being the sum value
      add         $t3, $t2, $t1
#Print sum of num1 + num2 appended to script3
      move        $a0, $t3        # loading the sum value address of script3 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()   

#Print script4 to console
      la          $a0, script4    # $a0 = address of script4
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
#Subtracting num1 and num2: $t4 being the difference value
      sub         $t4, $t1, $t2
#Print difference of num1 4 num2 appended to script4
      move        $a0, $t4        # loading the difference value address of script4 into $a0
      li          $v0, 1          # $v0 = 1  --- this is to call print_string()
      syscall                     # call print_string()   

      jr          $ra             # return