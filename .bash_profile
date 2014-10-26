# Helper for conditional inclusion of features.
function command_exists() {
	# or: hash gdate 2>/dev/null
	type "$1" &> /dev/null ;
}

export CLICOLOR=1

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

pip-global() {
	   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

export WORKON_HOME=$HOME/.virtualenvs


alias svndiff='svn diff --diff-cmd diffwrap.sh'
alias less='less --raw'

if command_exists ack-grep
then
	alias ack='ack-grep'
fi

# -I is enough to ignore vim swap files because they are binary
alias grep='grep --exclude-dir=.git -I --color=auto'

# Symlink helpers
alias pwdp='pwd;pwd -P'
alias ll='ls -al | grep "\->"'

# Git shorthand
alias gc='git commit'
alias gap='git add --patch'
alias ga='git add'
alias gs='git status'
alias gp='git push'
alias gsl="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gdl="git log --all --date=short --pretty=format:'%Cred%h%Creset %Cgreen%cd%Creset %C(bold blue)%<(12,trunc)%an%Creset%C(yellow)%d%Creset %s%Creset' --abbrev-commit"
alias gnl="git log --name-status"
alias gfl="git log --follow --patch --"
alias gpl="git log --patch --stat --dirstat"

alias git-log-formats="echo gsl, gdl, gnl, gfl <file>, gpl"

alias git-list-untracked="git ls-files --others --exclude-standard"
alias git-list-modified="git ls-files --modified --exclude-standard"

# Git SVN
alias gdc='git stash && git svn dcommit && git stash pop'
alias git-svn-sync='git svn rebase && git fetch origin && git rebase origin/master && git push'
alias git-ignores='find *.gitignore -type f -exec printf "\n# %s\n" {} \; -exec cat {} \;'

# Php app stuff
alias apachelog='lnav /var/log/apache2/access_log'

# Heroku
alias gph='git push && git push heroku master'
alias hon='heroku ps:scale app=1'
alias hoff='heroku ps:scale app=0'


### File utilities for refactoring/duplicating similar scripts

# Search for files by name
search_file_names() {
	if [ $# -gt 1 ]
	then
		location="${@:2}"
	else
		location="."
	fi
	find $location -not -name "*.sw*" -name "*$1*" -exec echo "{}" \;
}


# Search for files by content
search_file_content() {
	if [ $# -gt 1 ]
	then
		location="${@:2}"
	else
		location="."
	fi

	grep -lr --color=never $1 $location
}


# Replace content in files
replace_file_content() {
	search_text=$1
	replace_text=$2

	IFS=$'\n' read -d '' -r -a filenames
	for file_name in "${filenames[@]}"; do
		sed -i -e "s/$search_text/$replace_text/g" $file_name
	done
}

# Replace file name
rename_files() {

	search_text=$1
	replace_text=$2

	IFS=$'\n' read -d '' -r -a filenames
	for file_name in "${filenames[@]}"; do
		new_name=$(echo "$file_name" | sed -e "s/$search_text/$replace_text/g")
		# FIXME this does not stop, but it does show you it didn't overwrite
		mv -i "$file_name" "$new_name"
	done
}

# Copy files with rename
copy_and_rename_files() {
	# Clever example :|
	# find . -name "*from*" -exec bash -c 'echo $0 ${0/${from}/${to}' {} \;

	search_text=$1
	replace_text=$2

	IFS=$'\n' read -d '' -r -a filenames
	for file_name in "${filenames[@]}"; do
		new_name=$(echo "$file_name" | sed -e "s/$search_text/$replace_text/g")
		# FIXME this does not stop, but it does show you it didn't overwrite
		cp -i "$file_name" "$new_name"
	done
}


# Recent project activity, and directory switcher
projects() {
	if [[ $# -eq 0 ]]; then
		FILES=$(ls -t1L ~/Projects/ | head -10)
		printf "Projects:\n"
		select d in $FILES; do test -n "$d" && break; echo ">>> Invalid Selection"; done
		cd ~/Projects/$d && pwd
	else
		cd ~/Projects/$1
	fi
	gs 2>/dev/null
}
alias p=projects


# Local executables
export PATH=./node_modules/.bin:$HOME/npm/bin:$HOME/bin:/usr/local/bin:$PATH

# Virtual Env
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source "/usr/local/bin/virtualenvwrapper.sh"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# GIT
[[ -s "$HOME/bin/git-completion.bash" ]] && source "$HOME/bin/git-completion.bash"

# Colors for scripts
CLR="\[\033[0m\]"    # unsets color to term's fg color

# regular colors
BLK="\[\033[0;30m\]"    # black
RED="\[\033[0;31m\]"    # red
GRN="\[\033[0;32m\]"    # green
YLW="\[\033[0;33m\]"    # yellow
BLU="\[\033[0;34m\]"    # blue
MGN="\[\033[0;35m\]"    # magenta
CYN="\[\033[0;36m\]"    # cyan
WHT="\[\033[0;37m\]"    # white

# emphasized (bolded) colors
EBLK="\[\033[1;30m\]"
ERED="\[\033[1;31m\]"
EGRN="\[\033[1;32m\]"
EYLW="\[\033[1;33m\]"
EBLU="\[\033[1;34m\]"
EMGN="\[\033[1;35m\]"
ECYN="\[\033[1;36m\]"
EWHY="\[\033[1;37m\]"

# background colors
BGBLK="\[\033[40m\]"
BGRED="\[\033[41m\]"
BGGRN="\[\033[42m\]"
BGYLY="\[\033[43m\]"
BGBLU="\[\033[44m\]"
BGMGN="\[\033[45m\]"
BGCYN="\[\033[46m\]"
BGWHT="\[\033[47m\]"

function rvm_symbol {
  if command_exists rvm-prompt ; then
	  #rvm-prompt u
	  rvm-prompt v
  fi
}

function rvm_gemset {
  if command_exists rvm-prompt ; then
	  rvm-prompt g
  fi
}

function date_display {
  date +%H:%M:%S
}
# Outputs the current trunk, branch, or tag
svn_branch() {
    local url=
	url=`svn info 2> /dev/null | awk '/URL:/ {print $2}'`
	if [[ $url =~ trunk ]]; then
		echo trunk
	elif [[ $url =~ /branches/ ]]; then
		echo $url | sed -e 's#^.*/\(branches/.*\)/.*$#\1#'
	elif [[ $url =~ /tags/ ]]; then
		echo $url | sed -e 's#^.*/\(tags/.*\)/.*$#\1#'
	fi
}

# Outputs the current revision
svn_rev() {
    local r=$(svn info 2> /dev/null | awk '/Revision:/ {print $2}')

	local svnst flag
	svnst=$(svn status 2> /dev/null | grep '^\s*[?ACDMR?!]')
	[ -z "$svnst" ] && flag=''
	r=$r$flag
    echo $r
}

function svn_prompt {
	echo $(svn_branch) $(svn_rev) | sed -e 's/.*/ (&)/;s/()//;s/\ $//'
}

function git_prompt {
    \git rev-parse --git-dir &> /dev/null
    git_status="$(git status 2> /dev/null)"
	branch_pattern="On branch ([^${IFS}]*)"
	remote_pattern="Your branch is (.*) (of|with)"
    diverge_pattern="Your branch and (.*) have diverged"
    if [[ ! ${git_status}} =~ "working directory clean" ]]; then
		state="${RED}/" #⚡
    fi
    # add an else if or two here if you want to get more specific
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
      if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
        remote="${YLW}+" #↑
      else
        remote="${YLW}-" #↓
      fi
    fi
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
      remote="${YLW}%" #↕
    fi
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
      branch=${BASH_REMATCH[1]}
	  echo "%${branch}${remote}${state}"
    fi
}

function virtualenv_prompt () {
  if [[ -n "$VIRTUAL_ENV" ]]; then
      echo "&`basename \"$VIRTUAL_ENV\"`"
  fi
}

function ssh_prompt () {
	if [[ -n "$SSH_CONNECTION" ]]; then
		echo "|^| "
	fi
}

# TODO decision to use utf-8 chars vs latin vs upper ascii
# TODO move from echos to setting multiple variables (or break up into smaller functions for git)
function proml {

  previous_return_value=$?;
  if test $previous_return_value -eq 0
  then
    status_color=""
  else
    status_color="$RED"
  fi

  title="\[\033]0;\u@\h: \w\007\]"

  # Prompt variations
  #  PS1="$CLR\u@\h:\W$YLW\$(svn_branch)$GRN\$(svn_rev)$MGN\$(git_prompt)$EBLU\$$CLR "
  #  PS1="$CLR$WHT\u$MGN@$EBLK\h:$ECYN\W${YLW}$(svn_prompt)${MGN}$(git_prompt)$BLU\$$CLR "
  #  PS1="$CLR$BLU${status_color}% $WHT\u$MGN@$EBLK\h:$ECYN\W $BLU${status_color}\$$CLR "

  # Options
  #  $(rvm_symbol)        - ruby version info
  #  $(ssh_prompt)        - remote host indication
  #  ${status_color}      - last app exit code value
  #  $(rvm_gemset)        - ruby gem versioning
  #  $(virtualenv_prompt) - python versioning
  #  $(git_prompt)        - branch info

  # TODO detect $LANG or use iconv.. for upper ascii vs unicode

  PS1="${title}$CLR$YLW$(ssh_prompt)$BLU${status_color}≡ $WHT\u$MGN@$EBLK\h:$ECYN\W $EBLK$(rvm_gemset)$CYN$(virtualenv_prompt)$MGN$(git_prompt)$BLU${status_color}\$$CLR "

  PS2='> '
  PS4='+ '
}

PROMPT_COMMAND=proml
