findlist([],_).
findlist([H|T],Res):-
	length(H,X),
	changeList(H,X,1,1,LoLs),
	sameWithAll(LoLs,T,Res). % Give list_of_lists of H and check which list inside it gives all the lists in arguments by moving only one number.

sameWithAll([L|_],[],L).
sameWithAll([L|Ls],[H|T],Res):-
	not(oneElemMoved(L,H)),
	sameWithAll(Ls,[H|T],Res).
% If list P is the same with the next in 'findlist' arguments move to the next findlist argument.
sameWithAll([P|PTail],[H|T],Res):-
	oneElemMoved(P,H),
	sameWithAll([P|PTail],T,Res).

changeList(_,Length,C1,_,[]):- C1 > Length.
changeList(L,Length,C1,C2,[H|R]):-
    C1 =< Length, C2 =< Length,
    select(C1,L,L1),
    insert_at_K(C1,L1,C2,H),
    NC is C2 + 1,
    changeList(L,Length,C1,NC,R).

changeList(L,Length,C1, C2,Res):-
    C2 > Length,
    NC1 is C1 + 1,
    changeList(L,Length,NC1,1,Res).

% Removes an element X from a list at position K.
remove_at_K(X,[X|Xs],1,Xs).
remove_at_K(X,[Y|Xs],K,[Y|Ys]) :- K > 1,
	K1 is K - 1,
	remove_at_K(X,Xs,K1,Ys).

% Inserts an element X at list L in position K and produces the list R.
% Disclaimer: The starting position in list is 1 not 0.
insert_at_K(X,L,K,R) :- remove_at_K(X,R,K,L).

oneUtil(L,P,N):-
    member(N,L),
    select(N,P,S),
    select(N,L,S).
oneUtil(L,P,N):-
    N1 is N+1,
    member(N1,L),
    oneUtil(L,P,N1).
% This function checks if between two (sorted) lists L1 and L2, only one element has been moved.
oneElemMoved([],_).
oneElemMoved(L1,L2):-
    oneUtil(L1,L2,1).