# Prolog-problems
These five exercises were implemented as an assignment for the course Principles of Programming Languages.
All the problems were written and tested using the SWI-Prolog environment.

**biscuits.pl**  
Little Mitsos has K ≥ 100 biscuits and N ≥ 1 friends. He decided to share the biscuits in an unusual and unfairly way:
Each of his friends gets at least one biscuit and everyone gets a different number of biscuits. 
Define a function biscuits(K,N,L), which given K biscuits and N friends, returns a list with the distribution of biscuits that satisfies the above conditions. For example biscuits(100,5,L) may return L = [10,30,20,5,35] (there are more solutions other than this one).

**ugliness.pl**  
Little Mitsos decides to match some pairs of socks that are thrown around his room. It's a well-known law of the universe that a perfect sock match is impossible: (almost) always a sock will remain unmatched. We want to help Mitsos achieve the impossible. There are two lists, L and M, containing positive natural numbers. L contains the lengths of the left socks and M the lengths of the right (The two lists do not necessarily have the same length). Mitsos wants to match as many socks as possible, matching a left sock with a right. His purpose is to minimize the "ugliness" of the result (because his mother will check on him). The "ugliness" of a match is defined as the maximum absolute difference between the sizes of all pairs in the matching procedure.
Define a function ugliness(L, M, U), which given L and M calculates the "ugliness" U. For example, ugliness([2,3],[2,3],U) returns U = 0, ugliness([2,39,41,45],[39,42,46],U) returns U = 1 and ugliness([7,6,1,2,10],[9,11,6,3,12],U) returns U = 4.
    
**corporation.pl**  
Little Mitsos grew up and became a multinational corporation manager with N employees, numbered from 1 to N. Mitsos has the number 1. Every employee (except Mitsos) has a supervisor. Each supervisor may have many subordinates for whom he is directly responsible.
Every time the company undertakes a project, Mitsos assigns it to the subordinate with the smallest number. This employee in turn assigns the project to a subordinate that has the smallest number. The process continues until the project reaches an employee who does not has a supervisor, who must necessarily do the job.
At this point the problems begin. The employee who does the job gets 1 coin, his supervisor gets 2, etc. The coins that Mitsos gets equal to the number of employees that are in the sequence which starts with the employee who did the job until it reaches Mitsos. Obviously, the employee who did the job, understands how unfair the system is and resigns, seeking better luck in another company.
When a new project comes, the process is repeated but without the resigned employee. This situation continues until Mitsos is left alone in the company, so he is forced to do his first (but also last) job. 
Define a function corporation(L,M) , where L is a list of length N - 1 consisting of positive natural numbers a2,a3,...,aN
(1 ≤ ai < i), where ai is the head of employee i, and M is a list of N numbers, where the i-th number is equal to the number
of the coins received by the employee i. For example, corporation([1,2,2,4],M) will return M = [13,8,1,3,1].

**findlist.pl**  
Let a list containing all the numbers from 1 to n, without repeated elements and not necessarily ordered. We assume that we do not know this list at the beginning. We know, however, five lists that have resulted from the unknown list in the following way:
The first list has occurred from the unknown list by moving one of the numbers to another location. The second list has occurred by moving a different number from the original list to another location, etc.
Define the function findlist(L, M), which given a list L consisting of five lists, returns the original list as a result. For example, the query findlist([[1,2,5,3,4],[1,5,3,4,2],[4,2,1,5,3],[2,3,1,5,4],[2,1,3,4,5]],M) returns M = [2,1,5,3,4].

**solvelists.pl**  
There are two lists, L and M, of the same length that contain natural numbers and lowercase letters 
(for example, L = [x,3,x,y,3] and M = [x,y,2,z,3]). The goal is to find out whether there is a way to replace variables with natural numbers so that the two lists become identical.
Define the function solvelists(L,M,S) which given the lists L and M returns a list of pairs that gives a possible solution to the problem. For example, solvelists([x,3,x,y,3],[x,y,2,z,3],S) returns S = [(x,2),(y,3),(z,3)],, while the query solvelists([4,5,xx,yy],[1,xx,3,xx],S) returns false. In some cases there may be more than one solution. In this case it's enough to return one of them.
