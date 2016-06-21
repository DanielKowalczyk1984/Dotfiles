export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

plugins=(aliases.zsh spectrum.zsh gnu_utility.zsh completion.zsh setopt.zsh noglob.zsh sublime.zsh zmv.zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Make sure you use double quotes
for i in $plugins; do
    zplug "~/.zsh", from:local, use:$i
done

zplug "zsh-users/zsh-completions"
zplug "supercrabtree/k"
zplug "~/.zsh/zsh-git-prompt", use:zshrc.sh, from:local
zplug "b4b4r07/enhancd", use:init.sh, nice:11
zplug "~/.zsh/themes/honukai-iterm-zsh", from:local, nice:11
zplug "zsh-users/zsh-syntax-highlighting", nice:11
zplug "zsh-users/zsh-history-substring-search", nice:12
zplug "~/.zsh", from:local, use:keybinds.zsh, nice:13

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

