#!/bin/bash
# modified by https://github.com/zeroeth for clarity, commit count, committer list
# original from https://gist.github.com/Gabro/5883819
# based on http://stackoverflow.com/questions/17359370/git-show-last-commit-date-and-message-for-each-file-in-directory-like-github
#
# Prints out git statistics for each folder similar to githubs file listing, example:
#
# build_osx.sh   -- 11 days ago          b865716 Notes for intalling devil                          (Kevin Alford)
# main.cpp       -- 10 months ago        dc06f98 No fullscreen                                      (Kevin Alford)
# main.h         -- 10 months ago        c16c2f3 sdl open include helper and change number of blobs (Kevin Alford)
# preview.png    -- 5 months ago         370247d Preview image, linux build, ignore compiled obje.. (Kevin Alford)

FILES=`git ls-tree --name-only HEAD .`
MAXLEN=0


# get max file name length for padding
for f in $FILES; do
    if [ ${#f} -gt $MAXLEN ]; then
        MAXLEN=${#f}
    fi
done


for file in $FILES; do

	# total commits in folder
	#commit_count=$(git rev-list --count HEAD $file)
	# using git log just to pretty format and avoid escape codes in the script
	#commit_count=$(git log -1 --decorate --pretty=format:"%C(magenta)(${commit_count})%Creset" $file)

	# %cr commit date relative
	commit_age=$(git log -1 --decorate --pretty=format:"%C(green)%<(20,trunc)%cr%Creset" $file)

	# %h  short commit hash
	# %s  subject
	# %cn commiter name
	commit_info=$(git log -1 --decorate --pretty=format:"%C(cyan)%h%Creset %<(50,trunc)%s %C(yellow)(%cn)%Creset" $file)

	# bash printf %s == string.
	# %16s if you add $commit_count back in after the --
	printf "%-${MAXLEN}s -- %s %s\n" "$file" "$commit_age" "$commit_info"
done