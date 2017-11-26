#env sh

echo "Creating symlinks to config files"
ln -sf bashrc ~/.bashrc
ln -sf Brewfile ~/Brewfile
ln -sf zshrc ~/.zshrc
ln -sf vimrc ~/.vimrc
ln -sf tmux.conf ~/.tmux.conf
ln -sf gitconfig ~/.gitconfig
mkdir -P ~/.config/karabiner/
ln -sf karabiner.json ~/.config/karabiner/karabiner.json
