module Showable

######################################################################################################
# 
# This module allows HTML to be hidden and revealed through code like this:
# 
#   f = Showable(false, """
#       <div class="answer">  ## Other defined div classes are "hint", "notes", and "example".
#       <b>Any HTML can go here!</b>
#       </div>
#         """)
#   @manipulate for n in togglebutton(; label="Show/Hide Answer", value=false, signal=Input(false))
#       f.show = n
#       f
#   end
# 
# For an example notebook, please see the documentation.
# 
######################################################################################################

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
