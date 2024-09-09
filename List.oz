declare Position

fun {Length List}
    case List of Head|Rest then
        1 + {Length Rest}
    [] nil then
        0
    end
end

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

fun {Drop List Count}
    if Count > {Length List} then
        nil
    else
        case List of Head|Rest then
            if Count == 0 then
                List
            else
                {Drop Rest Count - 1}
            end
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