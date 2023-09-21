[ -f /usr/local/bin/brew ] && export BREW_PREFIX=/usr/local
[ -f /opt/homebrew/bin/brew ] && export BREW_PREFIX=/opt/homebrew
[ -z $BREW_PREFIX ] && export BREW_PREFIX=/opt/homebrew

export SSH_ENV="$HOME/.ssh/env"
export PATH="$HOME/.local/bin:/usr/local/bin:${BREW_PREFIX}/opt/python/bin:${BREW_PREFIX}/bin:${BREW_PREFIX}/opt/curl-openssl/bin:$PATH"
export PKG_CONFIG_PATH="${BREW_PREFIX}/opt/curl-openssl/lib/pkgconfig"
export LDFLAGS="-L${BREW_PREFIX}/opt/curl-openssl/lib"
export CPPFLAGS="-I${BREW_PREFIX}/opt/curl-openssl/include"
export CLICOLOR=1
export LSCOLORS="exfxcxdxcxegedabagacad"
export PROMPT='%B%F{green}%n@%m%f%b:%B%F{blue}%~%f%b$ '
export USERID=$(id -u)
