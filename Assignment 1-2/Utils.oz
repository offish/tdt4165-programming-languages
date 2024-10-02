proc {Assert X Y}
    if X == Y then
        skip
    else
        {raise error('Assertion failed') end}
    end
end