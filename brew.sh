#!/usr/bin/env zsh

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
brew install fish
brew install zsh
brew install bash
brew tap homebrew/versions
brew install bash-completion2
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo zsh -c 'echo /usr/local/bin/bash >> /etc/shells'
sudo zsh -c 'echo /usr/local/bin/zsh >> /etc/shells'
sudo zsh -c 'echo /usr/local/bin/fish >> /etc/shells'

# Install `wget` and curl with IRI support.
brew install wget --with-iri
brew install curl

# Install Python
brew install python
brew install python3

# Install ruby-build and rbenv
brew install ruby-build
brew install rbenv
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php55 --with-gmp
brew install gawk

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

#install build tools
brew install autoconf
brew install automake
brew install cmake
brew install libtool
brew install ninja
brew install premake
brew install scons

#install C/C++ libraries
brew install boost
brew install gettext
brew install gflags
brew install glib
brew install gmp
brew install libtiff
brew install mpfr
brew install readline


#install C/C++ misc tools
brew install astyle
brew install cscope
brew install ctags
brew install doxygen
brew install gdb
brew install gdbm
brew install uncrustify
brew install valgrind

#install C/C++ compiliers
brew install clang-omp
brew install gcc
brew install gcc6
brew install llvm

#Some Programming languages
brew install go
brew install luajit
brew install node
brew install rust

#Some shell utilities
brew install macvim
brew install neovim
brew install reattach-to-user-namespace
brew install tmux
brew install zplug

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install docbook
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install libpng
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
#brew install exiv2
brew install ack
brew install asciidoc
brew install dark-mode
brew install fasd
brew install freetype
brew install gibo
brew install git
brew install git-extras
brew install git-flow
brew install git-lfs
brew install gnupg
brew install gomi
brew install graphviz
brew install hr
brew install htmldoc
brew install imagemagick
brew install imagemagick --with-webp
brew install jpeg
brew install lastpass-cli
brew install libassuan
brew install libevent
brew install libgpg-error
brew install libiomp
brew install libmpc
brew install libssh2
brew install lua
brew install lynx
brew install mercurial
brew install p7zip
brew install pandoc
brew install peco
brew install pigz
brew install pkg-config libffi
brew install pv
brew install pwgen
brew install rename
brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
brew install the_silver_searcher
brew install tree
brew install webkit2png
brew install zopfli

# Lxml and Libxslt
brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force

# Install Heroku
brew install heroku-toolbelt
heroku update
                                                                            
# Install Cask
brew install caskroom/cask/brew-cask

# Core casks
brew cask install --appdir="/Applications" iterm2
brew cask install --appdir="/Applications" java
brew cask install --appdir="/Applications" xquartz

# Development tool casks
brew cask install --appdir="/Applications" sublime-text3
brew cask install --appdir="/Applications" visual-studio-code
brew cask install --appdir="/Applications" atom
brew cask install --appdir="/Applications" brackets
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" vagrant
brew cask install --appdir="/Applications" heroku-toolbelt
brew cask install --appdir="/Applications" macdown
brew cask install --appdir="/Applications" dash

# Misc casks
brew cask install --appdir="/Applications" caffeine
brew cask install --appdir="/Applications" cakebrew
brew cask install --appdir="/Applications" cargo
brew cask install --appdir="/Applications" ccleaner
brew cask install --appdir="/Applications" cheatsheet
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" flux
brew cask install --appdir="/Applications" macpass
brew cask install --appdir="/Applications" seil
brew cask install --appdir="/Applications" spotify
brew cask install --appdir="/Applications" transmission
brew cask install --appdir="/Applications" the-unarchiver
brew cask install --appdir="/Applications" quicksilver
brew cask install --appdir="/Applications" libreoffice
brew cask install --appdir="/Applications" gimp
brew cask install --appdir="/Applications" dupeguru
brew cask install --appdir="/Applications" julia juliastudio
#brew cask install --appdir="/Applications" inkscape

#Remove comment to install LaTeX distribution MacTeX
brew cask install --appdir="/Applications" mactex
brew cask install --appdir="/Applications" bibdesk
brew cask install --appdir="/Applications" adobe-reader
brew cask install --appdir="/Applications" skim

# Install Docker, which requires virtualbox
brew install docker
brew install boot2dockerk

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# Remove outdated versions from the cellar.
brew cleanup