[ -e .profile ] && ln -f -s ${PWD}/.profile ~/.profile && printf "\n\n. ~/.profile\n" >> ~/.bashrc
[ -e .gitconfig ] && ln -f -s ${PWD}/.gitconfig ~/.gitconfig
[ -e .vimrc ] && ln -f -s ${PWD}/.vimrc ~/.vimrc
