# Revealables

This module allows Markdown (and most HTML) to be hidden and revealed by pressing a button in an IJulia notebook. You can also encode and decode the content using a Caesar cipher.

`Revealables` is useful for hiding and revealing answers to practice problems. When you choose, you can give students the password so they can decode the answers.

## Installation
```julia
Pkg.add("Revealables")
Pkg.build("Revealables")
```

Normal installation requires standard IPython (version 3 or higher) and IJulia installation with default directory structure.

## Use
Hide and show blocks of Markdown through code like this:

```julia
revealable("""Any Markdown can go here!""", "Button Label")
```

Please see the [example notebook](example/Show and Hide Answers!.ipynb) for more details.
