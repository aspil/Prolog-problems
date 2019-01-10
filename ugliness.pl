ugliness([],[],0).
% Case 1: L1 and L2 have the same length.
ugliness([H1|L],[H2|M],U):-
	sort([H1|L],[N1|L1]), sort([H2|M],[N2|M1]),
	length([N1|L1],X), length([N2|M1],Y),
	X == Y,
	ugliness(L1,M1,U1),
	abs(N1-N2,U2),
	U is max(U1,U2).

% Case 2: L1 is bigger than L2.
ugliness(L,M,U):-
	sort(L,L1), sort(M,M1),
	length(L1,X), length(M1,Y), X > Y, % Second list is smaller.
	beautify(M1,L1, BeautifiedL), % Fill the (sorted) second list until it has the same length with the first.

	findMaxDiff(BeautifiedL,L1,MaxDif), % Find the max difference of the lists' elements.
	removefromL(L1,BeautifiedL,MaxDif,L2), % Remove the element that causes the max difference.
	ugliness(L2,M,U).

% Case 3: L2 is bigger than L1.
ugliness(L,M,U):-
	sort(L,L1), sort(M,M1),
	length(L1,X), length(M1,Y), X < Y, % First list is smaller.
	beautify(L1,M1, BeautifiedL), % Fill the (sorted) first list until it has the same length with the second.

	findMaxDiff(BeautifiedL,M1,MaxDif), % Find the max difference of the lists' elements.
	removefromL(M1,BeautifiedL,MaxDif,M2), % Remove the element that causes the max difference.
	ugliness(M2,L,U).

% Beautify function fills the first list with the last element until
% its length becomes the same with the second list.

% Beautify base case.
beautify(L,M,Res):- length(L,X), length(M,Y), X == Y, Res = L.
beautify(L,M,Res):-
	length(L,Len1),length(M,Len2),
	Len1 < Len2,
	last(L,LastElem), % Find the last element of the list..
	addLast(LastElem,L, L1), % ..and add it at the end of that list.
	beautify(L1,M, Res).

% Utility function to find the maximum difference of two list elements.
findMaxDiff([],[],0).
findMaxDiff([H1|L], [H2|M], MaxDif):-
	findMaxDiff(L,M,Dif1),
	abs(H1-H2,Dif2),
	MaxDif is max(Dif1,Dif2).

% Removes the element that causes the max difference between two lists.
removefromL([],[],_,_).
removefromL([H1|L],[H2|M],MaxDif,NewL):-
	abs(H1-H2,D),
	MaxDif \= D,
	removefromL(L,M,MaxDif,NewL1),
	append([],[H1],NewL2), append(NewL2,NewL1,NewL).

removefromL([H1|L],[H2|_],MaxDif,NewL):-
	abs(H1-H2,D),
	MaxDif == D,
	select(H1,[H1|L],NewL).

% Adds an element X to the end of the list.
addLast(X,[],[X]).
addLast(X,[H|Tail],[H|Tail1]):-
	addLast(X,Tail,Tail1).