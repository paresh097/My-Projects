##########################################################################################
#
#Basic Problem Solving
#WRITTEN BY - PARESH PATIL
#
##########################################################################################
"""1 An online retailer sells two products: widgets and gizmos. Each widget weighs 75
grams. Each gizmo weighs 112 grams. Write a program that reads the number of
widgets and the number of gizmos in an order from the user.
Then your program should compute and display the total weight of the order"""
##########################################################################################


widgets = 75                                            #Assignings value in gm of one widget
gizmo = 112                                             #Assignings value in gm of one gizmo
W=int(input(" Enter the number of widget you want -"))  #input from user in int for widget
G=int(input(" Enter the number of gizmos you want -"))  #input from user in int for gizmo
tot_weig=widgets*W+gizmo*G                              #calculation for total weight
unit="gm"
print("The total weight of the order : ",tot_weig,unit)  #printing the output


##########################################################################################
"""2 Pretend that you have just opened a new savings account that earns 4 percent interest per
year. The interest that you earn is paid at the end of the year, and is added to the balance
of the savings account. Write a program that begins by reading the amount of money
deposited into the account from the user. Then your program should compute and
display the amount in the savings account after 1, 2, and 3 years.
Display each amount so that it is rounded to 2 decimal places"""
###########################################################################################


saving=float(input(" Enter the amount of money in saving -"))   #input from user in float for saving amount
inter=0.04                                                      #Assignings interest value to variable
year_1 = saving + saving * inter                                #Calculations
year_2 = year_1 + year_1 * inter
year_3 = year_2 + year_2 * inter

print("Amount with interest of First year : %.2f"%year_1)       #Printing the output
print("Amount with interest of Second year : %.2f"%(year_2))    #Printing the output
print("Amount with interest of Third year : %.2f"%(year_3))     #Printing the output


###########################################################################################
'''3 Many people think about their height in feet and inches, even in some countries that
primarily use the metric system.
Write a program that reads a number of feet from the user, followed by a number of
inches. Once these values are read, your program
should compute and display the equivalent number of centimeters.
Hint: One foot is 12 inches. One inch is 2.54 centimeters'''
###########################################################################################


feets=input(" Enter the number of feet and inches   -")            #input from user in string for feets and inches
a, b = map(float,feets.split("."))                                   # seprating and converting values from string to int
inches=a*12+b                                                      #calculate inches from feet
centi=float(inches*2.54)                                           #calculate centimeters from inches and converting to float
print("Number of centimeters are %.2f cm"%centi)                   #Printing output in centimeters


###########################################################################################
'''4 Consider the software that runs on a self-checkout machine. One task that it must be able
to perform is to determine how much change to provide when the shopper pays for a
purchase with cash.
Write a program that begins by reading a number of cents from the user as an
integer. Then your program should compute and display the denominations of the coins
that should be used to give that amount of change to the shopper. The change should be
given using as few coins as possible. Assume that the machine is loaded with pennies,
nickels, dimes, quarters, loonies and toonies. 
1 cents=pennies
5 cents =nickels
10 cents =dimes
25 cents =quarters
100 cents =loonies
200 cents =toonies
'''
###########################################################################################


cents=int(input(" Enter the number of cents  -"))   #input from user in int for cents
print(cents//200, "tonnies")                        # floor divison by 200
cents = cents%200                                   # Modulus for remaining value
print(cents//100, "lonnies")
cents = cents%100
print(cents//25, "quarters")
cents = cents%25
print(cents//10, "dimes")
cents = cents%10
print(cents//5, "nickles")
cents = cents%5
print(cents//1, "pennies")
###########################################################################################










