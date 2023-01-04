[ -e .profile ] && ln -f -s ${PWD}/.profile ~/.profile && printf "\n\n. ~/.profile\n" >> ~/.bashrc
[ -e .vimrc ] && ln -f -s ${PWD}/.vimrc ~/.vimrc
# [ ! -z "${GITHUB_USER}" ] && [ "${GITHUB_USER}" = "kalaspuff" ] && [ -e .gitconfig ] && ln -f -s ${PWD}/.gitconfig ~/.gitconfig
