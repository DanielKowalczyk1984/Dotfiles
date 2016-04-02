source ~/.zplug/zplug

# Make sure you use double quotes

zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-completions"

zplug "rimraf/k"

zplug "rupa/z"

zplug "zsh-users/zsh-syntax-highlighting", nice:12

zplug "plugins/vi-mode", from:oh-my-zsh, if:"which vim"

zplug "plugins/colorize", from:oh-my-zsh, if:"which vim"

zplug "~/.zsh/themes/honukai-iterm-zsh", from:local

zplug "~/.zsh", from:local
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
