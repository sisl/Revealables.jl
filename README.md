# Revealables

[![Build Status](https://github.com/sisl/Revealables.jl/workflows/CI/badge.svg)](https://github.com/sisl/Revealables.jl/actions)
[![codecov](https://codecov.io/gh/sisl/Revealables.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/sisl/Revealables.jl)

This module allows Markdown (and most HTML) to be hidden and revealed by pressing a button in an Jupyter notebook. You can also encode and decode the content using a Caesar cipher.

`Revealables` is useful for hiding and revealing answers to practice problems. When you choose, you can give students the password so they can decode the answers.

## Installation
```julia
] add Revealables
```

You will generally want to use Revealables.jl with the [hide_input](http://jupyter-contrib-nbextensions.readthedocs.io/en/latest/nbextensions/hide_input/readme.html) Jupyter extension installed. This extension hides the code cells. Revealables will reveal the output when a button is pressed. If the extension is not installed, then the code will not be hidden. You can unhide the code cells by clicking on the chevron-up icon.

Instructions for installing Jupyter extensions can be found [here](https://github.com/ipython-contrib/jupyter_contrib_nbextensions/wiki/Home-4.x-(Jupyter)). If you are using [anaconda](https://www.continuum.io/downloads), which supplies the [conda](https://conda.io/docs/) command, you can run the following:
```
conda install -c conda-forge jupyter_contrib_nbextensions
```
Then you must run:
```
jupyter contrib nbextension install --user
jupyter nbextension enable hide_input/main
```

## Use
Hide and show blocks of Markdown through code like this:

```julia
revealable("""Any Markdown can go here!""", "Button Label")
```

Please see the [example notebook](doc/example.ipynb) for more detail.
