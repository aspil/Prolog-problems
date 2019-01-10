solvelists(L1,L2,Res):-
    solveUtil(L1,L2,Found1,Res1),
    reverse(Res1,Res2),
    solveUtil(L1,L2,Found2,Res3),
    mergeLists(Res3,Res2,Res4),
    mergeLists(Found1,Found2,Found),
    inf_solutions(L1,Found,S1),
    inf_solutions(L2,Found,S2),
    mergeLists(Res4,S1,Res5),
    mergeLists(Res5,S2,Res).
	
% Base case.
solveUtil([],[],[],[]).
% Case 1: H1 is an atom and H2 is an integer.
solveUtil([H1|T1],[H2|T2],[H1|FoundT],[(H1,H2)|ResT]):-
	atom(H1), integer(H2),
	myReplace(H1,H2,T2,L2), myReplace(H1,H2,T1,L1),
	solveUtil(L1,L2,FoundT,ResT).
	
% Case 2: H2 is an atom and H1 is an integer.
solveUtil([H1|T1],[H2|T2],[H2|FoundT],[(H2,H1)|ResT]):-
	integer(H1), atom(H2),
	myReplace(H2,H1,T2,L2),myReplace(H2,H1,T1,L1),
	solveUtil(L1,L2,FoundT,ResT).

% Case 3: Both H1 and H2 are atoms.
solveUtil([H1|T1],[H2|T2],Found,S):-
	atom(H1), atom(H2),
	solveUtil(T1,T2,Found,S).

% Case 4: Both H1 and H2 are integers.
solveUtil([H1|T1],[H2|T2],Found,S):-
	integer(H1), integer(H2),
	H1 =:= H2,
	solveUtil(T1,T2,Found,S).

% This function handles the case where an atom has infinite solutions. 
% by assigning a default value(0) to that atom.
inf_solutions([],_,[]).
% H is an atom with an integer assigned to it.
inf_solutions([H|T],Found,Res):-
	atom(H),
	member(H,Found),
	inf_solutions(T,Found,Res).
% H is an atom with no integer assigned to it.
inf_solutions([H|T],Found,[(H,0)|Res]):-
	atom(H),
	not(member(H,Found)),
	inf_solutions(T,Found,Res).
% H is an integer.
inf_solutions([H|T],Found,Res):-
	integer(H),
	inf_solutions(T,Found,Res).

% Replace an element in a list.
myReplace(_,_,[],[]).
myReplace(Old,New,[Old|T],[New|T2]):-
	myReplace(Old,New,T,T2).
myReplace(Old,New,[H|T],[H|T2]):-
	dif(H,Old),
	myReplace(Old,New,T,T2).

mergeLists(L1,L2,Res):-
	append(L1,L2,Res1),
	sort(Res1,Res).