% Task 1
declare QuadraticEquation

proc {QuadraticEquation A B C ?RealSol ?X1 ?X2}
    local Delta in
        Delta = B * B - 4.0 * A * C
        
        if Delta < 0.0 then
            RealSol = false
        else
            RealSol = true
            X1 = (~B + {Float.sqrt Delta}) / (2.0 * A)
            X2 = (~B - {Float.sqrt Delta}) / (2.0 * A)
        end
    end
end

local X1 X2 RealSol in
    {QuadraticEquation 2.0 1.0 ~1.0 RealSol X1 X2}
    
    {System.show RealSol}
    {System.show X1}
    {System.show X2}
end

local X1 X2 RealSol in
    {QuadraticEquation 2.0 1.0 2.0 RealSol X1 X2}
    
    {System.show RealSol}
    {System.show X1}
    {System.show X2}
end

% Task 2
fun {OldSum List}
    case List of nil then
        0
    [] Head|Rest then 
        Head + {OldSum Rest}
    end
end

local MyList in
    MyList = [1 2 3 4 5]
    {System.show {OldSum MyList}}
end

% Task 3
fun {RightFold List Op U}
    case List of nil then
        U
    [] Head|Rest then
        {Op Head {RightFold Rest Op U}}
    end
end

fun {Sum List}
    {RightFold List Number.'+' 0}
end

fun {Length List}
    {RightFold List fun {$ X Y} 1 + Y end 0}
end

local MyList in
    MyList = [1 2 3 4 5 6]
    {System.show {Sum MyList}}
    {System.show {Length MyList}}
end

% Task 4
fun {Quadratic A B C}
    fun {$ X}
        A * X * X + B * X + C
    end
end

{System.show {{Quadratic 3 2 1} 2}}

% Task 5
fun {LazyNumberGenerator StartValue}
    StartValue | fun {$} {LazyNumberGenerator StartValue + 1} end
end

{System.show {LazyNumberGenerator 0}.1}
{System.show {{LazyNumberGenerator 0}.2}.1}
{System.show {{{{{{LazyNumberGenerator 0}.2}.2}.2}.2}.2}.1}

% Task 6
fun {InternalSumTailRecursive List Accumulation}
    case List of nil then
        Accumulation
    [] Head|Rest then
        {InternalSumTailRecursive Rest Head + Accumulation}
    end
end

fun {SumTailRecursive List}
    {InternalSumTailRecursive List 0}
end

{System.show {SumTailRecursive [1 2 3 4 5 6 7 8 9 10]}}
