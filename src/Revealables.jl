module Revealables

using Reactive
using Interact

import Base.writemime

export Revealable
export revealable

type Revealable
    show::Bool
    divclass::ASCIIString
    html::ASCIIString
end

function revealable(x::Revealable)
	@manipulate for n in togglebutton(; label=string("Show/Hide ", uppercase(x.divclass[1]),x.divclass[2:end]), value=x.show, signal=Input(x.show))
	    x.show = n
	    x
	end
end

function revealable(show::Bool, divclass::ASCIIString, html::ASCIIString)
	x = Revealable(show, divclass, html)
	revealable(x)
end


function Base.writemime(stream, ::MIME"text/html", x::Revealable)
    if x.show
        println(stream, string("""<div class='""", x.divclass, """'>""", x.html, """</div>"""))
    else
        println(stream, """        
            """
            )
    end
end



end # module
