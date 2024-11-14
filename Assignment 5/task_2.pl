:- use_module(library(clpfd)).

distance(c1, c2, 10, 1).
distance(c1, c3, 0, 0).
distance(c1, c4, 7, 1).
distance(c1, c5, 5, 1).
distance(c2, c3, 4, 1).
distance(c2, c4, 12, 1).
distance(c2, c5, 20, 1).
distance(c3, c4, 0, 0).
distance(c3, c5, 0, 0).
distance(c4, c5, 0, 0).
distance(c2, c1, 10, 1).
distance(c3, c1, 0, 0).
distance(c4, c1, 7, 1).
distance(c5, c1, 5, 1).
distance(c3, c2, 4, 1).
distance(c4, c2, 12, 1).
distance(c5, c2, 20, 1).
distance(c4, c3, 0, 0).
distance(c5, c3, 0, 0).
distance(c5, c4, 0, 0).
% distance(Cabin1, Cabin2, Distance, Connected)

% Task 2.1
plan(Cabin1, Cabin2, Path, TotalDistance) :-
    plan_helper(Cabin1, Cabin2, [Cabin1], 0, Path, TotalDistance).

plan_helper(Cabin2, Cabin2, Visited, TotalDistance, Path, TotalDistance) :-
    reverse(Visited, Path).  % Reverse the path to show from start to end

plan_helper(Current, Cabin2, Visited, DistanceAcc, Path, TotalDistance) :-
    distance(Current, Next, Distance, 1),
    not(Next = Current),
    not(member(Next, Visited)),
    NewDistanceAcc #= DistanceAcc + Distance,  % Update accumulated distance
    plan_helper(Next, Cabin2, [Next | Visited], NewDistanceAcc, Path, TotalDistance).

% ?- plan(c1, c2, Path, TotalDistance).
/*
Path = [c1, c2],
TotalDistance = 10
Path = [c1, c4, c2],
TotalDistance = 19
Path = [c1, c5, c2],
TotalDistance = 25
false
*/

% Task 2.2
bestplan(Cabin1, Cabin2, Path, Distance) :-
    plan(Cabin1, Cabin2, ThisPath, ThisDistance),
    bestplan_helper(Cabin1, Cabin2, ThisPath, ThisDistance, Path, Distance).

bestplan_helper(_, _, BestPath, BestDistance, BestPath, BestDistance).

bestplan_helper(Cabin1, Cabin2, CurrentBestPath, CurrentBestDistance, BestPath, BestDistance) :-
    plan(Cabin1, Cabin2, NewPath, NewDistance),
    not(NewPath = CurrentBestPath),
    (
        NewDistance < CurrentBestDistance ->
            bestplan_helper(Cabin1, Cabin2, NewPath, NewDistance, BestPath, BestDistance)
        ;
            bestplan_helper(Cabin1, Cabin2, CurrentBestPath, CurrentBestDistance, BestPath, BestDistance)
    ).

% ?- bestplan(c1, c2, Path, Distance).
/*
Distance = 10,
Path = [c1, c2]
...
*/
