# NBShowable

This module allows HTML to be hidden and revealed by pressing a button in an IJulia notebook.

It is useful for hiding and revealing answers to practice problems.


## Installation
```julia
Pkg.clone("URL")
Pkg.build("NBShowable")
```

Installation requires standard IPython and IJulia installation with default directory structure.

## Use
Hide and show blocks of HTML through code like this:

```f = NBShowable(false, """
    <div class="answer">  # Other defined div classes are "hint", "notes", and "example".
    <b>Any HTML can go here!</b>
    </div>
    """)

@manipulate for n in togglebutton(; label="Show/Hide Answer", value=false, signal=Input(false))
    f.show = n
    f
end```

Please see the example notebook for more details.
