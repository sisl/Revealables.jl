STYLES = "div.hint {  \n    background-color: rgb(255,255,240); \n    margin: 10px;\n    padding: 10px;\n}\ndiv.answer {  \n    background-color: rgb(255,240,255); \n    margin: 10px;\n    padding: 10px;\n}\ndiv.example {  \n    background-color: rgb(240,255,255); \n    margin: 10px;\n    padding: 10px;\n}\ndiv.notes {  \n    background-color: rgb(240,240,255); \n    margin: 10px;\n    padding: 10px;\n}"
IMPORTCSS = "@import url(\"revealables.css\");\n"

# Move hide_input.js to correct location
extdir = readall(`ipython locate nbextensions`)[1:end - 1]
profiledir = readall(`ipython locate profile julia`)[1:end - 1]
download("https://raw.githubusercontent.com/ipython-contrib/IPython-notebook-extensions/master/usability/hide_input.js", Pkg.dir(extdir,"nbextensions","hide_input.js"))

# Include hide_input.js in JSON for julia profile
run(`ipython --profile julia hide_input_setup.txt`)


# Create and modify CSS files in Julia profile
cssFilename = Pkg.dir(readall(`ipython locate profile julia`)[1:end - 1],"static","custom","custom.css")
touch(cssFilename)
f = open(cssFilename)
lines = readlines(f)
content = join(lines[1:end])
if !contains(content, STYLES) && !contains(content, IMPORTCSS)
    insert!(lines, 1, IMPORTCSS)
    newcssname = Pkg.dir(readall(`ipython locate profile julia`)[1:end - 1],"static","custom","revealables.css")
    touch(newcssname)
    newcssfile = open(newcssname, "w")
    for l in lines
        write(newcssfile, l)
    end
    close(newcssfile)
    cp(newcssname, cssFilename)
    cp("revealables.css", newcssname)
end
close(f)

