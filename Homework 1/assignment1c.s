######################################################################################
#
#  Assignment #: 1
#  Name: Makenna Kidd
#  ASU email: mkidd4@asu.edu
#  Course: CSE 230 MW 3:00pm
#  Description: This is my first assembly language program.
#                         It prints:
#					 "Hello world."
#					 "Goodbye world."
#					 "I will write more MIPS programs."
#
######################################################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                  .data  
message1:         .asciiz " Hello world.\n"
message2:         .asciiz " Goodbye world.\n" #create a string containing "Goodbye world.\n"
message3:         .asciiz " I will write more MIPS programs.\n" #create a string containing "I will write more MIPS programs.\n"

#program code is contained below under .text
                  .text
                  .globl    main  #define a global function main

# the program begins execution at main()
main:

#Print message1 to console
      la          $a0, message1   # $a0 = address of message1
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()
      
#Print message2 to console
      la          $a0, message2   # $a0 = address of message2
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()

#Print message3 to console
      la          $a0, message3   # $a0 = address of message3
      li          $v0, 4          # $v0 = 4  --- this is to call print_string()
      syscall                     # call print_string()

      jr          $ra             # return