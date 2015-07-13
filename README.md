# Revealables

This module allows HTML to be hidden and revealed by pressing a button in an IJulia notebook.

It is useful for hiding and revealing answers to practice problems.


## Installation
```julia
Pkg.clone("git@github.com:sisl/Revealables.jl.git")
Pkg.build("Revealables")
```

Installation requires standard IPython and IJulia installation with default directory structure.

## Use
Hide and show blocks of HTML through code like this:

```julia
revealable("""<p>Any HTML can go here!</p>""", "classNameForCSS")
```

Please see the [example notebook](example/Show and Hide Answers!.ipynb) for more details.
