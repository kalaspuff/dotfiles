[ -e .profile ] && ln -f -s ${PWD}/.profile ~/.profile && printf "\n\n. ~/.profile\n" >> ~/.bashrc
[ -e .vimrc ] && ln -f -s ${PWD}/.vimrc ~/.vimrc
# [ ! -z "${GITHUB_USER}" ] && [ "${GITHUB_USER}" = "kalaspuff" ] && [ -e .gitconfig ] && ln -f -s ${PWD}/.gitconfig ~/.gitconfig

if ! which curl > /dev/null; then
    [ "$(whoami)" = "root" ] && which apt-get && apt-get update && apt-get install -y curl
    [ "$(whoami)" = "vscode" ] && which apt-get && sudo apt-get update && sudo apt-get install -y curl
fi

if ! which exa > /dev/null; then
    [ "$(whoami)" = "root" ] && which apt-get && apt-get update && apt-get install -y exa
    [ "$(whoami)" = "vscode" ] && which apt-get && sudo apt-get update && sudo apt-get install -y exa
fi

if ! which gpg > /dev/null; then
    [ "$(whoami)" = "root" ] && which apt-get && apt-get update && apt-get install -y gnupg
    [ "$(whoami)" = "vscode" ] && which apt-get && sudo apt-get update && sudo apt-get install -y gnupg
fi

if ! which gh > /dev/null; then
    [ "$(whoami)" = "root" ] \
        && which apt-get \
        && which apt \
        && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
        && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
        && apt update \
        && apt install gh -y

    [ "$(whoami)" = "vscode" ] \
        && which apt-get \
        && which apt \
        && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
        && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
        && sudo apt update \
        && sudo apt install gh -y
fi
