:- use_module(library(clpfd)).


% Task 1
payment(0, []).
payment(SumNeeded, [coin(AmountNeeded, CoinValue, Available)|Tail]) :-
    Amount in 0..Available,
    SumNeeded #= CoinValue * Amount + RestSum,
    payment(RestSum, Tail).

% ?- payment(25, [coin(Ones,1,11),coin(Fives,5,4),coin(Tens,10,3),coin(Twenties,20,2)]).
% ?- payment(25, [coin(Ones,1,11),coin(Fives,5,4),coin(Tens,10,3),coin(Twenties,20,2)]), label([Ones, Fives, Tens, Twenties]).
