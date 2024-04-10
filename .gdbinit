set breakpoint pending on
# set detach-on-fork off

define bsave
    save breakpoints ~/.breakpoints
end

define brest
    source ~/.breakpoints
end
