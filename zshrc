# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="muse"

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
	gradle
	# jira
	httpie
	pip
	ssh-agent
	taskwarrior
	thefuck  # Esc x2 to correct previous command
	tmux
	vagrant
	# zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

export TERM=screen-256color

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
alias pbj='pbpaste | jq --sort-keys .'
alias pbjc='pbpaste | jq --sort-keys . | pbcopy'

alias prp='pipenv run python'

alias jq='jq --sort-keys'
alias gcoi='gco $(git branch | fzf --height=20% --layout=reverse --border)'
alias gcod='gco develop'
alias gcom='gco master &> /dev/null || gco main'
alias gst='git status -sb'
alias ghprv="gh pr view --web"
alias sub='/Applications/Sublime\ Text\ 2.app/Contents/MacOS/Sublime\ Text\ 2'
alias tmux='tmux -2'  # Colours!
alias sz='source ~/.zshrc'
alias vz='vim ~/.zshrc'
alias vzl='vim ~/.zshrc.local'
alias vt='vim ~/.tmux.conf'
alias vv='vim ~/.vimrc'

# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

gdone() {
	branch=$(git symbolic-ref --short HEAD)
	gcom
	git pull
	# gcod
	# git pull
	gb -d $branch
	git remote prune origin
}

# Make sure fzf uses ag so git/svn/hg ignores are taken into account
export FZF_DEFAULT_COMMAND='rg -g ""'  # Default use case
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND  # CTRL+T shortcut
_fzf_compgen_path() {  # ** completion
	ag -g "" "$1"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

count() {
	if [ "$#" -ne 1 ]
	then
		echo "You need to specify a location"
		return
	fi

	if [[ -d $1 ]]
	then
		ls $1 | wc -l
	else
		echo "Path not found"
	fi
}


[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

if [[ `ssh-add -l` != *id_rsa* ]]
then
	echo "Adding ssh key to ssh-agent"
	ssh-add --apple-use-keychain ~/.ssh/id_ed25519
fi

eval $(thefuck --alias)

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

# Pet - CLI snippet manager (https://github.com/knqyf263/pet)
# Shortcut to search
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER" --color)
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^n' pet-select
# Function to register previous command
function pet-remember() {
	PREV=$(fc -lrn | head -n 1)
	sh -c "pet new -t `printf %q "$PREV"`"
}

[ -f ~/.zshrc.secrets ] && source ~/.zshrc.secrets
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.zshrc.fun ] && source ~/.zshrc.fun
