module Revealables

using Reactive
using Interact
using Markdown # will be in Base from v0.4 onwards

import Base.writemime, Base.write, Base.display

export Revealable
export revealable



type Revealable
    markdown::ASCIIString
    divclass::ASCIIString
    show::Bool
end

Revealable(markdown::ASCIIString, divclass::ASCIIString = "") = Revealable(markdown, divclass, false);



function revealable(markdown::ASCIIString, divclass::ASCIIString, show::Bool)
    x = Revealable(markdown, divclass, show)
    revealable(x)
end;

function revealable(markdown::ASCIIString, divclass::ASCIIString = "")
    x = Revealable(markdown, divclass, false)
    revealable(x)
end;

function revealable(x::Revealable)
	@manipulate for n in togglebutton(; label=string("Show/Hide", x.divclass == "" ? "" : string(" ", uppercase(x.divclass[1]),x.divclass[2:end])), value=x.show, signal=Input(x.show))
	    x.show = n
	    display(x)
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
