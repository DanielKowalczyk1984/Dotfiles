export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
plugins=(20_aliases.zsh 50_spectrum.zsh 60_gnu_utility.zsh 80_completion.zsh 90_setopt.zsh noglob.zsh sublime.zsh zmv.zsh)

# Make sure you use double quotes

zplug "zsh-users/zsh-history-substring-search", nice:12

zplug "zsh-users/zsh-completions"

zplug "rupa/z"

zplug "zsh-users/zsh-syntax-highlighting", nice:11

zplug "plugins/colorize", from:oh-my-zsh, if:"which vim"

for i in $plugins; do
    zplug "~/.zsh", from:local, use:$i
done

zplug "~/.zsh", from:local, use:10_keybinds.zsh, nice:13

zplug "~/.zsh/zsh-git-prompt", use:zshrc.sh, from:local

zplug "~/.zsh/themes/honukai-iterm-zsh", from:local, nice:11

zplug "supercrabtree/k"

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
