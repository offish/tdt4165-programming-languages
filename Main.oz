% Assignment 1

% Task 1: Hello World
{Show 'Hello World'}

% Task 2: Using other text editors
% Done in Visual Studio Code

% Task 3: Variables
% a)
local X Y = 300 Z = 30 in
    X = Y * Z
    {Show X} % 9000
end 

% b)
local X Y in
    X = "This is a string"
    thread {System.showInfo Y} end
    Y = X
end

/*
    Why can showInfo print Y before it is assigned?
    This is because of dataflow variables, where an unbound variable waits for 
    a value. This means that the thread will wait for Y to be bound to a value
    before showing the value.

    Why is this behavior useful?
    This behavior makes sure computation involving shared variables are
    synchronized. This also allows for concurrent programs. It might also reduce
    the chances for deadlocks.
    
    What does the statement Y=X do?
    The statement Y=X is a unification statement, this means that Y and X must
    refer to the same value.
*/

% Task 4: Functions and procedures
% Get unification error in needed statement if these are not declared
declare Max 
declare PrintGreater

fun {Max Number1 Number2}
    if Number1 > Number2 then
        Number1
    else
        Number2
    end
end

proc {PrintGreater Number1 Number2}
    {Show {Max Number1 Number2}}
end

{PrintGreater 10 20} % 20

% Task 5: Variables II
declare Circle

proc {Circle R} A D C Pi = 355.0 / 113.0 in
    A = Pi * R * R
    D = 2.0 * R
    C = Pi * D

    {Show A} % 28.2743
    {Show D} % 6
    {Show C} % 18.8495
end

{Circle 3.0}

% Task 6: Recursion
fun {Factorial N}
    if N == 0 then
        1
    else
        N * {Factorial N - 1}
    end
end

{Show {Factorial 3}} % 6

% Task 7: Lists
\insert 'List.oz'

MyList = [1 2 3 4 10 11]
MyListTwo = [33 21]

{Show MyList} % [1 2 3 4 10 11]
{Show {Length MyList}} % 6
{Show {Take MyList 3}} % [1 2 3]
{Show {Drop MyList 3}} % [4 10 11]
{Show {Append MyList MyListTwo}} % [1 2 3 4 10 11 33 21]
{Show {Member MyList 10}} % true
{Show {Member MyList 12}} % false
{Show {Position MyList 10}} % 5

% Task 8: List II
% a)
fun {Push List Element}
    {Append List [Element]}
end

% b)
fun {Peek List}
    if {Length List} == 0 then
        nil
    else
        case List of Head|Rest then
            Head
        end
    end
end

% c)
fun {Pop List}
    {Drop List 1}
end

{Show {Push MyList 5}} % [1 2 3 4 10 11 5]
{Show {Peek MyList}} % 1
{Show {Peek [nil]}} % nil
{Show {Pop MyList}} % [2 3 4 10 11]
