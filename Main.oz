% Assignment 2
\insert 'List.oz'

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
        [] N then
            {Append [number({String.toInt N})] {Tokenize Rest}}
        end
    end
end

{Show {Tokenize {Lex "1 2 + 3 *"}}}

% c
fun {Interpret Tokens}
    case Tokens of nil then
        nil
    [] Token|Rest then
        case Token of number(N) then
            {System.showInfo N}
            {Append {Interpret Rest} [N]}
        [] operator(type:plus) then
            % take the two first elements and add them
            % then append to the list, without the two first elements
            % {Take Tokens 1} + {Take Tokens 2}
            {System.showInfo "matched on plus"}

            {Take Tokens 1}
            % {{Take Tokens 1} + {Take Tokens 2}}
        end
    end
end

{System.showInfo "--- BELOW ---"}

Tokens = {Tokenize {Lex "1 2 +"}}

{Show Tokens}
{Show {Interpret Tokens}}

% {Show {Interpret {Tokenize {Lex "1 2 +"}}}}
% {Show {Interpret {Tokenize {Lex "1 2 3 +"}}}}