module Revealables

using Interact
using Reactive

import Base.writemime, Base.display

export Revealable
export revealable
export encode!
export encode
export decode!
export decode


type Revealable
    markdown::ASCIIString
    label::ASCIIString
    show::Bool
    encoded::Bool
end

Revealable(markdown::ASCIIString, label::ASCIIString = "Show/Hide", show = false, encoded = false) = Revealable(markdown, label, show, encoded)

function revealable(markdown::ASCIIString, label::ASCIIString, show::Bool)
    x = Revealable(markdown, label, show)
    revealable(x)
end

function revealable(markdown::ASCIIString, label::ASCIIString = "Show/Hide")
    x = Revealable(markdown, label, false)
    revealable(x)
end

function revealable(x::Revealable)
    @manipulate for n in togglebutton(; label = x.label, value=x.show, signal=Input(x.show))
        x.show = n
        x
    end
end


function rot(text::ASCIIString, key::Int)
    map(text) do c
        if 'a' <= c <= 'z'
            char(mod(c - 'a' + key, 26) + 'a')
        elseif 'A' <= c <= 'Z'
            char(mod(c - 'A' + key, 26) + 'A')
        elseif '&' <= c <= '?'
            char(mod(c - '&' + key, 26) + '&')
        else
            c
        end
    end
end

function encode!(x::Revealable, password::ASCIIString)
    if x.encoded
        x
    else
        key = sum(password)
        x.markdown = rot(x.markdown, key)
        x.encoded = true
        x
    end
end

function encode(x::Revealable, password::ASCIIString)
    r = Revealable(x.markdown, x.label, x.show)
    encode!(r, password)
end

function decode!(x::Revealable, password::ASCIIString)
    if x.encoded
        key = 26 - sum(password)
        x.markdown = x.markdown = rot(x.markdown, key)
        x.encoded = false
        x
    else
        x
    end
end

function decode(x::Revealable, password::ASCIIString)
    r = Revealable(x.markdown, x.label, x.show)
    decode!(r, password)
end


function writemime(io::IO, ::MIME"text/markdown", x::Revealable)
    if x.show
        println(io, x.markdown)
    else
        println(io, "")
    end
end

function display(io::IO, x::Revealable)
    if x.show
        x
    else
        println(io, "")
    end
end

end # module
