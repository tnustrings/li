# paste this into your ~/.bash_profile

# li lists directories along with a description line from their index.txt or readme.md
# the description line is the first line starting with a word character.
# -a (all) flag: list also the directories with no index.txt or readme.md
# issue: ignores arguments
li() {
    # look for a -a (all) flag with getopts
    # see https://stackoverflow.com/a/21128172 
    a_flag=''
    while getopts 'abf:v' flag; do
	case "${flag}" in
	    a) a_flag='true' ;;
	esac
    done

    # is an argument given?
    if [[ $# > 0 ]]; then
	# if not a directory, return? 
	if [[ ! -d $1 ]]; then
	    return
	fi
	where=$1/*
    else
	where=*
    fi
    
    # go through the files
    for f in $where; do
	# is f a directory?
	if [[ -d $f ]]; then

	    # we'd like to include a range of readme capitalization patterns
	    # there is no ls with case-insensitive option
	    # listing all files and grep -i "readme" makes it slow.
	    # so maybe ls and take the first (but is that really quicker?)
	    
	    # redirect 'file not found' stderrs to /dev/null.
	    # ls returns the files sorted alphabetically
	    file=`ls -1 ${f}/index.txt ${f}/readme.* ${f}/Readme.* ${f}/README.* ${f}/readme ${f}/Readme ${f}/README -R 2>/dev/null | head -1` # ls -1: one by line
	    # echo "file: " $file
	    # is there and index.txt?
	    if [[ -f $file ]]; then
		# get the name without path
		basename=`basename $f`
		echo -n "$basename: "
		# print the first non-heading line (the first line starting with a word character)
		egrep "^\w" --max-count 1 $file
	    else
		# no index.txt or readme
		# if -a (all) flag, print dir (file also?)
		if [[ $a_flag == "true" ]]; then
		    echo $f
		fi
	    fi
	fi
    done
}

# ci changes directory and shows li
ci() {
    # cd into the given directory
    cd "$1"
    # show li
    li
}

# i: show index.txt or readme.md with less
i() {
    # if there's one of the listed files, show the first
    # f=`exst index.txt readme.* README.* readme README Readme Readme.*`

    # we'd like to include a range of readme capitalization patterns
    # there is no ls with case-insensitive option
    # listing all files and grep -i "readme" makes it slow.
    # so maybe ls and take the first (but is that really quicker?)
	    
    # redirect 'file not found' stderrs to /dev/null.
    # ls returns the files sorted alphabetically
    f=`ls -1 index.txt readme.* Readme.* README.* readme Readme README -R 2>/dev/null | head -1` # ls -1: one by line

    # -f: check that f is a file
    if [[ -f $f ]]; then
	clear # so that print starts at the top of the screen
	cat $f |
	    { if [ -f ~/.i_md ]; then ~/.i_md; else cat -; fi } | # if script for markdown-rendering there, use it
	    less --quit-if-one-screen # --clear-screen: start printing at the top of the screen
    fi
}
