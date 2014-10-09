Mainframe.Core
--------------

![mainframe](mainframe.jpg)

Dotfiles for vim and git. Friendly to Backbone.js projects, Arduino and Ruby.

#### Installation

Git clone, then run `install-mainframe` from inside this directory.

#### Useful Commands

`git-branch-status` show which branches are ahead and behind one another.
`git-directory-status` a github like status of the last changes to all folders/files inside the current directory.
`ll` (el-el) show only symlinks in current directory.
`p` quick access to most recent directories under *~/Projects*

A set of two functions to locate files:
`search_file_names [text]` return files with *[text]* in their names.
`search_file_content [text]` return files with *[text]* in their contents.

A set of three to take the above lists and modify their content/names:
`replace_file_content [match] [replace]` Replace *[match]* with *[replace]* in files.
`rename_files [match] [replace]` Replace *[match]* with *[replace]* in file names.
`copy_and_rename_files [match] [rename]` Copy to new files, replacing *[match]* with *[rename]* in their file name.

Example use: *search_file_names "cat" | replace_file_content "food" "spaceship"* would replace all 'food' with 'spaceship' in files with cat in their name.


Some often used git shortcuts:
`gap` git add --patch
`gc` git commit
`gp` git push
`gs` git status
`gdl` git detail log, single lines each
`gnl` git log showing file addition/removal
`gfl [file]` git log of a single files changes over time