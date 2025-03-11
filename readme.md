# li

list index (or readme)

```
$ li
codetext: code with text
tagid: languages word by word
tagid-chrome: languages word by word chrome extension
...
```

## commands

`li`: list directories with the first non-heading line from their index.txt or readme\
`ci`: cd followed by li\
`i`: show index.txt or readme\

## setup

paste the code from .bash_profile in your ~/.bash_profile (or comparable
file), then say:

```
source ~/.bash_profile
```

## more options

`li -a`: list all directories, not just those containing an index.txt
or readme.

to customize markdown rendering for `i`, create a file named ~/.i_md
and put in the markdown rendering command, e.g.

```
pandoc -t plain
```