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


plugins=(aliases.zsh spectrum.zsh setopt.zsh completion.zsh noglob.zsh sublime.zsh zmv.zsh pip.zsh keybinds.zsh)



fpath=(~/.zsh/completion(N-/) $fpath)

zplug "zsh-users/zsh-completions"
zplug "~/.zsh", from:local, use:aliases.zsh
zplug "~/.zsh", from:local, use:spectrum.zsh
zplug "~/.zsh", from:local, use:setopt.zsh
zplug "~/.zsh", from:local, use:completion.zsh
zplug "~/.zsh", from:local, use:noglob.zsh
zplug "~/.zsh", from:local, use:sublime.zsh
zplug "~/.zsh", from:local, use:zmv.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/archlinux", from:oh-my-zsh
setopt prompt_subst # Make sure propt is able to be generated properly.
zplug "adambiggs/zsh-theme", use:adambiggs.zsh-theme
zplug "zsh-users/zsh-syntax-highlighting", nice:11
zplug "zsh-users/zsh-history-substring-search", nice:12


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose
source ~/.zsh/keybinds.zsh 
source /usr/share/fzf/completion.zsh; source /usr/share/fzf/key-bindings.zsh

