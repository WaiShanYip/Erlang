-module(wsy3).
-compile(export_all).

%%logger repeatedly receives string messages and prints them out and
%%counts the number of messages it has received, labelling its printed
%%messages with this count.
logger(Count) -> 
    receive 
         Message -> io:fwrite("[~w] ~w~n", [Count, Message]), logger(Count +1)
    end.

%%The consumer sends to a buffer B a request to see if it is empty.
%%If the buffer is not empty, the consumer requests some data from the
%%buffer and then waits to receive this data (c4-> c0).
%%If the buffer is empty, the consumer waits to receive notification 
%%that the buffer is not empty (c2-> c3).
consumer(0, _, _) -> ok;

consumer(Count, Logger, Buffer) -> 
    %%Generate a random message string
    Msg = integer_to_list(round(rand:uniform()*10)),
    %%c0 -> c1
    Buffer ! {isEmptyQ, self()},
        receive
            %%c1-> c2
            empty ->
                Logger ! "C: Buffer empty. I wait.",
                    receive
                        
                        %%c2-> c4
                        notEmpty ->
                            Logger ! ("C: Consumer awoke, asking for data. " ++ Msg),
                            consumerGo(Count, Msg, Logger, Buffer)
                    end;

                        %%c1-> c3
                        notEmpty -> 
                            Logger ! ("C: Got data " ++ Msg),
                            consumerGo(Count, Msg, Logger, Buffer)
        end.

%%c4-> c0
consumerGo(Count, Msg, Logger, Buffer) ->
    Buffer ! {getData, self()},
        receive   
            {data, Msg}->
                io:fwrite("C: Asking for data.: " ++ Count ++ "~w~n", 
                [Count, Msg]), consumer(Count +1, Logger, Buffer)
        end.

%%Handles all the messages sent by the producer and consumer.
%%BufferData is a list representing the queue stored in the buffer.
%%MaxSize is the maximum size of the queue.
%%WaitingConsumer is either none (No consumer waiting), or it is the 
%%process ID of the waiting consumer.
%%WaitingProducer is either none (No producer waiting), or it is the
%%process ID of the waiting producer.
buffer(MaxSize)->
    buffer([], MaxSize, none, none).

buffer([BufferDataX| BufferDataXS], MaxSize, WaitingConsumer, WaitingProducer)->
       receive 
            {isFullQ, WaitingProducer} when length([BufferDataX| BufferDataXS]) < MaxSize ->
                WaitingProducer ! notFull,
                    receive 
                        {data, Msg} -> 
                            buffer([BufferDataX| BufferDataXS] ++ Msg, MaxSize, WaitingConsumer, WaitingProducer);

                                {isEmptyQ, WaitingConsumer} when length([BufferDataX| BufferDataXS]) >0 ->
                                    WaitingConsumer ! notEmpty,
                                        receive
                                            {getData, WaitingConsumer} -> 
                                                [BufferDataX| BufferDataXS] = [BufferDataXS],
                                                buffer([BufferDataX| BufferDataXS], MaxSize, WaitingConsumer, WaitingProducer);

                                                    {isEmptyQ, WaitingConsumer} when length([BufferDataX| BufferDataXS]) == 0 ->
                                                        WaitingConsumer ! empty;    
            
                                                            {isFullQ, WaitingProducer} when length([BufferDataX| BufferDataXS]) == MaxSize ->
                                                                WaitingProducer ! full
                                        end
                    end
        end.
                    
%%Main spawns and connects the producer, the consumer, the logger, the
%%buffer.
main() ->
    Logger = spawn(?MODULE, logger, []),
    Buffer = spawn(?MODULE, buffer, [5]),
    Producer = spawn(?MODULE, producer, [5]),
    Consumer = spawn(?MODULE, consumer, []),
    spawn(?MODULE, [Producer, Consumer, Buffer, Logger]).