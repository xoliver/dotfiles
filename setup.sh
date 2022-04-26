#env sh

echo "Creating symlinks to config files"
ln -sf `pwd`/bashrc ~/.bashrc
ln -sf `pwd`/Brewfile ~/Brewfile
ln -sf `pwd`/zshrc ~/.zshrc
ln -sf `pwd`/zshrc.fun ~/.zshrc.fun
ln -sf `pwd`/vimrc ~/.vimrc
ln -sf `pwd`/tmux.conf ~/.tmux.conf
ln -sf `pwd`/gitconfig ~/.gitconfig
mkdir -p ~/.hammerspoon
ln -sf `pwd`/init.lua ~/.hammerspoon/init.lua
mkdir -p ~/.config/karabiner/
ln -sf `pwd`/karabiner.json ~/.config/karabiner/karabiner.json
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Folders and configs, mostly under application support
# viscosity
# .ssh
# .aws (TODO)
# .pip
# .m2 (at least config)
# slack
# iterm2 (didn't work)
# shiftit (didn't work)
# datagrip, idea, pycharm
# authy

# Catalan keyboard for Mac: https://github.com/nadalsol/catalan-keyboard-layout-mac

# install nvm and install default version
# install vim plug
# download vim colourtheme
# set up pyenv, pipx (awscli, pipenv)
# iterm option+right/left to move words: https://stackoverflow.com/questions/2212203/moving-a-word-forward-in-z-shell/41030092#41030092
# ALSO mark left option as ESC+ to be able to have alt+backspace delete word and not character
