[ -e .profile ] && ln -f -s ${PWD}/.profile ~/.profile && printf "\n\n. ~/.profile\n" >> ~/.bashrc
[ -e .vimrc ] && ln -f -s ${PWD}/.vimrc ~/.vimrc
