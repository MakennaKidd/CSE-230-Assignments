#################################################################################################
#
#  Assignment #: 4
#  Name: Makenna Kidd
#  ASU email: mkidd4@asu.edu
#  Course: CSE 230 MW 3:00pm
#  Description:
#  This is MIPS Assembly assignment #4. It is a MIPS assembly language program that reads some 
#  ticket purchase information from a customer, whether they are daytime tickets, or night light 
#  tickets, how many adult tickets and child tickets they need.
#
#                         It prints: 
#				*X being the value within the code, not actually X. 
#			    " Welcome to our Theme Park! "
#				" Choose 1 for Daytime admission, 2 for NightLights. "
#				" X " //This is user input answer.
#				" How many adult ticket(s) would you like to purchase? "
#				" X " //This is user input answer. 
#				" How many child ticket(s) would you like to purchase?"
#				" X " //This is user input answer.
#				" Your total amount for this purchase: X dollar(s) for X people. "
#				 
#				If entry is invalid for admission or tickets, it will print these 
#				    messages that correspond with the respective prompt above. 
#               " Invalid admission. "
#               " Invalid number of tickets. " 
#
#################################################################################################

#data declarations: declare variable names used in program, storage allocated in RAM

                 .data  
				 
welcomemsg:            .asciiz " Welcome to our Theme Park! \n "
admissionmsg:          .asciiz "\n Choose 1 for Daytime admission, 2 for NightLights. \n "
howmanyadultmsg:       .asciiz "\n How many adult ticket(s) would you like to purchase? \n "
howmanychildmsg:       .asciiz "\n How many child ticket(s) would you like to purchase? \n "
totalamountmsg:        .asciiz "\n Your total amount for this purchase: "
dollarscontmsg: 	   .asciiz " dollar(s) for "
peoplecontmsg:		   .asciiz " people. \n"

invalidadmissionmsg:   .asciiz "\n Invalid admission. \n "
invalidticketsmsg:     .asciiz "\n Invalid number of tickets. \n "
				 
#program code is contained below under .text

                  .text
                  .globl    main       #define a global function main

# the program begins execution at main()
main:
                        # " Welcome to our Theme Park! "
#Welcome Message print to console
      la          $a0, welcomemsg      # $a0 = address of welcomemsg
      li          $v0, 4               # $v0 = 4  --- this is to call print_string()
      syscall                          # call print_string()  
	  
                 # " Choose 1 for Daytime admission, 2 for NightLights. "
#Admission Message print to console & get user input
# Daytime admission cost: Adult = $25, Child = $16. NightLights admisson cost: Adult = $20, Child = $10.
      la          $a0, admissionmsg    # $a0 = address of admissionmsg
      li          $v0, 4               # $v0 = 4  --- this is to call print_string()
      syscall                          # call print_string()    
#User choosing option 1 or 2 for Daytime or NightLights admission 
      li          $v0, 5               # $v0 = 5  --- this is to call print_string()
      syscall                          # call print_string()   
      add         $t0, $0, $v0         # loading value of user choice address of admissionmsg into $t0
#Checking to see is user input is valid for admission choice
	  beq $t0, 1, validadmission	   # If this is a valid choice, then it will jump to label validchoice
	  bne $t0, 2, invalidadmission	   # If this is an invalid choice, then it will jump to label invalidchoice
	  
#Label
#This label goes through the valid admission statement and performs all of the correct calculations and inputs. 
validadmission:
                 # " How many adult ticket(s) would you like to purchase? "
#Adult ticket message print to console
	  la 		  $a0, howmanyadultmsg # $a0 = address of howmanyadultmsg
      li          $v0, 4               # $v0 = 4  --- this is to call print_string()
	  syscall 						   # call print_string()    
#Reading user input and storing it into temp register $t1
	  li		  $v0, 5               # $v0 = 5  --- this is to call print_string()
	  syscall                          # call print_string()   
	  add 		  $t1, $0, $v0         # loading value of user choice address of howmanyadultmsg into $t1
                 # " How many child ticket(s) would you like to purchase? "
#Child ticket message print to console
	  la 		  $a0, howmanychildmsg # $a0 = address of howmanychildmsg
      li          $v0, 4               # $v0 = 4  --- this is to call print_string()
	  syscall 						   # call print_string()    
#Reading user input and storing it intp temp register $t2	
	  li		  $v0, 5               # $v0 = 5  --- this is to call print_string()
	  syscall                          # call print_string()   
	  add 		  $t2, $0, $v0         # loading value of user choice address of howmanychildmsg into $t2
#Calculating how many tickets are purchased
      add 		  $t3, $t2, $t1
#Check validity of tickets purchased
	  ble         $t3, 0, invalidticket      # If ticket number is invalid, then it will jump to Label invalidticket
#Checking and calculating Daytime and NightLights admission cost
	  beq 		  $t0, 1, daytimecost	     #Jumping to daytime label to calculate cost for daytime admission
	  beq		  $t0, 2, nightlightscost    #Jumping to nightlights label to calculate cost for nightlights admission

	  j exit								 #Jumping to exit label

#Label
#This label calculates the cost of a DayTime ticket.
daytimecost: 
	  mul 		  $t1, $t1, 25
	  mul 	      $t2, $t2, 16
	  add 		  $t4, $t1, $t2
	  
	  j totalamountprint					 #Jumping to totalamountprint label

#Label
#This label calculates the cost of a NightLights ticket.
nightlightscost:
	  mul 		  $t1, $t1, 20
	  mul		  $t2, $t2, 10
	  add 		  $t4, $t1, $t2
	  
	  j totalamountprint					 #Jumping to totalamountprint label
	  
#Label 
#This label calculates the total cost for dollars and total amount of people. 
totalamountprint:
					       # " Your total amount for this purchase: "	
#Printing total amount message 				   
	  la          $a0, totalamountmsg  # $a0 = address of totalamountmsg
      li          $v0, 4               # $v0 = 4  --- this is to call print_string()
      syscall                          # call print_string()  
#Calculating/printing total cost value	
	  li 		  $a0, 0			   # $a0 = address of 0
	  add 	      $a0, $0, $t4 		   # calculating the costs of the registers for total amount
	  li 		  $v0, 1               # $v0 = 1  --- this is to call print_string()
	  syscall                          # call print_string()  
                                 # " dollar(s) for"	  
#Printing dollar(s) for continuing message for the previous print statement
	  la          $a0, dollarscontmsg  # $a0 = address of dollarscontmsg
      li          $v0, 4               # $v0 = 4  --- this is to call print_string()
      syscall                          # call print_string()  
#Calculating/printing person value
	  li 		  $v0, 4               # $v0 = 4  --- this is to call print_string()
	  add		  $a0, $t3, $0         # calculating the costs of the registers for total amount
	  li 		  $v0, 1               # $v0 = 1  --- this is to call print_string()
	  syscall                          # call print_string()
							     # " people. "	  
#Printing people for continuing message for the previous print statement	
	  la          $a0, peoplecontmsg   # $a0 = address of peoplecontmsg
      li          $v0, 4               # $v0 = 4  --- this is to call print_string()
      syscall                          # call print_string()  
	  
	  j exit						   #Jumping to exit label
	  
#Label
#This label prints the invalid admission message.
invalidadmission:
                                 # " Invalid admission. "
#Printing invalid admission message
	  la          $a0, invalidadmissionmsg     # $a0 = address of invalidadmissionmsg
      li          $v0, 4                       # $v0 = 4  --- this is to call print_string()
      syscall                                  # call print_string()  

	  j exit								   #Jumping to exit label  
	  
#Label 
#This label prints the invalid ticket message. 
invalidticket:
	                             # " Invalid ticket. "
	  la          $a0, invalidticketsmsg     # $a0 = address of invalidticketsmsg
      li          $v0, 4                     # $v0 = 4  --- this is to call print_string()
      syscall                                # call print_string()  
	  
	  j exit								   #Jumping to exit label    
	  
#Exit Label  
exit: 
	  li          $v0, 10
	  syscall
