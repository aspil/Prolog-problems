corporation(L,CoinsList):-
	length(L,X),
	X1 is X + 1,
	fillwithX(ZeroCoinsList,0,X1), % Fills coins list with zeros.

	append([0],L,SvList),

	length(SvList,Y),
	fillWithConcec(Y,REmpList), % Make the reversed list of employees..
	reverse(REmpList,EmpList), % ..and correct it.
	solve(SvList,EmpList,ZeroCoinsList,CoinsList). % Solve the problem.

solve(_,[0|_],L,L).
solve(SvList,EmpList,CoinsList,NewCoinsList):-
	candidate(SvList,EmpList,Cand),

	getSuperVisor(Cand,EmpList,SvList,Sv),
	changeCoins(Cand,EmpList,SvList,CoinsList,L),

	finishedJob(SvList,Sv,EmpList,Cand,NewSvL,NewEmpL),

	solve(NewSvL,NewEmpL,L,NewCoinsList).
	
	
changeCoins(Cand,EmpL,SvL,CoinsList,NewCoinsList):-
	length(EmpL,X),
	fillwithX(C,0,X),
	giveCoins(Cand,1,EmpL,SvL,C,C1),
	addElements(C1,CoinsList,NewCoinsList).

% Base case.
giveCoins(1,CoinCount,_,_,[_|T],[CoinCount|T]).
% Initialize Sum to 0 and CoinCount to 1.
giveCoins(Cand,CoinCount,EmpList,SvList,CoinsList,CoinsEarned):-
	% Get the cand's supervisor to give him coins.
	myReplace(CoinsList,Cand,CoinCount,CoinsList1),
	% Sum1 is Sum + CoinCount, % Sum is for the coins that Mitsos will get during the current job.
	CoinCount1 is CoinCount + 1, % The amount of coins the next supervisor will get.
	getSuperVisor(Cand,EmpList,SvList,Sv),
	giveCoins(Sv,CoinCount1,EmpList,SvList,CoinsList1,CoinsEarned).
	% append(CoinsList,[],CoinsEarned).

% Pick the next employee to do the job.
candidate(_,[],_).
candidate(L,[H|_],Res):-
	not(member(H,L)),
	Res is H.
candidate(L,[H|T],Res):-
	member(H,L),
	candidate(L,T,Res).

% Returns the supervisor of Emp.
getSuperVisor(_,[],[],_).
getSuperVisor(Emp,[X|_],[Y|_],R):-
	X == Emp,
	R = Y.
getSuperVisor(Emp,[X|Xs],[_|Ys],R):-
	X \= Emp,
	getSuperVisor(Emp,Xs,Ys,R).

% Changes the supervisor and employee lists.
finishedJob(SvList,Supervisor,EmpList,Employee,NewSvL, NewEmpL):-
	% not(member(Supervisor,SvList)),
	select(Supervisor,SvList,-1,NewSvL),
	select(Employee,EmpList,0,NewEmpL).

% This function fills a list with number X, N times.
fillwithX([], _, 0).
fillwithX([X|Xs], X, N) :-
	succ(N0, N),
	fillwithX(Xs, X, N0).

% This function fills a list with numbers from N to 1.
fillWithConcec(0,[]).
fillWithConcec(N,[R|Rs]):-
	succ(N0,N),
	fillWithConcec(N0,Rs),
	R = N.
addElements([],[],[]).
addElements([H1|T1],[H2|T2],[R|Rs]):-
	addElements(T1,T2,Rs),
	R is H1 + H2.

myReplace([_|T], 1, X, [X|T]).
myReplace([H|T], I, X, [H|R]):-
	I > 1,
	NewI is I - 1,
	myReplace(T, NewI, X, R).