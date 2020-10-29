export SSH_ENV="$HOME/.ssh/env"
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
export CLICOLOR=1
export LSCOLORS="exfxcxdxcxegedabagacad"
export PS1="\\[\\033[00m\\]\\[\\033[01;32m\\]\\u@\\H\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\\$ "
export PS1="\\[\\e]0;\\u@\\h: \\w\\a\\]\\[\\e]0;\\u@darkness: \\w\\a\\]\${debian_chroot:+(\$debian_chroot)}\\[\\033[01;32m\\]\\u@darkness\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\\$ "

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Docker-nice-to-haves
alias docker-remove-dangling='docker rmi $(docker images --filter="dangling=true" -aq) --force'
export DOCKER_DEV_NETWORK=

function di() {
    if [ $# -eq 0 ]; then
        docker images
    else
        docker images | grep $1
    fi
}

function dps() {
    if [ $# -eq 0 ]; then
        docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}"
    else
        docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}" | grep $1
    fi
}

function dsh() {
    docker exec -it $1 /bin/bash
}

function zz4711_-docker-create-dev-network() {
    [ "$$(docker network ls -f name=$DOCKER_DEV_NETWORK -q)" ] || docker network create --driver bridge $DOCKER_DEV_NETWORK
}

# Misc pasteboard shenanigans
alias pbjq='pbpaste | jq'
alias phpunserialize='php -r "echo json_encode(unserialize(stream_get_contents(STDIN)));" | jq'

# Python in Docker / ease-of-access
export DOCKER_BASE_IMAGE_PYTHON=
export DOCKER_BASE_DEV_IMAGE_PYTHON=
alias pybase='docker run --entrypoint "" -ti `if [ -d ${PWD}/app ]; then echo -n "-v ${PWD}/app:/app"; fi` -v ${PWD}:/vol -w /vol --network=$DOCKER_DEV_NETWORK -e CONFIG_DATA="`(if [ -e config.json ]; then cat config.json; else if [ -e config.example.json ]; then cat config.example.json; fi; fi)`" -e DEVLOG=1 -e PYTHONPATH=app/src:src:/vol/app/src $DOCKER_BASE_IMAGE_PYTHON /bin/bash'
alias pydev='docker run --entrypoint "" -ti `if [ -d ${PWD}/app ]; then echo -n "-v ${PWD}/app:/app"; fi` -v ${PWD}:/vol -w /vol --network=$DOCKER_DEV_NETWORK -e CONFIG_DATA="`(if [ -e config.json ]; then cat config.json; else if [ -e config.example.json ]; then cat config.example.json; fi; fi)`" -e DEVLOG=1 -e PYTHONPATH=app/src:src:/vol/app/src $DOCKER_BASE_DEV_IMAGE_PYTHON /bin/bash'

# Code interpreters
alias haskell='docker run -ti haskell ghci'
alias julia='docker run -ti julia'

# 'c' => 'cd'
alias c='cd'

# 'ls' => 'ls -la'
alias ls='ls -la'

# Over the years, I learned that I'm apparently bad at typing 'make'
alias mkae='make'
alias maek='make'
alias mkea='make'
alias kame='make'
alias amek='make'
alias maker='make'
alias mae='make'
alias mak='make'
alias meka='make'

# Over the years, I learned that I'm understandibly bad at typing 'ls'
alias ls-la='ls'
alias lsa-l='ls'
alias sl='ls'

# Over the years, I learned that I'm unforgetfully bad at typing 'python'
alias pthon='python'
alias pytohn='python'
alias pythn='python'
alias pythno='python'
alias pythnom='python'
alias pyhtn='python'
alias pytho='python'
alias pytn='python'
alias pyth='python'

# Over the years, I learned that I'm also bad at typing 'docker'
alias ocker='docker'
alias dokcer='docker'
alias dokce='docker'
alias dcoker='docker'
alias dockere='docker'
alias doker='docker'
alias docer='docker'
alias dokcker='docker'
alias docke='docker'

# Over the years, I learned that I'm somewhat bad at typing 'git'
alias igt='git'
alias gti='git'
alias ig='git'
alias tig='git'

# Over the years, I learned that I'm really bad at typing 'kubectl'
alias kubbectl='kubectl'
alias kube='kubectl'
alias kubbe='kubectl'
alias kuebctl='kubectl'
alias kubebctl='kubectl'
alias kubeclt='kubectl'
alias kuebb='kubectl'
alias kueb='kubectl'
alias kuebclt='kubectl'
alias kbe='kubectl'
alias kbu='kubectl'
alias kbuctl='kubectl'
alias kbuectl='kubectl'
alias kbel='kubectl'
alias cubectl='kubectl'
alias kubb='kubectl'
alias kbuelt='kubectl'
alias kubelt='kubectl'

# Over the years, I learned that I'm whatgrnnant~~ bad at typing 'vagrant'
alias vagrnat='vagrant'
alias vargnat='vagrant'
alias vagnrat='vagrant'
alias vagrnt='vagrant'
alias vagrnat='vagrant'
alias vangrat='vagrant'
alias vagntr='vagrant'
alias varngt='vagrant'
alias vargtn='vagrant'
