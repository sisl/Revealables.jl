module Revealables

using Interact
using Reactive

export Revealable
export revealable
export encode!
export encode
export decode!
export decode

mutable struct Revealable
    markdown::String
    label::String
    show::Bool
    encoded::Bool
end

Revealable(markdown::String, label::String = "Show/Hide", show = false, encoded = false) = Revealable(markdown, label, show, encoded)

function revealable(markdown::String, label::String, show::Bool)
    x = Revealable(markdown, label, show)
    revealable(x)
end

function revealable(markdown::String, label::String = "Show/Hide")
    x = Revealable(markdown, label, false)
    revealable(x)
end

function revealable(x::Revealable)
    toggle(; label = x.label, value=x.show, signal=Signal(x.show))
end

function revealable(x::Revealable)
    @manipulate for n in togglebutton(; label = x.label, value=x.show, signal=Signal(x.show))
        x.show = n
        x
    end
end

function rot(text::String, key::Int)
    map(text) do c
        if 'a' <= c <= 'z'
            Char(mod(c - 'a' + key, 26) + 'a')
        elseif 'A' <= c <= 'Z'
            Char(mod(c - 'A' + key, 26) + 'A')
        elseif '&' <= c <= '?'
            Char(mod(c - '&' + key, 26) + '&')
        else
            c
        end
    end
end

function encode!(x::Revealable, password::String)
    if x.encoded
        x
    else
        key = sum(map(x->convert(Int, x), collect(password)))
        x.markdown = rot(x.markdown, key)
        x.encoded = true
        x
    end
end

function encode(x::Revealable, password::String)
    r = Revealable(x.markdown, x.label, x.show)
    encode!(r, password)
end

function decode!(x::Revealable, password::String)
    if x.encoded
        key = 26 - sum(map(x->convert(Int, x), collect(password)))
        x.markdown = x.markdown = rot(x.markdown, key)
        x.encoded = false
        x
    else
        x
    end
end

function decode(x::Revealable, password::String)
    r = Revealable(x.markdown, x.label, x.show)
    decode!(r, password)
end


function Base.show(io::IO, ::MIME"text/markdown", x::Revealable)
    if x.show
        println(io, x.markdown)
    else
        println(io, "")
    end
end

end # module
