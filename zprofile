# Settings for golang# {{{
if command -v go >/dev/null; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME/.go
  export GOBIN=$GOPATH/bin
fi
# }}}
# Settings for gem {{{
if command -v gem >/dev/null; then
    export GEM_BIN=$(ruby -e "print Gem.user_dir")/bin
fi
# }}}
# Editor# {{{
export EDITOR=vim
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"
# }}}
# Language# {{{
# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"
# }}}
# Paths {{{
# Ensure path arrays do not contain duplicates.
typeset -gx -U cdpath fpath mailpath path

fpath=( \
    ~/.zsh/Completion(N-/) \
    ~/.zsh/functions(N-/) \
    ~/.zsh/plugins/zsh-completions(N-/) \
    /usr/local/share/zsh/site-functions(N-/) \
    $fpath \
    )
# }}}
# Set the list of directories that Zsh searches for programs.# {{{
path=(
  /usr/local/{bin,sbin}
  $path
  $GOBIN
  $GEM_BIN
  $HOME/.cargo/bin
  $HOME/bin
)
# }}}
# Pager# {{{
export PAGER=less
export LESS='-F -g -i -M -R -S -w -X -z-4'
export LESSCHARSET='utf-8'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi
# }}}
# History# {{{
# History file
export HISTFILE=~/.zsh_history
# History size in memory
export HISTSIZE=10000
# The number of histsize
export SAVEHIST=1000000
# The size of asking history
export LISTMAX=50
# Do not add in root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi
# }}}
#{{{ Temporary Files
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi
#}}}
# {{{ Gurobi environment
export GUROBI_HOME="/opt/gurobi752/linux64"
export PATH="${PATH}:${GUROBI_HOME}/bin"
export LD_LIBRARY_PATH=$GUROBI_HOME/lib
# }}}
# thefuck {{{
eval $(thefuck --alias)
# }}}
#" Folding the .vimrc {{{
# vim:foldmethod=marker:foldlevel=0
# }}}
