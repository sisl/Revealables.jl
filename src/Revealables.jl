module Revealables

using Reactive
using Interact

import Base.writemime, Base.write

export Revealable
export revealable



type Revealable
    html::ASCIIString
    divclass::ASCIIString
    show::Bool
end

Revealable(html::ASCIIString, divclass::ASCIIString = "") = Revealable(html, divclass, false)



function revealable(html::ASCIIString, divclass::ASCIIString, show::Bool)
    x = Revealable(html, divclass, show)
    revealable(x)
end

function revealable(html::ASCIIString, divclass::ASCIIString = "")
    x = Revealable(html, divclass, false)
    revealable(x)
end

function revealable(x::Revealable)
	@manipulate for n in togglebutton(; label=string("Show/Hide", x.divclass == "" ? "" : string(" ", uppercase(x.divclass[1]),x.divclass[2:end])), value=x.show, signal=Input(x.show))
	    x.show = n
	    x
	end
end;



function Base.write(stream, ::MIME"text/markdown", x::Revealable)
    if x.show
        if x.divclass ==""
            println(stream, string("""<div>""", x.html, """</div>"""))
        else
            println(stream, string("""<div class='""", x.divclass, """'>""", x.html, """</div>"""))
        end
    else
        println(stream, ""
            )
    end
end

function Base.writemime(stream, ::MIME"text/markdown", x::Revealable)
    if x.show
        if x.divclass ==""
            println(stream, string("""<div>""", x.html, """</div>"""))
        else
            println(stream, string("""<div class='""", x.divclass, """'>""", x.html, """</div>"""))
        end
    else
        println(stream, ""
            )
    end
end



end # module