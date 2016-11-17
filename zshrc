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
export ZSH_TMUX_AUTOSTART=true
#zplug "adambiggs/zsh-theme", use:adambiggs.zsh-theme
#zplug "frmendes/geometry"
<<<<<<< HEAD
#zplug "nyarla/zsh-theme-nerdish"
#zplug "skylerlee/zeta-zsh-theme"
#zplug "cbrock/sugar-free", use:sugar-free.zsh-theme
#zplug "judgedim/oh-my-zsh-judgedim-theme", use:judgedim.zsh-theme
#zplug "denysdovhan/spaceship-zsh-theme"
#zplug "modules/prompt", from:prezto, nice:-20
#zplug "eugenk/zsh-prompt-iggy", use:prompt_iggy_setup
setopt prompt_subst # Make sure propt is able to be generated properly.
zplug "caiogondim/bullet-train-oh-my-zsh-theme", use:bullet-train.zsh-theme
=======
setopt prompt_subst # Make sure propt is able to be generated properly.
zplug "caiogondim/bullet-train-oh-my-zsh-theme", use:bullet-train.zsh-theme, hook-load:""
>>>>>>> release/1.3
zplug "plugins/archlinux", from:oh-my-zsh
zplug "~/.zsh", from:local, use:setopt.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", nice:12
zplug "zsh-users/zsh-syntax-highlighting", nice:11
zplug "~/.zsh", from:local, use:aliases.zsh
zplug "~/.zsh", from:local, use:completion.zsh
zplug "~/.zsh", from:local, use:keybinds.zsh, nice:13
zplug "~/.zsh", from:local, use:noglob.zsh
zplug "~/.zsh", from:local, use:sublime.zsh
zplug "~/.zsh", from:local, use:zmv.zsh
zplug "supercrabtree/k"
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_CONTEXT_SHOW=true 

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose
source /usr/share/fzf/completion.zsh; source /usr/share/fzf/key-bindings.zsh

