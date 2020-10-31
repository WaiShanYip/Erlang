-module(wsy3).
-compile(export_all).
%-type bid() :: {atom(), integer()}.

%Bids should not be 0 or negative.
%pos_bids takes a bid list Bids and returns a list, leaving out any bids
%that do not contain a positive number.
pos_bids([]) -> [];
pos_bids([{N, X}| Xs]) when X>0 -> [{N, X} | pos_bids(Xs)];
pos_bids([{_N,_X}| Xs]) -> pos_bids(Xs).

%success takes Bids and Threshold and checks whether the sum of all bids
%are at least the value of the threshold.
sum([]) -> 0;
sum([{_, X} | Xs]) -> X+sum(Xs).

success([{X, Bid} | Bids],  Threshold) -> 
        case sum([{X, Bid} | Bids]) > Threshold of 
            true -> true;
            false -> false
        end.

%winners takes Bids and Threshold and returns the list of bids that have
%been successful.
%Will be taken from the front of the list until the threshold is exceeded.
winners([], _Subtotal, _Threshold) -> [];
winners([{N, Bid} | _Bids], Threshold, Subtotal) when Bid + Subtotal == Threshold -> {N, Bid};
winners([{N, Bid} | Bids], Threshold, Subtotal) when Bid + Subtotal < Threshold -> [{N, Bid}] ++ winners(Bids, Threshold, Subtotal + Bid);
winners([{N, _Bid} | _Bids], Threshold, Subtotal) -> {N, (Threshold - Subtotal)}.

%init takes 2 strings and returns true if the first string is an initial
%segment of the other.
init([], _) -> true;
init([A|As], [B|Bs]) when A==B -> init(As, Bs);
init([_A|_As], [_B|_Bs]) -> false.

%drop takes an integer N and String St and returns the string St with
%the first N elements dropped.
drop(N, [_St| String]) when N>0 -> drop(N-1, String);
drop(_N, [St| String]) -> [St| String];
drop(_N, []) -> [].

%using init and drop.
%subst takes 3 strings, Old, New and St.
%Returns a string in which the first occurence of Old is replaced by New.
subst([OldX| OldXs], New, [St| String]) -> 
    case init([OldX| OldXs], [St| String]) of
       true-> New ++ drop(length([OldX| OldXs]), [St| String]);
       false -> [St] ++ subst([OldX| OldXs], New, String)
    end.

%isxwin takes a line of the board and returns boolean saying whether
%or not the line is a winning line of crosses.
isxwin([x, x, x]) -> true;
isxwin([o, o, o]) -> false;
isxwin([_, _, _]) -> false.

%linexwin takes a board and returns a boolean if the board contains a
%winning line of crosses.
linexwin([X|Xs], [Y|Ys], [Z|Zs]) -> 
        case isxwin([X| Xs]) of
            true -> true;
            false ->
                case isxwin([Y| Ys]) of
                    true->true;
                    false ->
                        case isxwin([Z| Zs]) of
                            true -> true;
                            false-> false
                        end
                end
        end.

%pick takes an integer N and a list of Xs and returns the Nth element
%of the list, starting from counter 0.
pick(0, [X| _Xs]) -> X;
pick(N, [_|Xs]) when N>0 -> pick(N-1, Xs).

%wincol takes a board and returns true if the board contains a winning
%column.
isowin([x, x, x]) -> true;
isowin([o, o, o]) -> false;
isowin([_, _, _]) -> false.

lineowin([X|Xs], [Y|Ys], [Z|Zs]) -> 
        case isowin([X| Xs]) of
            true -> true;
            false ->
                case isowin([Y| Ys]) of
                    true->true;
                    false ->
                        case isowin([Z| Zs]) of
                            true -> true;
                            false-> false
                        end
                end
        end.

wincol([A, B, C], [D, E, F], [G, H, I]) -> 
    case linexwin([A, D, G], [B, E, H], [C, F, I]) of
        true -> true;
        false -> 
            case
                lineowin([A, D, G], [B, E, H], [C, F, I]) of
                true -> true;
            false-> false
            end 
    end.