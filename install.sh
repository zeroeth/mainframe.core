#!/bin/bash

read -p "rm/git: install/replace Vundle? " replace_vundle

if [ $replace_vundle == "y" ]; then
	rm -rI .vim/bundle/Vundle.vim
	git clone https://github.com/gmarik/Vundle.vim.git .vim/bundle/Vundle.vim
fi

ln -si $PWD/.vimrc $HOME/
ln -si $PWD/.bash_profile $HOME/
ln -si $PWD/.vim $HOME/
