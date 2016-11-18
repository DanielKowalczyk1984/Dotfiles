# Get operating system
platform='unknown'
unamestr=$(uname)
if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'Darwin' ]]; then
  platform='darwin'
fi

if [[ $platform == 'linux' ]]; then
    export ZPLUG_HOME=$HOME/.zplug
    source $ZPLUG_HOME/init.zsh
elif [[ $platform == 'darwin' ]]; then
    export ZPLUG_HOME=/usr/local/opt/zplug
    source $ZPLUG_HOME/init.zsh
fi

fpath=(~/.zsh/completion(N-/) $fpath)
# export ZSH_TMUX_AUTOSTART=true
zplug "plugins/archlinux", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/themes", from:oh-my-zsh
zplug "supercrabtree/k"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", nice:12
zplug "zsh-users/zsh-syntax-highlighting", nice:11
zplug "~/.zsh", from:local, use:aliases.zsh
zplug "~/.zsh", from:local, use:setopt.zsh, nice:-1
zplug "~/.zsh", from:local, use:completion.zsh
zplug "~/.zsh", from:local, use:keybinds.zsh, nice:13
zplug "~/.zsh", from:local, use:noglob.zsh
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
theme bullet-train
source /usr/share/fzf/completion.zsh; source /usr/share/fzf/key-bindings.zsh

