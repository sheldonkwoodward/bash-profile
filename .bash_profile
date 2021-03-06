source ~/.profile

#################
### FUNCTIONS ###
#################
# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "${BRANCH}${STAT}"
	else
		echo ""
	fi
}
# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits="> ${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="* ${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+ ${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="? ${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x ${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="! ${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo " "
	fi
}
# git autocomplete
if [ -f ~/.git_completion.sh ]; then
  . ~/.git_completion.sh
fi

##############
### PROMPT ###
##############
# timestamp
### export PS1="\[\033[38;5;9m\]\A\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
export PS1=""
# user/host name
export PS1="$PS1\[\033[38;5;14m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
# current directory
export PS1="$PS1\[\033[38;5;10m\]\w\[$(tput sgr0)\]"
# current git branch
export PS1="$PS1 \[\033[38;5;11m\]\`parse_git_branch\`\[$(tput sgr0)\]"
# prompt end character
export PS1="$PS1> \[$(tput sgr0)\]"
# colors
export CLICOLOR=1
export LSCOLORS=GxBxhxDxfxhxhxhxhxcxcx

###############
### ALIASES ###
###############
alias aswwu="cd ~/Developer/aswwu-web"
alias bp="vim ~/.bash_profile"
alias cat="bat"
alias cdc="cd /"
alias cdcd="cd -"
alias devenv="deactivate"
alias dc="docker-compose"
alias dir="pwd"
alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}\t{{.RunningFor}}"'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias find="fd"
alias gcm="git commit -m"
alias gitclean="git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }' | xargs -r git branch -d"
alias help='tldr'
alias hidden="bash ~/Developer/scripts/bash/hidden.sh"
alias htop="sudo htop"
alias ls="exa -1"
alias lsg="exa -a | grep"
alias lsl="exa -l"
alias lslg="exa -l | grep"
alias makevenv="python3 -m virtualenv .venv"
alias ping="prettyping --nolegend"
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias proj="cd ~/Developer/projects"
alias prp="pipenv run python"
alias prpm="pipenv run python manage.py"
alias pybuild="python3 setup.py sdist bdist_wheel"
alias python="python3"
alias quote="fortune | cowsay -f dragon | lolcat"
alias req="pip3 install -r requirements.txt"
alias reload="source ~/.bash_profile"
alias top="sudo htop"
alias uploadpypi="twine upload -r pypi dist/*"
alias uploadtestpypi="twine upload -r testpypi dist/*"
alias venv="source .venv*/bin/activate"

