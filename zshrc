#!/bin/zsh

umask 022
#{{{ Check if terminbal is dumb.
if [[ ${TERM} == 'dumb' ]]; then
    return
fi
#}}}
#{{{ Get operating system
platform='unknown'
unamestr=$(uname)
if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'Darwin' ]]; then
  platform='darwin'
fi

if [[ $platform == 'linux' ]]; then
    if [[ ! -d ~/.zplug ]]; then
      git clone https://github.com/zplug/zplug ~/.zplug
      source ~/.zplug/init.zsh && zplug update --self
    fi
    export ZPLUG_HOME=$HOME/.zplug
    source $ZPLUG_HOME/init.zsh
elif [[ $platform == 'darwin' ]]; then
    export ZPLUG_HOME=/usr/local/opt/zplug
    source $ZPLUG_HOME/init.zsh
fi
# }}}
# {{{Powerlevel9k settings
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="↳ "
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon ssh context root_indicator background_jobs status dir dir_writable)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time vcs)
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_TIME_FORMAT="%D{%I:%M:%S %P}"
# }}}
# {{{ Adding some variables
export ZSH_TMUX_AUTOSTART=true
ENHANCD_FILTER="fzf-tmux:fzf:peco:percol:gof:pick:icepick:sentaku:selecta"
ENHANCD_COMMAND=ecd
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS='
--extended
--ansi
--multi
--bind=ctrl-u:page-up
--bind=ctrl-d:page-down
--bind=ctrl-z:toggle-all
'
export ZSH_CUSTOM=~/.zplug/repos/robbyrussell/oh-my-zsh/custom
fpath=(~/.zsh/completion(N-/) $fpath)
# }}}
# {{{ List of all the plugins + load the plugins
zplug "plugins/archlinux", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/git-flow", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/git-flow", from:oh-my-zsh
zplug "supercrabtree/k"
zplug "hlissner/zsh-autopair"
zplug "b4b4r07/enhancd", use:init.sh
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", nice:12
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug "zsh-users/zsh-syntax-highlighting", nice:11
zplug "~/.zsh", from:local, use:aliases.zsh
zplug "~/.zsh", from:local, use:setopt.zsh, nice:-1
zplug "~/.zsh", from:local, use:completion.zsh
zplug "~/.zsh", from:local, use:keybinds.zsh, nice:13
zplug "~/.zsh", from:local, use:noglob.zsh
zplug "~/.zsh", from:local, use:spectrum.zsh 
zplug "~/.zsh", from:local, use:sublime.zsh
zplug "~/.zsh", from:local, use:zmv.zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose
# }}}
#" Folding the .vimrc {{{
# vim:foldmethod=marker:foldlevel=0
# }}}
