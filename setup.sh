#env sh

echo "Creating symlinks to config files"
ln -sf `pwd`/bashrc ~/.bashrc
ln -sf `pwd`/Brewfile ~/Brewfile
ln -sf `pwd`/zshrc ~/.zshrc
ln -sf `pwd`/vimrc ~/.vimrc
ln -sf `pwd`/tmux.conf ~/.tmux.conf
ln -sf `pwd`/gitconfig ~/.gitconfig
mkdir -p ~/.config/karabiner/
ln -sf `pwd`/karabiner.json ~/.config/karabiner/karabiner.json


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
