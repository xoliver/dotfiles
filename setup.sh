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
