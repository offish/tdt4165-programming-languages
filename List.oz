declare Position

fun {Length List}
    case List of Head|Rest then
        1 + {Length Rest}
    [] nil then
        0
    end
end

fun {Take List Count}
    % Get the first x elements of the list
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

fun {TakeFromBack List Count}
    % Get the last x elements of the list
    {Drop List {Length List} - Count}
end

fun {Drop List Count}
    % Drop the first x elements of the list
    if Count > {Length List} then
        nil
    else
        case List of Head|Rest then
            if Count == 0 then
                List
            else
                {Drop Rest Count - 1}
            end
        % [] nil then
        %     nil
        end
    end
end

fun {Append List1 List2}
    case List1 of Head|Rest then
        Head | {Append Rest List2}
    else
        List2
    end
end

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

fun {Position List Element}
    case List of Head|Rest then
        if Head == Element then
            1
        else
            {Position Rest Element} + 1
        end
    end
end

fun {GetUpdatedList Tokens}
    {Take Tokens.2 {Length Tokens.2} - 2}
end

fun {GetUpdatedListOne Tokens}
    {Take Tokens.2 {Length Tokens.2} - 1}
end

fun {Reverse List}
    case List of Head|Rest then
        {Append {Reverse Rest} [Head]}
    else
        nil
    end
end