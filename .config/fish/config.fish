function prependpath -a ppath
    if test -d "$ppath"
        set -gxp PATH "$ppath"
    end
end

prependpath ~/.cargo/bin
prependpath ~/gocode/bin
prependpath ~/bin
