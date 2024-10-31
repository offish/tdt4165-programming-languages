declare
    Enumerate
    GenerateOdd
    LastDivisorsOf
    ListPrimesUntil
    LazyEnumerate
    LazyList
    Primes
    LazyPrimes
    IsPrime
    PrimesList
    ShowStream
in

% Task 2
% a
fun {Enumerate Start End}
    thread
        if Start > End then 
            nil
        else
            Start | {Enumerate Start+1 End}
        end
    end
end

{Browse {Enumerate 1 5}} % [1 2 3 4 5]

% b
fun {GenerateOdd Start End}
    thread
        Odds = {Filter {Enumerate Start End} fun {$ X} X mod 2 == 1 end}
        in
        Odds
    end
end

% c
{Show {Enumerate 1 5}} % _<optimized>
{Show {GenerateOdd 1 5}} % _<optimized>

{Browse {GenerateOdd 1 5}} % [1 3 5]
{Browse {GenerateOdd 4 4}} % nil

% Task 3
% a
fun {LastDivisorsOf Number}
    thread 
        Divisors = {Filter {Enumerate 1 Number} fun {$ X} Number mod X == 0 end}
        in 
        Divisors
    end
end

{Show {LastDivisorsOf 10}} % _<optimized>
{Browse {LastDivisorsOf 10}} % [1 2 5 10]

% b
fun {IsPrime N}
    {Length {LastDivisorsOf N}} == 2
end

fun {ListPrimesUntil N}
    thread
        {Filter {Enumerate 2 N} fun {$ X} {IsPrime X} end}
    end
end

{Show {ListPrimesUntil 20}} % _<optimized>
{Browse {ListPrimesUntil 20}} % [2 3 5 7 11 13 17 19]

proc {ShowStream List}
    case List of _|Tail then
        {System.show List.1}
        thread {ShowStream Tail} end
    else
        skip
    end
end


% Task 4
% a
fun lazy {LazyEnumerate N}
    N | {LazyEnumerate N+1}
end

LazyList = {LazyEnumerate 1}

{Browse LazyList.1} % 1
{Browse LazyList.2.1} % 2
{Browse LazyList.2.2.1} % 3
{Browse LazyList.2.2.2.1} % 4
{Browse LazyList.2.2.2.2.1} % 5
{Browse LazyList.2.2.2.2.2.1} % 6
{Browse LazyList.2.2.2.2.2.2.1} % 7

% b

fun lazy {LazyPrimes N}
    case N of Head|Rest then
        if {IsPrime Head} then
            Head | {LazyPrimes Rest}
        else
            {LazyPrimes Rest}
        end
    else
        nil
    end
end

PrimesList = {LazyPrimes {LazyEnumerate 2}}

{Browse PrimesList.1}      % 2
{Browse PrimesList.2.1}    % 3
{Browse PrimesList.2.2.1}  % 5
{Browse PrimesList.2.2.2.1} % 7
{Browse PrimesList.2.2.2.2.1} % 11