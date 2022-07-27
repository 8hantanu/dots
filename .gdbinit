define bsave
    save breakpoints ~/.dump/.breakpoints
end

define brest
    source ~/.dump/.breakpoints
end
