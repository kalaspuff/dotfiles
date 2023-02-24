[ -e .profile ] && ln -f -s ${PWD}/.profile ~/.profile && printf "\n\n. ~/.profile\n" >> ~/.bashrc
[ -e .vimrc ] && ln -f -s ${PWD}/.vimrc ~/.vimrc
# [ ! -z "${GITHUB_USER}" ] && [ "${GITHUB_USER}" = "kalaspuff" ] && [ -e .gitconfig ] && ln -f -s ${PWD}/.gitconfig ~/.gitconfig

! which exa > /dev/null && [ "$(whoami)" = "root" ] && which apt-get && apt-get install exa
! which exa > /dev/null && [ "$(whoami)" = "vscode" ] && which apt-get && sudo apt-get install exa
