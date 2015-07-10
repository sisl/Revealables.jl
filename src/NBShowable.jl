module NBShowable

using Reactive
using Interact

import Base.writemime

export Showable

type Showable
    show::Bool
    html::ASCIIString
end

function Base.writemime(stream, ::MIME"text/html", x::Showable)
    if x.show
        println(stream, x.html)
    else
        println(stream, """        
            """
            )
    end
end

end # module
