PROJECT TITLE: Functional Programming.erl
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


PROJECT TITLE: Concurrent Programming.erl
PURPOSE OF PROJECT: Stage 2 of University, Functional and Concurrent Programming ~ Assignment 4
VERSION or DATE: 17/04/2020
AUTHORS: Wai Shan (Karen) Yip
EXPLANATION: 
This assignment focuses on the implementation of the concurrency problem of Producer-Consumer.
Producer and Consumer both have access to a shared buffer.
The Producer continuously generates data and adds it to the end of the queue.
The Consumer repeatedly removes data from the front of the queue.
The Producer must wait if the queue is full.
The Consumer must wait if the queue is empty.
Deadlock occurs if the Producer waits due to the queue being full but does not generate data again when the Consumer empties the queue.
The buffer is a process that co-ordinates the producer and consumer.

1.
The Producer sends a string message to the process Logger.
logger repeatedly receives string messages and prints them out whilst counting the amount it has received.

2.
The consumer sends a request to buffer B to see if it is empty.
If the buffer is not empty, the consumer requests some data from the buffer and waits to receive it.
If the buffer is empty, the consumer waits for the notification that the buffer is not empty anymore.

3.
Buffer handles the messages sent by he producer and consumer.
BufferData is a list representing the queue stored in the buffer.
MaxSize is the maximum size of the queue.
WaitingConsumer is either none or is the processID of the waiting consumer.
WaitingProducer is either none or is the processID of the waiting producer.

4.
main implements a nullary function which spawns and connects the producer, consumer, logger and buffer.


PROJECT TITLE: classwork.erl
PURPOSE OF PROJECT: Practising Functional Programming
VERSION or DATE: 28/01/2020
AUTHORS: Wai Shan (Karen) Yip
EXPLANATION: 
This contains some practise of Functional Programming which I completed in preparation for the in class exam. 
