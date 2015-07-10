STYLES = "div.hint {  \n    background-color: rgb(255,255,240); \n    margin: 10px;\n    padding: 10px;\n}\ndiv.answer {  \n    background-color: rgb(255,240,255); \n    margin: 10px;\n    padding: 10px;\n}\ndiv.example {  \n    background-color: rgb(240,255,255); \n    margin: 10px;\n    padding: 10px;\n}\ndiv.notes {  \n    background-color: rgb(240,240,255); \n    margin: 10px;\n    padding: 10px;\n}"
IMPORTCSS = "@import url(\"reveal-html.css\");\n"

# Move read-only.js to correct location
extdir = readall(`ipython locate nbextensions`)[1:end - 1]
profiledir = readall(`ipython locate profile julia`)[1:end - 1]
download("https://raw.githubusercontent.com/ipython-contrib/IPython-notebook-extensions/95fae02cf0e51a9851bdfe8b54b23ac74d6cbf7c/usability/read-only.js", Pkg.dir(extdir,"nbextensions","read-only.js"))

# Install read-only.js in julia profile
run(`ipython --profile julia < read-only-setup.txt`)


# Create and modify CSS files in Julia profile

#download("fromRemoteURL", "reveal-html.css")
cssFilename = Pkg.dir(readall(`ipython locate profile julia`)[1:end - 1],"static","custom","custom.css")
touch(cssFilename)
f = open(cssFilename)
lines = readlines(f)
content = join(lines[1:end])
if !contains(content, STYLES) && !contains(content, IMPORTCSS)
    insert!(lines, 1, IMPORTCSS)
    newcssname = Pkg.dir(readall(`ipython locate profile julia`)[1:end - 1],"static","custom","reveal-html.css")
    touch(newcssname)
    newcssfile = open(newcssname, "w")
    for l in lines
        write(newcssfile, l)
        println(l)
    end
    close(newcssfile)
    cp(newcssname, cssFilename)
    cp("reveal-html.css", newcssname) # delete later, mv instead
    #mv("reveal-html.css", newcssname)
end
close(f)

