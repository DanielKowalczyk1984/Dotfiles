# System {{{
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
  alias el='exa -al --group-directories-first'
  alias es='exa -x'
  alias ll='lsd -al --group-dirs first'
  alias ls='lsd --group-dirs first'
  alias lt='tree --dirsfirst -aLpughDFiC 1'
  alias ltd='lt -d'
  function elt() {exa --group-directories-first -al -T --level=$1}
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
elif [[ $platform == 'darwin' ]]; then
	alias ll='ls --group-directories-first -alh --color=auto'
        alias ls='ls --group-directories-first --color=auto'
fi

# show me files matching "ls grep"
alias lsg='ll | ag'
alias lsr='ll | rg'

# mimic vim functions
alias :q='exit'
# }}}
# Config function {{{

config () {
    case $1 in
        alacritty)  $EDITOR ~/.config/alacritty/alacritty.yml;;
        aliases)    $EDITOR ~/.zsh/aliases.zsh ;;
        bar)        $EDITOR ~/.config/i3/scripts/py3status.config ;;
        boot)       sudo $EDITOR /boot/grub/grub.cfg ;;
        chat)       $EDITOR ~/.weechat/weechat.conf ;;
        dotfiles)   $EDITOR ~/Dotfiles ;;
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
        nvim)       $EDITOR ~/.config/nvim/config/plugins.yaml ;;
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
# Git Aliases {{{
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
alias gitgraph='git log --all --graph --decorate --oneline'
# }}}
# Common shell functions {{{
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
# Creates An Archive From Given Directory {{{

mktar() { tar cvf       "${1%%/}.tar"       "${1%%/}/"; }
mktgz() { tar cvzf      "${1%%/}.tar.gz"    "${1%%/}/"; }
mktbz() { tar cvjf      "${1%%/}.tar.bz2"   "${1%%/}/"; }
mkrar() { rar a -m5 -r  "${1%%/}.rar"       "${1%%/}/"; }
mkzip() { zip -9r       "${1%%/}.zip"       "${1%%/}/"; }
mk7z()  { 7z a -mx9     "${1%%/}.7z"        "${1%%/}/"; }
targz()
{
  local tmpFile="${@%/}.tar";
  tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

  size=$(
    stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
    stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
  );

  local cmd="";
  if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
    # the .tar file is smaller than 50 MB and Zopfli is available; use it
    cmd="zopfli";
  else
    if hash pigz 2> /dev/null; then
      cmd="pigz";
    else
      cmd="gzip";
    fi;
  fi;

  echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
  "${cmd}" -v "${tmpFile}" || return 1;
  [ -f "${tmpFile}" ] && rm "${tmpFile}";

  zippedSize=$(
  	stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # OS X `stat`
  	stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
  );

  echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}
# }}}
# Managing Packages {{{
alias update='yay -Syua'
alias updatef='yay -Syua --noconfirm'
alias clean='yay -Qdtd --ignore awesome'
alias install='yay -S'
alias installf='yay -S --noconfirm'
alias remove='yay -Rsnc'
alias removef='yay -Rdd'
alias search='yay -Ss'
alias infos='yay -Qi'
# }}}
# Directories {{{
alias i3='cd ~/.config/i3 && ll'
alias apps='/usr/share/applications && ll'
alias themes='/usr/share/themes && ll'
alias icons='/usr/share/icons && ll'
alias pixmaps='/usr/share/pixmaps && ll'
alias downloads='$HOME/Downloads && ll'
alias dropdir='$HOME/MyDocuments && ll'
alias documents='$HOME/Documents && ll'
alias books='$HOME/MyDocuments/BooksArchive && ll'
alias articles='$HOME/MyDocuments/ArticlesArchive && ll'
alias service='cd /usr/lib/systemd/system && ls'
# }}}
# Security {{{
alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"
alias checkvirus="clamscan --recursive=yes --infected /home"
alias updateantivirus="sudo freshclam"

passwdgen()
{
  if [ $1 ]; then
    local length=$1
  else
    local length=16
  fi

  tr -dc A-Za-z0-9_ < /dev/urandom  | head -c${1:-${length}}
}
# }}}
# Global aliases {{{
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
# File Download {{{
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi
# }}}
# Disable correction {{{
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
# Oneliners for file & directory movement {{{
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }
cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }
mkf() { mkdir -p $1; cd $1 }
cdl() { cd $@; ll }
da() { ($1 &) }
zsh-stats() { history | awk '{print $2}' | sort | uniq -c | sort -rn | head }
dirsize() { du -h --max-depth=1 "$@" | sort -k 1,1hr -k 2,2f; }
# }}}
# bitwarden fzf stuff {{{
sk_op_pass() {
  if hash op 2>/dev/null; then
 op get item "$(op list items | jq '.[] | .overview.title' | sk-tmux | sd '"' '')" --fields password | pbcopy
  fi
}

sk_op_pass_print() {
  if hash op 2>/dev/null; then
 op get item "$(op list items | jq '.[] | .overview.title' | sk-tmux | sd '"' '')" --fields password
  fi
}

sk_op_user() {
  if hash op 2>/dev/null; then
    op get item "$(op list items | jq '.overview.title' | sd '"' '')"
  fi
}
# }}}
# git fzf stuff {{{
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
# tmux stuff {{{
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
# papis alias {{{
alias pro="papis-rofi"
# }}}
# Folding the .vimrc {{{
# fold the .vimrc
# vim:foldmethod=marker:foldlevel=0
# }}}

_z_cd() {
    cd "$@" || return "$?"

    if [ "$_ZO_ECHO" = "1" ]; then
        echo "$PWD"
    fi
}

z() {
    if [ "$#" -eq 0 ]; then
        _z_cd ~
    elif [ "$#" -eq 1 ] && [ "$1" = '-' ]; then
        if [ -n "$OLDPWD" ]; then
            _z_cd "$OLDPWD"
        else
            echo 'zoxide: $OLDPWD is not set'
            return 1
        fi
    else
        _zoxide_result="$(zoxide query -- "$@")" && _z_cd "$_zoxide_result"
    fi
}

zi() {
    _zoxide_result="$(zoxide query -i -- "$@")" && _z_cd "$_zoxide_result"
}


alias za='zoxide add'

alias zq='zoxide query'
alias zqi='zoxide query -i'

alias zr='zoxide remove'
zri() {
    _zoxide_result="$(zoxide query -i -- "$@")" && zoxide remove "$_zoxide_result"
}


_zoxide_hook() {
    zoxide add "$(pwd -L)"
}

chpwd_functions=(${chpwd_functions[@]} "_zoxide_hook")

