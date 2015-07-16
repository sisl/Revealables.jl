STYLES = "div.hint {  \n    background-color: rgb(255,255,240); \n    margin: 10px;\n    padding: 10px;\n}\ndiv.answer {  \n    background-color: rgb(255,240,255); \n    margin: 10px;\n    padding: 10px;\n}\ndiv.example {  \n    background-color: rgb(240,255,255); \n    margin: 10px;\n    padding: 10px;\n}\ndiv.notes {  \n    background-color: rgb(240,240,255); \n    margin: 10px;\n    padding: 10px;\n}"
IMPORTCSS = "@import url(\"revealables.css\");\n"
JS =  "// activate extensions only after Notebook is initialized\nrequire([\"base/js/events\"], function (events) {\n$([IPython.events]).on(\"app_initialized.NotebookApp\", function () {\n    /* load your extension here */\n    IPython.load_extensions('hide_input');\n    });\n});"

# Test for IPython 3 (required)
const ipvers = try 
    convert(VersionNumber, chomp(readall(`ipython --version`)))
catch e1
        error("IPython 3 is required for Revealables.\n", "$e1")
end

install = "install"

if ipvers < v"3.0"
    warn("IPython 3 is required for Revealables.
        \nYou have IPython $ipvers. 
        \nThis installer will download hide_input.js to your nbextensions folder, 
        \nbut you will need to manually configure your notebook to include 
        \nit in your notebook extensions.
        \nContinue installation? yes/[no]")
    while install != "yes"
        install = chomp(readline(STDIN))
        if install == "no" || install == ""
            error("Installation cancelled.")
        end
        warn("Continue installation? yes/[no]")
    end
end


# Copy hide_input.js to correct location
println("Please enter the name of the profile you use with IJulia.
    \nLeave blank for default")
profile = chomp(readline(STDIN))
if profile == ""
    profile = "default"
end

extdir = chomp(readall(`ipython locate nbextensions`))
profiledir = chomp(readall(`ipython locate profile $profile`))

download("https://raw.githubusercontent.com/ipython-contrib/IPython-notebook-extensions/master/usability/hide_input.js", Pkg.dir(extdir,"nbextensions","hide_input.js"))


if ipvers >= v"3.0"
    run(`ipython --profile $profile hide_input_setup.txt`)
else
    #open custom.js file, 
    jsFilename = Pkg.dir(profiledir,"static","custom","custom.js")
    touch(jsFilename)
    f = open(jsFilename)
    lines = readlines(f)
    close(f)

    foundextensions = false
    foundhide_input = false
    
    tmpjsname = Pkg.dir(profiledir,"static","custom","tmp.js")
    touch(newjsname)
    tmpjsfile = open(tmpjsname, "w")

    for l in lines
        if foundextensions && (!foundhide_input && chomp(l) == chomp("    });\n"))
            write(tmpjsfile, "    IPython.load_extensions('hide_input');\n")
            foundhide_input = true
        end
        write(tmpjsfile, l)
        if chomp(l) == chomp("$([IPython.events]).on(\"app_initialized.NotebookApp\", function () {\n")
            foundextensions = true
        elseif chomp(l) == chomp("    IPython.load_extensions('hide_input');\n")
            foundhide_input = true
        end
    end
    if !foundextensions
        write(tmpjsfile, JS)
    end
    close(tmpjsfile)
    mv(tmpjsname, jsFilename)
end

# Create and modify CSS files in Julia profile
cssFilename = Pkg.dir(profiledir,"static","custom","custom.css")
touch(cssFilename)
f = open(cssFilename)
lines = readlines(f)
content = join(lines[1:end])
if !contains(content, STYLES) && !contains(content, IMPORTCSS)
    insert!(lines, 1, IMPORTCSS)
    newcssname = Pkg.dir(profiledir,"static","custom","revealables.css")
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
