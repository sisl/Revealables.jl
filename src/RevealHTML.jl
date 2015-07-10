module RevealHTML

using Reactive
using Interact

import Base.writemime

export Revealable

type Revealable
    show::Bool
    html::ASCIIString
end

function Base.writemime(stream, ::MIME"text/html", x::Revealable)
    if x.show
        println(stream, x.html)
    else
        println(stream, """        
            """
            )
    end
end

end # module
