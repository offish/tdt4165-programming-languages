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

% MyStack = [nil]

% c
fun {Interpret Tokens}
    {Browse Tokens}
    local A B Operands NewList in 
        case Tokens of nil then
            nil
        [] Token|Rest then
            case Token of number(N) then
                % {Append {Interpret Rest} [N]}
                % note this is wrong order
                {Interpret {Append Rest [N]}}
            [] operator(type:plus) then
                Operands = {TakeFromBack Tokens 2}
                A = Operands.2.1
                B = Operands.1
                
                {Browse A}
                {Browse B}
                % NewList = {Drop {TakeFromBack Tokens 1000} 1}
                % {Interpret {Append NewList [A + B]}} 
                [A + B]
            [] operator(type:minus) then
                List = {Drop Tokens 1}
                A = List.2.1
                B = List.1
                [A - B]
            [] operator(type:multiply) then
                List = {Drop Tokens 1}
                A = List.2.1
                B = List.1
                [A * B]
            [] operator(type:divide) then
                List = {Drop Tokens 1}
                A = List.2.1
                B = List.1
                [A / B]
                % {}
                % List
                
                % {Append {Interpret Rest} [{List.hd Rest} + {List.hd {List.tl Rest}}]}

            %     {Append {Interpret Rest} [{List.hd Rest} + {List.hd {List.tl Rest}}]}
            % [] operator(type:minus) then
            %     {Append {Interpret Rest} [{List.hd Rest} - {List.hd {List.tl Rest}}]}
            % [] operator(type:multiply) then
            %     {Append {Interpret Rest} [{List.hd Rest} * {List.hd {List.tl Rest}}]}
            % [] operator(type:divide) then
            %     {Append {Interpret Rest} [{List.hd Rest} / {List.hd {List.tl Rest}}]}
            end
        end
    end
end

{System.showInfo "--- BELOW ---"}

Tokens = {Tokenize {Lex "1 2 +"}}
{Show Tokens}

Interpreted = {Interpret Tokens}
{Browse Interpreted}
% {Show Interpreted}

% {Show {Interpret {Tokenize {Lex "1 2 +"}}}}
% {Show {Interpret {Tokenize {Lex "1 2 3 +"}}}}