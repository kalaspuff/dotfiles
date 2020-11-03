export SSH_ENV="$HOME/.ssh/env"
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/opt/curl-openssl/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/curl-openssl/lib/pkgconfig"
export LDFLAGS="-L/usr/local/opt/curl-openssl/lib"
export CPPFLAGS="-I/usr/local/opt/curl-openssl/include"
export CLICOLOR=1
export LSCOLORS="exfxcxdxcxegedabagacad"
export PS1="\\[\\033[00m\\]\\[\\033[01;32m\\]\\u@\\H\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\\$ "
export USERID=$(id -u)

function _print_shell_notice_start() {
    echo -en "\e[0;37m[\e[1;37mnotice\e[0;37m]\e[00m "
    echo -en "\e[1;36m$1\e[00m"
    echo -en "\e[1;37m:\e[00m "
}

function _print_shell_notice_success() {
    if [ $# -eq 0 ]; then
        echo -e "\e[1;32msuccess\e[00m"
    else
        echo -e "\e[1;32msuccess\e[00m \e[0;32m(\e[1;32m$1\e[0;32m)\e[00m"
    fi
}

function _print_shell_notice_info() {
    if [ $# -eq 1 ]; then
        echo -e "\e[1;34m$1\e[00m"
    else
        echo -e "\e[1;34m$1\e[00m \e[0;34m(\e[1;34m$2\e[0;34m)\e[00m"
    fi
}

function _print_shell_notice_failure() {
    echo -e "\e[1;41mfailure\e[00m"
}

function _print_shell_notice_error() {
    echo -en "\e[1;37;41m[error"'!'"]\e[00m "
    echo -e "\e[1;31m$1\e[00m"
}

function _print_shell_notice_cmd_output() {
    if [[ "$1" == "" ]]; then
        if [ $# -eq 2 ]; then
            echo -e "\e[0;33m## \e[1;33mexit <code: $2> without stdout or stderr output\e[00m "
        else
            echo -e "\e[0;33m## \e[1;33mexit without stdout or stderr output\e[00m "
        fi
    else
        echo -e "$( echo -n "$1" | sed 's/^/\\e[1;33m##\\e[00m /g' )"
        if [ $# -eq 2 ]; then
            echo -e "\e[0;33m## \e[1;33mexit <code: $2>\e[00m "
        else
            echo -e "\e[0;33m## \e[1;33mexit\e[00m "
        fi
    fi
}

function _print_shell_notice_cmd_error() {
    _print_shell_notice_error "cmd '$1' invalid exit <code: $2>"
    if [ $# -eq 3 ]; then
        _print_shell_notice_cmd_output "$3" $2
    fi
}

function jitter_sleep() {
    local python_process=$(if [ -e /usr/local/bin/python3 ]; then echo -n "/usr/local/bin/python3"; else echo -n "/usr/bin/python3"; fi)
    if [ $# -eq 2 ]; then
        $python_process -c "import random; import time; time.sleep(min(float($1), float($2)) + random.random() * (max(float($1), float($2)) - min(float($1), float($2))));" 2> /dev/null > /dev/null
    else
        $python_process -c "import random; import time; time.sleep(float($1) + random.random());" 2> /dev/null > /dev/null
    fi
}

# ssh agent
function _export_ssh_agent_data() {
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
    fi
}

function _is_ssh_agent_running()
{
    if [[ "${SSH_AGENT_PID}" ]] && /bin/ps -p ${SSH_AGENT_PID} -o uid,user,comm | /usr/bin/grep "^\s*$USERID\s\s*$USER\s\s*\(/usr/bin/ssh-agent\|ssh-agent\)\$" > /dev/null; then
        return 0
    fi

    local SSH_AGENT_PID=
    local SSH_AUTH_SOCK=

    _export_ssh_agent_data
    if [[ "${SSH_AGENT_PID}" ]] && /bin/ps -p ${SSH_AGENT_PID} -o uid,user,comm | /usr/bin/grep "^\s*$USERID\s\s*$USER\s\s*\(/usr/bin/ssh-agent\|ssh-agent\)\$" > /dev/null; then
        return 0
    else
        return 1
    fi
}

function _aquire_ssh_agent_lock() {
    local ssh_env_lock="${SSH_ENV:=$HOME/.ssh/env}.lock"
    local start_time=$(/bin/date +%s)
    local lock_pid=
    local lock_time=
    local has_output=

    if _is_ssh_agent_running; then
        return
    fi

    _print_shell_notice_start "awaiting ssh agent lock"

    if [ -e "$ssh_env_lock" ]; then
        lock_time=$(/bin/cat $ssh_env_lock 2> /dev/null | /usr/bin/sed 's/:.*//')
        if ! ([[ "$lock_time" ]] && [ $(($start_time - 60)) -ge $lock_time ]); then
            _print_shell_notice_info "waiting for others" "retry in 1-3 seconds"
            jitter_sleep 1 3
            if ! _is_ssh_agent_running; then
                _aquire_ssh_agent_lock
            fi
            return
        fi
    fi

    echo -n "$start_time:$$" > "$ssh_env_lock"
    _print_shell_notice_info "aquiring lock"
    jitter_sleep 1 3
    lock_pid=$(cat $ssh_env_lock 2> /dev/null | sed 's/.*://')
    if _is_ssh_agent_running || ! [[ "$lock_pid" ]] || ! [ "$lock_pid" -eq "$$" ]; then
        _print_shell_notice_start "awaiting ssh agent lock"
        _print_shell_notice_info "waiting for others" "retry in 1-3 seconds"
        jitter_sleep 1 3
        if ! _is_ssh_agent_running; then
            _aquire_ssh_agent_lock
        fi
        return
    fi
}

function _release_ssh_agent_lock() {
    local ssh_env_lock="${SSH_ENV:=$HOME/.ssh/env}.lock"
    rm -f "$ssh_env_lock" 2> /dev/null > /dev/null
}

function start-ssh-agent() {
    if ! _is_ssh_agent_running; then
        _aquire_ssh_agent_lock
    fi

    _print_shell_notice_start "initializing new ssh agent"

    if _is_ssh_agent_running; then
        _export_ssh_agent_data
        _print_shell_notice_success "pid: $SSH_AGENT_PID"
        _release_ssh_agent_lock
        return
    fi

    if [ ! -e "${SSH_ENV}" ]; then
        /usr/bin/touch "${SSH_ENV}"
        /bin/chmod 600 "${SSH_ENV}"
    fi

    local cmd_output=
    local error_exit_code=

    if cmd_output=$(/usr/bin/ssh-agent -s 2>&1) && echo $cmd_output | /usr/bin/sed 's/^echo/# echo/' > "${SSH_ENV}" && [[ "${PIPESTATUS[0]}" -eq 0 ]]; then
        /bin/chmod 600 "${SSH_ENV}"
        error_exit_code=0
        if _is_ssh_agent_running; then
            _export_ssh_agent_data
            _print_shell_notice_success "pid: $SSH_AGENT_PID"
        else
            _print_shell_notice_failure
            _print_shell_notice_error "cmd '/usr/bin/ssh-agent' exited prematurely"
            _print_shell_notice_cmd_output "$cmd_output" $error_exit_code
        fi
    else
        error_exit_code=$?
        _print_shell_notice_failure
        _print_shell_notice_error "cmd '/usr/bin/ssh-agent' invalid exit <code: $error_exit_code>"
        _print_shell_notice_cmd_output "$cmd_output" $error_exit_code
    fi

    _release_ssh_agent_lock
}

if _is_ssh_agent_running; then
    _export_ssh_agent_data
else
    start_ssh_agent && _export_ssh_agent_data
fi

# bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# docker-nice-to-haves
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

function docker-create-dev-network() {
    [ "$$(docker network ls -f name=$DOCKER_DEV_NETWORK -q)" ] || docker network create --driver bridge $DOCKER_DEV_NETWORK
}

# misc pasteboard shenanigans
alias pbjq='pbpaste | jq'
alias phpunserialize='php -r "echo json_encode(unserialize(stream_get_contents(STDIN)));" | jq'

# python in docker / ease-of-access / every-day-life-quality
export DOCKER_BASE_IMAGE_PYTHON=
export DOCKER_BASE_DEV_IMAGE_PYTHON=
alias pybase='docker run --entrypoint "" -ti `if [ -d ${PWD}/app ]; then echo -n "-v ${PWD}/app:/app"; fi` -v ${PWD}:/vol -w /vol --network=$DOCKER_DEV_NETWORK -e CONFIG_DATA="`(if [ -e config.json ]; then cat config.json; else if [ -e config.example.json ]; then cat config.example.json; fi; fi)`" -e DEVLOG=1 -e PYTHONPATH=app/src:src:/vol/app/src $DOCKER_BASE_IMAGE_PYTHON /bin/bash'
alias pydev='docker run --entrypoint "" -ti `if [ -d ${PWD}/app ]; then echo -n "-v ${PWD}/app:/app"; fi` -v ${PWD}:/vol -w /vol --network=$DOCKER_DEV_NETWORK -e CONFIG_DATA="`(if [ -e config.json ]; then cat config.json; else if [ -e config.example.json ]; then cat config.example.json; fi; fi)`" -e DEVLOG=1 -e PYTHONPATH=app/src:src:/vol/app/src $DOCKER_BASE_DEV_IMAGE_PYTHON /bin/bash'

# code interpreters
alias haskell='docker run -ti haskell ghci'
alias julia='docker run -ti julia'

# 'c' => 'cd'
alias c='cd'

# 'ls' => 'ls -la'
alias ls='ls -la'

# over the years, i learned that I'm apparently bad at typing 'make'
alias mkae='make'
alias maek='make'
alias mkea='make'
alias kame='make'
alias amek='make'
alias maker='make'
alias mae='make'
alias mak='make'
alias meka='make'

# over the years, i learned that I'm understandibly bad at typing 'ls'
alias ls-la='ls'
alias lsa-l='ls'
alias sl='ls'

# over the years, i learned that I'm unforgetfully bad at typing 'python'
alias pthon='python'
alias pytohn='python'
alias pythn='python'
alias pythno='python'
alias pythnom='python'
alias pyhtn='python'
alias pytho='python'
alias pytn='python'
alias pyth='python'

# over the years, i learned that I'm also bad at typing 'docker'
alias ocker='docker'
alias dokcer='docker'
alias dokce='docker'
alias dcoker='docker'
alias dockere='docker'
alias doker='docker'
alias docer='docker'
alias dokcker='docker'
alias docke='docker'

# over the years, i learned that I'm somewhat bad at typing 'git'
alias igt='git'
alias gti='git'
alias ig='git'
alias tig='git'

# over the years, i learned that I'm really bad at typing 'kubectl'
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

# over the years, i learned that I'm whatgrnnant~~ bad at typing 'vagrant'
alias vagrnat='vagrant'
alias vargnat='vagrant'
alias vagnrat='vagrant'
alias vagrnt='vagrant'
alias vagrnat='vagrant'
alias vangrat='vagrant'
alias vagntr='vagrant'
alias varngt='vagrant'
alias vargtn='vagrant'
