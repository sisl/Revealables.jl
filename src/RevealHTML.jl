module RevealHTML

using Reactive
using Interact

import Base.writemime

export RevealHTML

type RevealHTML
    show::Bool
    html::ASCIIString
end

function Base.writemime(stream, ::MIME"text/html", x::RevealHTML)
    if x.show
        println(stream, x.html)
    else
        println(stream, """        
            """
            )
    end
end

end # module
