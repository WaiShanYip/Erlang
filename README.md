# Erlang

PROJECT TITLE: Concurrent Programming.erl 
PURPOSE OF PROJECT: Stage 2 of University, Functional and Concurrent Programming ~ Assignment 2
VERSION or DATE: 28/02/2020
AUTHORS: Wai Shan (Karen) Yip
EXPLANATION: 
Question 1 takes the example of fundraising through crowdfunding.
pos_bids takes a list of Bids and returns a list, leaving out any negative amounts.
success takes Bids and Threshold as arguments and checks whether the sum of all the bid amounts is at least the threshold parameter.
winners takes Bids and Threshold as arguments and returns the list of bids that have been successful.

Question 2 concerns strings.
init takes 2 strings and returns true if the first string is an initial segment of the other.
drop takes an integer N and a string St, which removes the amount of elements from the beginning of St based on N.
subst takes the strings Old, New and St, and returns a string which replaces the string Old with the string New. 

Question 3 concerns the game of noughts and crosses.
isxwin takes a line of the board and determines whether it is a winning line of crosses or not.
linexwin takes the whole board and determines whether it contains a winning line of crosses or not.
pick takes an integer N and a list Xs and returns the Nth element of the list starting from 0.
wincol takes a whole board and determines whether there is any winning column.
