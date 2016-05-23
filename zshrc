export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Make sure you use double quotes

zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-completions"

zplug "rupa/z"

zplug "zsh-users/zsh-syntax-highlighting", nice:12

zplug "plugins/colorize", from:oh-my-zsh, if:"which vim"

zplug "~/.zsh", from:local

zplug "~/.zsh/zsh-git-prompt", use:zshrc.sh, from:local

zplug "~/.zsh/themes/honukai-iterm-zsh", from:local, nice:11

export ENHANCD_COMMAND=ecd
zplug "b4b4r07/enhancd", use:init.sh, nice:11
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
