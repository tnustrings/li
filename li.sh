li() {
    
    is a dir given, we run li for the given dir, else we run it for the
    current dir.
    
    go through the files, take the directories and see if there's an
    index.txt / readme in them.
    
    we'd like to include a range of readme capitalization patterns, but
    there is no case-insensitive ls. listing all files and grep -i
    "readme" makes it slow. so maybe ls and take the first (but is that
    really quicker?)
    
    redirect 'file not found' stderrs to /dev/null.
    
    ls returns the files sorted alphabetically.
    
    is the index/readme is there, print the directory name without path
    (basename) and followed by the first non-heading line from the
    index/readme (the first line starting with a word character).
    
    ``./there:
    
    		basename=$(basename $f)
    		echo -n "$basename: "
    		egrep "^\w" --max-count 1 $file
    ``                
    
    if the index/readme is not there, and the -a flag is set, print the directory.
    
    ``../not there:
    		if [[ $a_flag == "true" ]]; then
    		    echo $f
    		fi
}

look for a -a (all) flag with getopts
see https://stackoverflow.com/a/21128172
ci() {
    # cd into the given directory
    cd "$1"
    # show li
    li
}
i() {
    f=$(ls -1 index.txt readme.* Readme.* README.* readme Readme README -R 2>/dev/null | head -1) # ls -1: one by line
    if [[ -f $f ]]; then
	clear # so that print starts at the top of the screen
	cat $f |
	    { if [ -f ~/.i_md ]; then ~/.i_md; else cat -; fi } | # if script for markdown-rendering there, use it
	    less --quit-if-one-screen # --clear-screen: start printing at the top of the screen
    fi
}
