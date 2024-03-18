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
echo "Setting up tpm (vim plugin manager)"
mkdir -p ~/.tmux/plugins
rm -rf ~/.tmux/plugins/tpm
git clone --quiet https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Folders and configs, mostly under application support
# .aws (TODO)
# .pip
# .m2 (at least config)
# slack
# iterm2 (didn't work) -> JSON!
# datagrip, idea, pycharm
# .zshrc.local
# Any work related dotfiles (.curative?)
# .zshrc.secrets ?

# Catalan keyboard for Mac: https://github.com/nadalsol/catalan-keyboard-layout-mac

# Hammerspoon SpoonInstall:
echo "Setting up SpoonInstall"
mkdir -p ~/.hammerspoon/Spoons
pushd ~/.hammerspoon/Spoons &> /dev/null
wget -q https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip
rm -rf SpooinInstall.spoon
unzip -fq SpoonInstall.spoon.zip
rm -f SpoonInstall.spoon.zip
popd &> /dev/null
echo "ACTION REQUIRED: reload Hammerspoon"
mkdir -p ~/.hammerspoon/Spoons/Shortcuts.spoon
ln -sf `pwd`/Shortcuts.spoon.init.lua ~/.hammerspoon/Spoons/Shortcuts.spoon/init.lua
echo "ACTION REQUIRED: edit ~/.hammerspoon/shortcuts.csv"

# See https://shyr.io.blog/sync-iterm2-configs
echo "Syncing iTerm2 config"
ln -sf `pwd`/iterm2 ~/.iterm2
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Ensure fzf is set up
echo "Setting up fzf if not already there"
[ -f ~/.fzf.zsh ] || $(brew --prefix)/opt/fzf/install

# install nvm and install default version
# install vim plug
# download vim colourtheme
# set up pyenv, pipx (awscli, pipenv)
# iTerm setup so that option+right/left can move words and mark lef option as ESC+ so we can alt+backspace to delete words
# https://stackoverflow.com/questions/2212203/moving-a-word-forward-in-z-shell/41030092#41030092
#
# * Run fzf installer as provided by brew to incorporate in the shell (zshrc already calls it)
