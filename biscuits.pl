biscuits(0,0,[]).
biscuits(K,N,[W|L1]):-
    X is (N*(N-1))/2,
    W is K-X, M is N-1,
    biscuits(X,M,L1).