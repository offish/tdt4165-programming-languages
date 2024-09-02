% Assignment 1

% Task 1: Hello World
{Show 'Hello World'}

% Task 3: Variables
% a)
local X Y = 300 Z = 30 in
    X = Y * Z
    {Show X}
end 

% b)
local X Y in
    X = "This is a string"
    thread {System.showInfo Y} end
    Y = X
end

/*
    I think Y can be printed due to the overhead and time it takes for the thread
    to be created and ran, that the following statement Y=X is able to run before
    the actual value gets printed. I would therefore also assume that the thread
    is non-blocking, as the next line is ran.
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

{PrintGreater 10 20}

% Task 5: Variables II
declare Circle

proc {Circle R} A D C Pi = 3.14 in
    A = Pi * R * R
    D = 2.0 * R
    C = Pi * D

    {Show A}
    {Show D}
    {Show C}
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

{Show {Factorial 3}}

% Task 7: Lists
% a)
fun {Length List}
    case List of Head|Rest then
        1 + {Length Rest}
    [] nil then
        0
    end
end

% b)
fun {Take List Count}
    if Count > {Length List} then
        List
    elseif Count == 0 then
        nil
    else
        % take first element then element +1 then element +2 etc.
        case List of Head|Rest then
            Head | {Take Rest Count - 1}
        end
    end
end

% c)
fun {Drop List Count}
    if Count > {Length List} then
        nil
    else
        case List of Head|Tail then
            if Count == 0 then
                List
            else
                {Drop Tail Count - 1}
            end
        end
    end
end

% d)
fun {Append List1 List2}
    case List1 of Head|Rest then
        Head | {Append Rest List2}
    else
        List2
    end
end

% e)
fun {Member List Element}
    case List of Head|Rest then
        if Head == Element then
            true
        else
            {Member Rest Element}
        end
    else
        false
    end
end

% f)
fun {Position List Element}
    case List of Head|Rest then
        if Head == Element then
            1
        else
            {Position Rest Element} + 1
        end
    end
end

MyList = [1 2 3 4 10 11]
MyListTwo = [33 21 43]

% {Show {Length MyList}}
% {Show {Take MyList 7}}
{Show MyList}
{Show {Take MyList 3}}
{Show {Drop MyList 3}}
{Show {Append MyList MyListTwo}}
{Show {Member MyList 10}}
{Show {Member MyList 12}}
{Show {Position MyList 10}}

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

{Show {Push MyList 5}}
{Show {Peek [nil]}}
{Show {Pop MyList}}
