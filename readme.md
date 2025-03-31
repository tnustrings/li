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

in your ~/.bash_profile (or comparable file), source `li.sh`:

```
source ~/path/to/li/li.sh
```

then source the `.bash_profile` for the changes to take effect.

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