% Assignment 2
\insert 'List.oz'
\insert 'Utils.oz'

declare Lex

% Task 1: mdc
% a
fun {Lex Input}
    {String.tokens Input 32}
end

{Show {Lex "1 2 + 3 *"}}

% b
fun {Tokenize Lexemes}
    case Lexemes of nil then
        nil
    [] Lex|Rest then
        case Lex of "+" then
            {Append [operator(type:plus)] {Tokenize Rest}}
        [] "-" then
            {Append [operator(type:minus)] {Tokenize Rest}}
        [] "*" then
            {Append [operator(type:multiply)] {Tokenize Rest}}
        [] "/" then
            {Append [operator(type:divide)] {Tokenize Rest}}
        [] "p" then
            {Append [command(type:print)] {Tokenize Rest}}
        [] "d" then
            {Append [command(type:duplicate)] {Tokenize Rest}}
        [] "i" then
            {Append [command(type:invert)] {Tokenize Rest}}
        [] "c" then
            {Append [command(type:clear)] {Tokenize Rest}}
        [] N then
            {Append [number({String.toInt N})] {Tokenize Rest}}
        end
    end
end

{Show {Tokenize {Lex "1 2 + 3 *"}}}

% c
fun {Interpret Tokens} 
    local A B Operands Result TempList in
        case Tokens of nil then
            nil
        [] Token|Rest then
            case Token of number(N) then
                {Interpret {Append Rest [N]}}
            [] operator(type:plus) then
                Operands = {TakeFromBack Tokens 2}
                A = Operands.2.1
                B = Operands.1
                Result = [A + B]

                TempList = {GetUpdatedList Tokens}
                {Interpret {Append TempList Result}}
            [] operator(type:minus) then
                Operands = {TakeFromBack Tokens 2}
                A = Operands.2.1
                B = Operands.1
                Result = [A - B]

                TempList = {GetUpdatedList Tokens}
                {Interpret {Append TempList Result}}
            [] operator(type:multiply) then
                Operands = {TakeFromBack Tokens 2}
                A = Operands.2.1
                B = Operands.1
                
                Result = [A * B]

                TempList = {GetUpdatedList Tokens}
                {Interpret {Append TempList Result}}
            [] operator(type:divide) then
                Operands = {TakeFromBack Tokens 2}
                A = Operands.2.1
                B = Operands.1
                
                Result = [A div B]

                TempList = {GetUpdatedList Tokens}
                {Interpret {Append TempList Result}}
            [] command(type:print) then
                Operands = {TakeFromBack Tokens 1}
                A = Operands.1

                {System.showInfo A}
                {Interpret {Drop Tokens 1}}
            [] command(type:duplicate) then
                Operands = {TakeFromBack Tokens 1}
                A = Operands.1

                TempList = {Drop Tokens 1}
                {Interpret {Append TempList [A]}}
            [] command(type:invert) then
                Operands = {TakeFromBack Tokens 1}
                A = Operands.1

                Result = [A * ~1]

                TempList = {GetUpdatedListOne Tokens}
                {Interpret {Append TempList Result}}
            [] command(type:clear) then
                {Interpret nil}
            else 
                {Reverse Tokens}
            end
        end
    end
end

{Assert {Interpret {Tokenize {Lex "1 2 +"}}} [3]}
{Assert {Interpret {Tokenize {Lex "1 2 + 3"}}} [3 3]}
{Assert {Interpret {Tokenize {Lex "1 2 + 3 *"}}} [9]}
{Assert {Interpret {Tokenize {Lex "2 2 3 + d"}}} [5 5 2]}
{Assert {Interpret {Tokenize {Lex "2 2 3 + d +"}}} [10 2]}
{Assert {Interpret {Tokenize {Lex "2 2 3 + d + /"}}} [5]}
{Assert {Interpret {Tokenize {Lex "2 2 3 + d + / 1"}}} [1 5]}
{Assert {Interpret {Tokenize {Lex "2 2 3 + d + / 1 i"}}} [~1 5]}
{Assert {Interpret {Tokenize {Lex "2 2 3 + d + / 1 i +"}}} [4]}
{Assert {Interpret {Tokenize {Lex "3 6 / 1 +"}}} [3]}
{Assert {Interpret {Tokenize {Lex "2 1 -"}}} [~1]}
{Assert {Interpret {Tokenize {Lex "7 d d"}}} [7 7 7]}
{Assert {Interpret {Tokenize {Lex "1 1 + d c"}}} nil}

Tokens = {Tokenize {Lex "2 2 3 + d + / 1"}}
{Show Tokens}

Interpreted = {Interpret Tokens}
{Browse Interpreted}

% Task 2: Convert postfix notation into an expression tree
fun {ExpressionTreeInternal Tokens ExpressionStack}
    if Tokens == nil then
        ExpressionStack.1
    else
        local Token Operands A B TempList in
            case Tokens of nil then
                nil
            [] Token|Rest then
                case Token of number(N) then
                    {ExpressionTreeInternal Rest {Append ExpressionStack [N]}}
                [] operator(type:plus) then
                    Operands = {TakeFromBack ExpressionStack 2}
                    A = Operands.2.1
                    B = Operands.1
                    
                    TempList = {TakeTillLastTwo ExpressionStack}
                    {ExpressionTreeInternal Rest {Append TempList [plus(A B)]}}
                [] operator(type:minus) then
                    Operands = {TakeFromBack ExpressionStack 2}
                    A = Operands.2.1
                    B = Operands.1
                    
                    TempList = {TakeTillLastTwo ExpressionStack}
                    {ExpressionTreeInternal Rest {Append TempList [minus(A B)]}}
                [] operator(type:multiply) then
                    Operands = {TakeFromBack ExpressionStack 2}
                    A = Operands.2.1
                    B = Operands.1
                    
                    TempList = {TakeTillLastTwo ExpressionStack}
                    {ExpressionTreeInternal Rest {Append TempList [multiply(A B)]}}
                [] operator(type:divide) then
                    Operands = {TakeFromBack ExpressionStack 2}
                    A = Operands.2.1
                    B = Operands.1
                    
                    TempList = {TakeTillLastTwo ExpressionStack}
                    {ExpressionTreeInternal Rest {Append TempList [divide(A B)]}}
                end
            end
        end
    end
end

fun {ExpressionTree Tokens}
    {ExpressionTreeInternal Tokens nil}
end

{Assert {ExpressionTree {Tokenize {Lex "1 2 +"}}} plus(2 1)}
{Assert {ExpressionTree {Tokenize {Lex "2 3 + 5 /"}}} divide(5 plus(3 2))}
{Assert {ExpressionTree {Tokenize {Lex "3 10 9 * - 7 +"}}} plus(7 minus(multiply(9 10) 3))}

{System.showInfo "--- DONE ---"}
