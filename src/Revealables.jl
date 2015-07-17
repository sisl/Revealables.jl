module Revealables

using Reactive
using Interact
using Markdown

import Base.display

export Revealable
export revealable



type Revealable
    content::Markdown.MD
    divclass::ASCIIString      # delete?
    show::Bool
end



Revealable(content::Markdown.MD, divclass::ASCIIString = "") = Revealable(content, divclass, false)


function revealable(content::Markdown.MD, divclass::ASCIIString, show::Bool)
    x = Revealable(content, divclass, show)
    revealable(x)
end

function revealable(content::Markdown.MD, divclass::ASCIIString = "")
    x = Revealable(content, divclass, false)
    revealable(x)
end

function revealable(x::Revealable)
    @manipulate for n in togglebutton(; label=string("Show/Hide", x.divclass == "" ? "" : string(" ", uppercase(x.divclass[1]),x.divclass[2:end])), value=x.show, signal=Input(x.show))
        x.show = n
        x
    end
end



function Base.display(d::Base.REPL.REPLDisplay, x::Revealable)
    if x.show
        display(x.content)
    else
        display("")
    end
end



end # module
