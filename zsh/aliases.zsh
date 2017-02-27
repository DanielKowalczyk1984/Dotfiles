# Aliases in this file are bash and zsh compatible

function open_command() {
  emulate -L zsh
  setopt shwordsplit

  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   open_cmd='xdg-open' ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # don't use nohup on OSX
  if [[ "$OSTYPE" == darwin* ]]; then
    $open_cmd "$@" &>/dev/null
  else
    nohup $open_cmd "$@" &>/dev/null
  fi
}

# Open files with the default app.
alias o="open_command"
# Get operating system
platform='unknown'
unamestr=$(uname)
if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'Darwin' ]]; then
  platform='darwin'
fi

# PS
alias psa="ps aux"
alias psg="ps aux | grep "
alias psr='ps aux | grep ruby'

# Moving around
alias cdb='cd -'
alias cls='clear;ls'

# Show human friendly numbers and colors
alias df='df -h'
alias du='du -h -d 2'

if [[ $platform == 'linux' ]]; then
  alias ll='ls -alh --color=auto'
  alias ls='ls -X --color=auto'
  alias lt='tree --dirsfirst -aLpughDFiC 1'
  alias ltd='lt -d'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
elif [[ $platform == 'darwin' ]]; then
	alias ll='ls --group-directories-first -alh --color=auto'
  alias ls='ls --group-directories-first --color=auto'
fi

# show me files matching "ls grep"
alias lsg='ll | ag'

# mimic vim functions
alias :q='exit'

# vimrc editing
alias ve='vim ~/.vimrc'

# zsh profile editing
alias ze='vim ~/.zshrc'
# --// General Config \\--
config () {
    case $1 in  
        # Apps
        vim)        $EDITOR ~/.vimrc ;;
        zsh)        $EDITOR ~/.zshrc ;;
        aliases)  $EDITOR ~/.zsh/aliases.zsh ;;
        urxvt)      $EDITOR ~/.Xdefaults ;;
        slim)       sudo $EDITOR /etc/slim.conf ;;
        logout)     sudo $EDITOR /etc/oblogout.conf ;;
        chat)       $EDITOR ~/.weechat/weechat.conf ;;
        irc)        $EDITOR ~/.weechat/irc.conf ;;
        zathura)    $EDITOR ~/.config/zathura/zathurarc ;;
        most)       sudo $EDITOR /etc/most.conf ;;
        motion)     sudo $EDITOR ~/.motion/motion.conf ;;
        open)       $EDITOR ~/.config/mimeapps.list ;;
        tmux)       $EDITOR ~/.tmux.conf ;;
        mail)       $EDITOR ~/.muttrc ;;
        # Music
        mpd)        sudo $EDITOR /etc/mpd.conf ;;
        music)      $EDITOR ~/.ncmpcpp/config ;;
        mplayer)    sudo $EDITOR ~/.mplayer/config ;;
        pianobar)   sudo $EDITOR ~/.config/pianobar/config ;;
        # System
        burg)       sudo $EDITOR /boot/burg/burg.cfg ;;
        grub)       sudo $EDITOR /boot/grub/grub.cfg ;;
		xorg)		sudo $EDITOR /etc/X11/xorg.conf ;;
		rc)			sudo $EDITOR /etc/rc.conf ;;
        fstab)      sudo $EDITOR /etc/fstab ;;
        xinit)      $EDITOR ~/.xinitrc ;;
		pacman)		sudo $EDITOR /etc/pacman.conf ;;
        inittab)    sudo $EDITOR /etc/inittab ;;
        init)       sudo $EDITOR /etc/mkinitcpio.conf ;;
        hosts)      sudo $EDITOR /etc/hosts ;;
        i3)         $EDITOR ~/.config/i3/config ;;
        # Invalid
        *)          if [ -f "$1" ]; then
						if [ -w "$1" ]; then		
							$EDITOR "$1"
						else
							sudo $EDITOR "$1"
						fi
					else 
						echo "Invalid Option" 
					fi ;;
   esac
}
# Git Aliases
alias gitgraph='git log --all --graph --decorate --oneline'

# Common shell functions
alias less='less -R'
alias tf='tail -f'
alias l='less'
alias lh='ls -alt | head' # see the last modified files
alias screen='TERM=screen screen'
alias cl='clear'

# Zippin
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
alias gz='tar -zcvf'

alias ka9='killall -9'
alias k9='kill -9'

# Global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g N="| /dev/null"
alias -g S='| sort'
alias -g G='| grep' # now you can do: ls foo G something

# File Download
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

# Disable correction.
alias ack='nocorrect ack'
alias cp='nocorrect cp'
alias ebuild='nocorrect ebuild'
alias gcc='nocorrect gcc'
alias gist='nocorrect gist'
alias grep='nocorrect grep'
alias heroku='nocorrect heroku'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias rm='nocorrect rm'

# Makes a directory and changes to it.
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# ------------------------------------------------------------------
# Pygments stuff
# ------------------------------------------------------------------
pretty() { pygmentize -f terminal "$1" | less -R }

cat_alias() {
    local i stdin file=0
    stdin=("${(@f)$(cat <&0)}")
    for i in "${stdin[@]}"
    do
        if [[ -f $i ]]; then
            cat "$@" "$i"
            file=1
        fi
    done
    if [[ $file -eq 0 ]]; then
        echo "${(F)stdin}"
    fi
}

pygmentize_alias() {
    if has "pygmentize"; then
        local get_styles styles style
        get_styles="from pygments.styles import get_all_styles
        styles = list(get_all_styles())
        print('\n'.join(styles))"
        styles=( $(sed -e 's/^  *//g' <<<"$get_styles" | python) )

        style=${${(M)styles:#solarized}:-default}
        cat_alias "$@" | pygmentize -O style="$style" -f console -g L
    else
        cat -
    fi
}
alias -g P="| pygmentize_alias"

man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

alias _='sudo'
# -----------------------------------------------------------------
# lpass fzf stuff
# -----------------------------------------------------------------
flpass_pass(){
    lpass show -c --password $(lpass ls  | fzf | awk '{print $(NF)}' | sed 's/\]//g')
}

flpass_user(){
    lpass show -c --username $(lpass ls  | fzf | awk '{print $(NF)}' | sed 's/\]//g')
}
# -----------------------------------------------------------------
# git fzf stuff
# -----------------------------------------------------------------
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# ------------------------------------------------------------------
# tmux stuff
# ------------------------------------------------------------------
alias takeover="tmux  detach -a"
alias attach="tmux  attach -t base || tmux new -s base"
alias ta='tmux  attach -t'
alias tn='tmux  new -s'
alias tls='tmux  ls'
alias tk='tmux  kill-session -t'
# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}
