module Revealables

using Reactive
using Interact
using Markdown # will be in Base from v0.4 onwards

import Base.writemime, Base.write, Base.display

export Revealable
export revealable



type Revealable
    markdown::ASCIIString
    label::ASCIIString
    show::Bool
end

Revealable(markdown::ASCIIString, label::ASCIIString = "Show/Hide") = Revealable(markdown, label, false);



function revealable(markdown::ASCIIString, label::ASCIIString, show::Bool)
    x = Revealable(markdown, label, show)
    revealable(x)
end;

function revealable(markdown::ASCIIString, label::ASCIIString = "Show/Hide")
    x = Revealable(markdown, label, false)
    revealable(x)
end;

function revealable(x::Revealable)
    @manipulate for n in togglebutton(; label = x.label), value=x.show, signal=Input(x.show))
        x.show = n
        x
    end
end;



function writemime(stream, ::MIME"text/markdown", x::Revealable)
    if x.show
        println(stream, x.markdown)
    else
        println(stream, ""
            )
    end
end

function display(stream, x::Revealable)
    if x.show
        Markdown.display(x.content)
    else
        println(stream, ""
            )
    end
end

end # module
