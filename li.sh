li() {
    a_flag=''
    while getopts 'a' flag; do # for non-boolean flags follow flag letter by colon
	case "${flag}" in
	    a) a_flag='true' ;;
	esac
    done
    if [[ $# > 0 ]]; then
	# if not a directory, return? 
	if [[ ! -d $1 ]]; then
	    return
	fi
	where=$1/*
    else
	where=*
    fi
    for f in $where; do
	# is f a directory?
	if [[ -d $f ]]; then
            	    file=$(ls -1 ${f}/index.txt ${f}/readme.* ${f}/Readme.* ${f}/README.* ${f}/readme ${f}/Readme ${f}/README -R 2>/dev/null | head -1) # ls -1: one by line
                  	    if [[ -f $file ]]; then
                            
                            		basename=$(basename $f)
                            		echo -n "$basename: "
                            		egrep "^\w" --max-count 1 $file
                        else
                            		if [[ $a_flag == "true" ]]; then
                            		    echo $f
                            		fi
                        fi
        fi
    done
}
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
