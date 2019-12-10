# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="muse"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
	brew
	colored-man-pages
	docker
	git
	github
	git-flow
	grc
	jira
	httpie
	pip
	taskwarrior
	tmux
	vagrant
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

export TERM=screen-256color

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/Users/xavier/bin:/usr/local/opt/go/libexec/bin"
export GOPATH="/usr/local/Cellar/go/1.3.1/"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias rmbk='find . -name "*.pyc" -delete'
alias sl='sl -aF'
alias pbj='pbpaste | jq .'
alias pbjc='pbpaste | jq . | pbcopy'

alias prp='pipenv run python'

alias gitk='/Applications/GitX.app/Contents/MacOS/GitX'
alias gitx='/Applications/GitX.app/Contents/MacOS/GitX'
alias gcod='gco develop'
alias gcom='gco master'
alias gst='git status -sb'
alias sub='/Applications/Sublime\ Text\ 2.app/Contents/MacOS/Sublime\ Text\ 2'
alias tmux='tmux -2'  # Colours!
alias sz='source ~/.zshrc'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'

alias q='make quicktest'

if [[ `ssh-add -l` != *id_rsa* ]]
then
	echo "Adding ssh key to ssh-agent"
	ssh-add ~/.ssh/id_rsa
fi

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

weather() {
	# Retrieve weather information based on that amazing website
	# Optional argument: airport code or city name
	if [ "$#" -ne 1  ]; then
		location="edinburgh"
	else
		location="$1"
	fi
	curl "http://wttr.in/$location?m";
}

moon() {
	# Retrieve moon information based on that amazing website
	# Optional argument: date (YYYY-MM-DD)
	if [ "$#" -ne 1  ]; then
		date=""
	else
		date="$1"
	fi
	curl http://wttr.in/Moon@$date;
}

gdone() {
	branch=$(git symbolic-ref --short HEAD)
	gcom
	git pull
	gcod
	git pull
	gb -d $branch
	git remote prune origin
}

# Make sure fzf uses ag so git/svn/hg ignores are taken into account
export FZF_DEFAULT_COMMAND='ag -g ""'  # Default use case
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND  # CTRL+T shortcut
_fzf_compgen_path() {  # ** completion
	ag -g "" "$1"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Terminal markers (bookmarks): https://github.com/pindexis/marker#installation
export MARKER_KEY_MARK="\C-v"  # Stop using CTRL+K for this - add stuff with "marker mark"
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"
# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

# run to specified command
# zsh completion in ~/.oh-my-zsh/completions/_runto
runto() {
	if [ "$#" -ne 1 ]
	then
		echo "You need to specify where to run to"
		return
	fi

	local file=~/.runto/$1.sh
	if [[ -r  ${file} ]]
	then
		echo "Running to $1!"
		. $file
	else
		echo "Cannot run to $1, not found!"
	fi
}

# Codi
# Usage: codi [filename]  (was [filetype] [filename])
codi() {
  # local syntax="${1:-python}")
  # shift
  local syntax="python" # (was local syntax="${1:-python}")
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
