#!/bin/bash
# modified by http://github.com/zeroeth for color/alignment
# modified by http://github.com/kortina
# original from http://github.com/jehiah
# this prints out branch ahead/behind status vs origin/master for all branches

# example:
# $ git-branch-status
# dns_check (ahead 1) | (behind 112) origin/master
# master (ahead 2) | (behind 0) origin/master

if [ $# -gt 0 ]
then
	destination=$1
else
	destination="master"
fi

git for-each-ref --format="%(refname:short) %(upstream:short)" refs/ | \
while read local remote
do
    if [ -x $remote ]; then
        branches=("$local")
    else
        branches=("$local" "$remote")
    fi;
    for branch in ${branches[@]}; do
        git rev-list --left-right ${branch}...${destination} -- 2>/dev/null >/tmp/git_upstream_status_delta || continue
        LEFT_AHEAD=$(grep -c '^<' /tmp/git_upstream_status_delta)
        RIGHT_AHEAD=$(grep -c '^>' /tmp/git_upstream_status_delta)

		COLOR="MEOW"
		if [ "$LEFT_AHEAD" -eq "0" ]; then
			if [ "$RIGHT_AHEAD" -eq "0" ]; then
				# NOTHING NEW AND EQUAL
				COLOR="\033[0;35m⚡"
			else
				# NOTHING NEW AND BEHIND
				COLOR="\033[0;33m↓"
			fi;
		else
			if [ "$RIGHT_AHEAD" -eq "0" ]; then
				# NEW AND UP TO DATE
				COLOR="\033[0;32m↑"
			else
				# NEW AND BEHIND
				COLOR="\033[0;31m↕"
			fi;
		fi;
			printf "$COLOR %-30s (ahead %2d) | (behind %4d) %s\n" $branch $LEFT_AHEAD $RIGHT_AHEAD $destination
    done
done  | sort | uniq
#grep -v "^\w* $destination" |
