# System# {{{
# Define open command# {{{
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
# }}}
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
alias psg="ps aux | ag "
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
# }}}
# {{{ Config function

config () {
    case $1 in  
        aliases)  $EDITOR ~/.zsh/aliases.zsh ;;
        bar)        $EDITOR ~/.config/i3/scripts/py3status.config ;;
        boot)       sudo $EDITOR /boot/grub/grub.cfg ;;
        chat)       $EDITOR ~/.weechat/weechat.conf ;;
        dunst)      $EDITOR ~/.config/dunst/dunstrc ;;
        fstab)      sudo $EDITOR /etc/fstab ;;
        grub)       sudo $EDITOR /etc/default/grub ;;
        hosts)      sudo $EDITOR /etc/hosts ;;
        i3)         $EDITOR ~/.config/i3/config ;;
        i3status)   $EDITOR ~/.config/i3/i3status.config ;;
        init)       sudo $EDITOR /etc/mkinitcpio.conf ;;
        irc)        $EDITOR ~/.weechat/irc.conf ;;
        lightdm)    sudo $EDITOR /etc/lightdm/lightdm.conf ;;
        ls)         $EDITOR ~/.dir_colors ;;
        mail)       $EDITOR ~/.muttrc ;;
        most)       sudo $EDITOR /etc/most.conf ;;
        mpd)        sudo $EDITOR ~/.mpd/mpd.conf ;;
        mplayer)    sudo $EDITOR ~/.mplayer/config ;;
        music)      $EDITOR ~/.ncmpcpp/config ;;
        open)       $EDITOR ~/.local/share/applications/mimeapps.list ;;
		pacman)		sudo $EDITOR /etc/pacman.conf ;;
        ranger)     $EDITOR ~/.config/ranger/rc.conf ;;
        ssh)        sudo $EDITOR /etc/ssh/ssh_config ;;
        sshd)       sudo $EDITOR /etc/ssh/sshd_config ;;
        terminator) $EDITOR ~/.config/terminator/config ;;
        tmux)       $EDITOR ~/.tmux.conf ;;
        urxvt)      $EDITOR ~/.Xdefaults ;;
        xterm)      $EDITOR ~/.Xresources ;;
        vim)        $EDITOR ~/.vimrc ;;
        xinit)      $EDITOR ~/.xinitrc ;;
		xorg)		sudo $EDITOR /etc/X11/xorg.conf ;;
        zathura)    $EDITOR ~/.config/zathura/zathurarc ;;
        zsh)        $EDITOR ~/.zshrc ;;
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

# }}}
# Git Aliases# {{{
alias gitgraph='git log --all --graph --decorate --oneline'
# }}}
# Common shell functions# {{{
alias less='less -R'
alias tf='tail -f'
alias l='less'
alias lh='ls -alt | head' # see the last modified files
alias screen='TERM=screen screen'
alias cl='clear'
alias _='sudo'
alias ka9='killall -9'
alias k9='kill -9'
# }}}
# {{{ Creates An Archive From Given Directory

mktar() { tar cvf       "${1%%/}.tar"       "${1%%/}/"; }
mktgz() { tar cvzf      "${1%%/}.tar.gz"    "${1%%/}/"; }
mktbz() { tar cvjf      "${1%%/}.tar.bz2"   "${1%%/}/"; }
mkrar() { rar a -m5 -r  "${1%%/}.rar"       "${1%%/}/"; }
mkzip() { zip -9r       "${1%%/}.zip"       "${1%%/}/"; }
mk7z()  { 7z a -mx9     "${1%%/}.7z"        "${1%%/}/"; }

# }}}
# {{{ Managing Packages
alias update='yaourt -Syua'
alias updatef='yaourt -Syua --noconfirm'
alias clean='yaourt -Qdtd --ignore awesome'
alias install='yaourt -S'
alias installf='yaourt -S --noconfirm'
alias remove='yaourt -Rsnc'
alias removef='yaourt -Rdd'
alias search='yaourt -Ss' 
alias infos='yaourt -Qi'
# }}}
# {{{ Directories
alias i3='cd ~/.config/i3 && ll'
alias apps='/usr/share/applications && ll'
alias themes='/usr/share/themes && ll'
alias icons='/usr/share/icons && ll'
alias pixmaps='/usr/share/pixmaps && ll'
alias downloads='/home/daniel/Downloads && ll'
alias dropdir='/home/daniel/Dropbox && ll'
alias documents='/home/daniel/Documents && ll'
alias books='/home/daniel/Drive/BooksArchive && ll'
alias articles='/home/daniel/Dropbox/ArticlesArchive && ll'
alias service='cd /usr/lib/systemd/system && ls'
# }}}
# Global aliases# {{{
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g N="| /dev/null"
alias -g S='| sort'
alias -g G='| grep' # now you can do: ls foo G something
# }}}
# File Download# {{{
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi
# }}}
# Disable correction.# {{{
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
# }}}
# {{{ Oneliners for file & directory movement

goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }
cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }
mkf() { mkdir -p $1; cd $1 }
cdl() { cd $@; ll }
da() { ($1 &) }
zsh-stats() { history | awk '{print $2}' | sort | uniq -c | sort -rn | head }
dirsize() { du -h --max-depth=1 "$@" | sort -k 1,1hr -k 2,2f; }

# }}}
# Pygments stuff# {{{
pretty() { pygmentize -f terminal "$1" | less -R }

pygmentize_alias() {
    if has "pygmentize"; then
        pygmentize -O style=native -f 256 -g L
    else
        cat -
    fi
}
alias -g P="| pygmentize_alias"
# }}}
# Color manual pages# {{{
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
# }}}
# lpass fzf stuff# {{{
flpass_pass(){
    lpass show -c --password $(lpass ls  | fzf | awk '{print $(nf)}' | sed 's/\]//g')
}

flpass_user(){
    lpass show -c --username $(lpass ls  | fzf | awk '{print $(nf)}' | sed 's/\]//g')
}
# }}}
# git fzf stuff# {{{
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

peco-select-gitadd() {
    local selected_file_to_add
    selected_file_to_add="$(
    git status --porcelain \
        | perl -pe 's/^( ?.{1,2} )(.*)$/\033[31m$1\033[m$2/' \
        | fzf --ansi --exit-0 \
        | awk -F ' ' '{print $NF}' \
        | tr "\n" " "
    )"

    if [ -n "$selected_file_to_add" ]; then
        BUFFER="git add $selected_file_to_add"
        CURSOR=$#BUFFER
        zle accept-line
    fi
    zle reset-prompt
}
zle -N peco-select-gitadd
bindkey '^g^ ' peco-select-gitadd
# }}}
# tmux stuff# {{{
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
# }}}
# Folding the .vimrc {{{
# fold the .vimrc
# vim:foldmethod=marker:foldlevel=0
# }}}
