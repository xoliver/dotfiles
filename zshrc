# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="muse"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github vagrant zsh-syntax-highlighting git-flow brew pip taskwarrior tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

export TERM=screen-256color

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/Users/xavier/bin:/usr/local/opt/go/libexec/bin"
# export MANPATH="/usr/local/man:$MANPATH"
export GOPATH="/usr/local/Cellar/go/1.3.1/"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# python virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export PYTHONDONTWRITEBYTECODE=1

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias rmbk='find . -name "*.pyc" -delete'
alias sl='sl -aF'

alias gitk='/Applications/GitX.app/Contents/MacOS/GitX'
alias gitx='/Applications/GitX.app/Contents/MacOS/GitX'
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

### Added by the Heroku Toolbelt
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
	curl http://wttr.in/"$location";
}

moon() {
	# Retrieve moon information based on that amazing website
	# Optional argument: date (YYY-MM-DD)
	if [ "$#" -ne 1  ]; then
		date=""
	else
		date="$1"
	fi
	curl http://wttr.in/Moon@$date;
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
