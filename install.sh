#!/bin/sh
if [ ! -d ~/.config/nvim ]; then
  mkdir -p ~/.config/nvim
fi
ln -sf $(cd $(dirname $0) && pwd)/init.vim ~/.config/nvim/init.vim
ln -sf $(cd $(dirname $0) && pwd)/vimrc ~/.vimrc
