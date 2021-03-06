# `kalaspuff/dotfiles`
*Just another collection of dotfiles – this time, my dotfiles.*

* `carloscar` on Keybase: https://keybase.io/carloscar
* `kalaspuff` on GitHub: https://github.com/kalaspuff

#### `.ssh/authorized_keys`
> “Hi! I'm setting up a user for you. Can you hand me your ssh public key?”

* **Keybase**: https://carloscar.keybase.pub/keys/ssh.txt
* **GitHub**: https://gist.github.com/kalaspuff/7b16d36c0255f1bd83604bef59f4fb65

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOK39ZXtzjMERZkTWNndvo9aYtnJYYwWGzKIHN7kvGlv kalaspuff@darkness
```

#### `whoami`
> “Can you prove that you're actually Carl Oscar?”

##### I'm on keybase [https://keybase.io/carloscar], you can look me up yourself
```bash
~ $ keybase id kalaspuff@github
# ▶ INFO Identifying carloscar
# ✔ public key fingerprint: 5A84 DCEE 73C5 7AC1 6DA6 AC95 E05A 9514 6D18 CE4B
# ✔ "kalaspuff" on github: https://gist.github.com/9e0311085f13755f93f42889203cfec0
# ✔ admin of DNS zone carloscar.com: found TXT entry
#   keybase-site-verification=68LOSK2HPQzssJYS1QtmetpkuGzPRGeZyB0WmV-SY-s
# ✔ admin of carloscar.com via HTTPS: https://carloscar.com/.well-known/keybase.txt
```

```bash
~ $ keybase whoami
# carloscar
```

```bash
~ $ keybase whoami --uid
# 56ae7b10eee7c8e1142470114dc5d219
```

#### `carloscar.pub`
> “I need send you a password, a shared private key or other secrets. How do I encrypt it?”

##### First – Import my public keys
* **Keybase**: https://keybase.io/carloscar/pgp_keys.asc

```bash
# alternative 0: get and import public keys using 'keybase pgp pull'
~ $ keybase pgp pull carloscar

# alternative 1: get and import public keys using 'curl + gpg --import'
~ $ curl https://keybase.io/carloscar/pgp_keys.asc | gpg --import
```

##### If you need to encrypt a file (for example a shared private key)
```bash
# alternative 0 - files: encrypt a file using 'keybase pgp encrypt'
~ $ keybase pgp encrypt --no-self -k 5a84dcee73c57ac16da6ac95e05a95146d18ce4b carloscar -i INFILE

# alternative 1 - files: encrypt a file using 'gpg --encrypt'
~ $ gpg --encrypt --armor -r 5a84dcee73c57ac16da6ac95e05a95146d18ce4b < INFILE
```

##### How to encrypt a simple message (for example a password)
```bash
# alternative 0 - message: encrypt using 'keybase pgp encrypt' - end message with [ctrl+d]
~ $ keybase pgp encrypt --no-self -k 5a84dcee73c57ac16da6ac95e05a95146d18ce4b carloscar

# alternative 1 - message: encrypt using 'gpg --encrypt' - end message with [ctrl+d]
~ $ gpg --encrypt --armor -r 5a84dcee73c57ac16da6ac95e05a95146d18ce4b
```

##### You can also verify that my key is indeed imported and works
> Hi! 👋 I (Carl Oscar) signed this message using key "5a84dcee73c57ac16da6ac95e05a95146d18ce4b".

Just head to https://keybase.io/verify or use `gpg`. 🙏
```
-----BEGIN PGP MESSAGE-----

owEBsAJP/ZANAwEIAeBalRRtGM5LActpdABfqoCtSGkhIPCfkYsgSSAoQ2FybCBP
c2Nhcikgc2lnbmVkIHRoaXMgbWVzc2FnZSB1c2luZyBrZXkgIjVhODRkY2VlNzNj
NTdhYzE2ZGE2YWM5NWUwNWE5NTE0NmQxOGNlNGIiLg0KiQIzBAEBCAAdFiEEWoTc
7nPFesFtpqyV4FqVFG0YzksFAl+qgMYACgkQ4FqVFG0YzkvNARAAmgzpiarx2+hi
+yWZ4vgslTKfQRB0d9VlMDiFOpxosMHRJgE1BOcuBxnE4ZykTH2pBkKrSmRgIm8s
lSWURr8vo6DxItwv4iIRCSzB6QZUADFa5n4pn8hVs6smxvzGm/AkkqtJSbagUfLa
R1KyKKxX//FWlBWqCjg8BM012vEkn2B8m53VlAESuNbPamNvN6n+/I7fHaBMCVmu
uJywxRFlos/m1Ci8FjbSwKpPbalvsY9RwLzN8IjSBlw54Q1dN/PRqNZWdg8BG44d
31WjhDF2uJi0ecWtyAtMbidwXwkXKxM7DgrYbPRbO6B2zM3cfQtXjrP1SwZ6UHbD
RMII7kAr48/IaSS6Q0TTTCS1ey15u0bRK4ZoFCG/1xCVhiQAhmULHrmU9r0XfBHT
lNK4C7zyE1snyry+V+SYZwn4MU5NwyTfpNqK+3QU5D9/YPl8I42HAD+IIHdF20ZY
nmysc5BemvQ4KdDiExLokYWRbuHUucQ3hCkn7KD+nTZuq48Xr/QX97Ud1ieg2kVP
llG9aVTRYrg7b3vK8yozalv7U0Z1+KFBdsQxzWdcLFmJUzpmpJ+Vlz0pPyJcDDzK
hYlw0DKZn20W6kiU44VV7Blw79/GEIiwu+FobloJluyBs5D0MpLjK5OLM7zfqowV
CQmgGIXo0iPExDOU4n8T1NUhsnwGm9k=
=J/9D
-----END PGP MESSAGE-----
```

##### And lastly, here's my public key if you'd rather get it here
```
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=xvBN
-----END PGP PUBLIC KEY BLOCK-----
```

#### `brew install`

##### Setup on a new computer
```bash
# install homebrew
~ $ /bin/bash -c "$(curl -fsSL                                               \
        https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

```bash
# install brew formulae (from 'brew list --formula')
~ $ brew tap aws/tap
~ $ brew install adns aom apr apr-util argon2 aspell autoconf aws-sam-cli    \
        bash bash-completion bash-completion@2 bdw-gc berkeley-db boost      \
        brotli c-ares cairo cloc curl curl-openssl dav1d docbook docbook-xsl \
        docker docker-completion ffmpeg flac fmt fontconfig freetds freetype \
        frei0r fribidi gd gdbm gettext ghostscript giflib git git-flow glib  \
        gmp gnu-getopt gnu-sed gnupg gnutls gobject-introspection graphite2  \
        guile harfbuzz helm icu4c ilmbase imagemagick jansson jemalloc jpeg  \
        jq krb5 kubernetes-cli lame leptonica libass libassuan libbluray     \
        libde265 libebml libev libevent libffi libgcrypt libgpg-error        \
        libheif libidn libidn2 libksba liblqr libmagic libmatroska           \
        libmetalink libogg libomp libpcap libpng libpq libpthread-stubs      \
        libsamplerate libsndfile libsodium libsoxr libssh2 libtasn1 libtiff  \
        libtool libunistring libusb libuv libvidstab libvorbis libvpx libx11 \
        libxau libxcb libxdmcp libxext libxrender libyaml libzip little-cms2 \
        lua lzo m4 make mkvtoolnix mpdecimal ncurses nettle nghttp2 node     \
        node@10 node@14 npth oniguruma opencore-amr openexr openjpeg         \
        openldap openssl@1.1 opus p11-kit pcre pcre2 perl php pinentry       \
        pip-completion pixman pkg-config pugixml python@3.8 python@3.9 rav1e \
        readline rtmpdump rubberband ruby sdl2 shared-mime-info snappy speex \
        sqlite srt tcl-tk tcpdump terraform terraform@0.12 tesseract theora  \
        tidy-html5 unbound unixodbc vim webp x264 x265 xmlto xorgproto xvid  \
        xz zeromq zimg zstd
```

```bash
# install brew formulae (from 'brew list --cask')
~ $ brew cask install adobe-creative-cloud alfred docker dropbox             \
        font-fira-code font-source-code-pro google-chrome keybase            \
        ledger-live slack spotify tor-browser tunnelblick                    \
        visual-studio-code cleanmymac ngrok plex transmission vlc
```

```bash
# link defaults
~ $ brew link --force --overwrite python@3.9
~ $ brew link --force --overwrite node@14
~ $ CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib ;       \
        /usr/local/bin/python3 -m pip install --upgrade setuptools wheel pip
~ $ /usr/local/bin/node install -g yarn
```

#### `pipx install`

##### Setup on a new computer
```bash
# install pipx
~ $ CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib ;       \
        /usr/local/bin/python3 -m pip install --upgrade virtualenv pipx
```

```bash
# install cli packages with pipx
~ $ CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib ;       \
    brew uninstall --ignore-dependencies c-ares ;                            \
    for package in                                                           \
        awscli black flake8 isort mypy poetry py-spy pytest twine            \
        tomodachi[protobuf,uvloop,aiodns,brotli]                             \
    ; do /usr/local/bin/python3 -m pipx install $package; done ;             \
    brew install c-ares
```

```bash
# install cli packages with pipx (from private pypi repository)
~ $ PYPIREPO=https://pypi.example.org/simple/ ;                              \
    PACKAGES="4711 4711 4711" ;                                              \
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib ;       \
    for package in                                                           \
        $PACKAGES                                                            \
    ; do /usr/local/bin/python3 -m pipx install -i $PYPIREPO $package; done
```

#### `vscode`

##### Setup on a new computer
```bash
# install vscode extensions (from 'code --list-extensions')
~ $ for extension in \
        almenon.arepl batisteo.vscode-django dbaeumer.vscode-eslint          \
        donjayamanne.python-extension-pack dsebastien.vscode-python-pack     \
        eamodio.gitlens Equinusocio.vsc-community-material-theme             \
        Equinusocio.vsc-material-theme equinusocio.vsc-material-theme-icons  \
        flowtype.flow-for-vscode GraphQL.vscode-graphql                      \
        jbw91.theme-material-dark-soda lextudio.restructuredtext             \
        magicstack.MagicPython mgesbert.python-path                          \
        ms-azuretools.vscode-docker ms-python.python                         \
        ms-python.vscode-pylance ms-toolsai.jupyter                          \
        PKief.material-icon-theme vangware.dark-plus-material                \
        VisualStudioExptTeam.vscodeintellicode wholroyd.jinja                \
        zxh404.vscode-proto3                                                 \
    ; do code --install-extension $extension; done
```

```bash
# link settings.json
~ $ rm -f ~/Library/Application\ Support/Code/User/settings.json && \
        ln -s ~/.vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```
