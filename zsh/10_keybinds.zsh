#
# Options
#

# Beep on error in line editor.
setopt BEEP

#
# Variables
#

# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Use human-friendly identifiers.
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
  'Control'      '\C-'
  'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd'
  'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    "^?"
  'Delete'       "^[[3~"
  'F1'           "$terminfo[kf1]"
  'F2'           "$terminfo[kf2]"
  'F3'           "$terminfo[kf3]"
  'F4'           "$terminfo[kf4]"
  'F5'           "$terminfo[kf5]"
  'F6'           "$terminfo[kf6]"
  'F7'           "$terminfo[kf7]"
  'F8'           "$terminfo[kf8]"
  'F9'           "$terminfo[kf9]"
  'F10'          "$terminfo[kf10]"
  'F11'          "$terminfo[kf11]"
  'F12'          "$terminfo[kf12]"
  'Insert'       "$terminfo[kich1]"
  'Home'         "$terminfo[khome]"
  'PageUp'       "$terminfo[kpp]"
  'End'          "$terminfo[kend]"
  'PageDown'     "$terminfo[knp]"
  'Up'           "$terminfo[kcuu1]"
  'Left'         "$terminfo[kcub1]"
  'Down'         "$terminfo[kcud1]"
  'Right'        "$terminfo[kcuf1]"
  'BackTab'      "$terminfo[kcbt]"
)

# is_exists returns true if executable $1 exists in $PATH
is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

# has is wrapper function
has() {
    is_exists "$@"
}

# Expands .... to ../..
function expand-dot-to-parent-directory-path {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N expand-dot-to-parent-directory-path


# Expand .... to ../..
bindkey -M "viins"  "." expand-dot-to-parent-directory-path

# bind k and j for VI mode
has 'history-substring-search-up' &&
    bindkey -M vicmd 'k' history-substring-search-up
has 'history-substring-search-down' &&
    bindkey -M vicmd 'j' history-substring-search-down

# bind P and N keys
has 'history-substring-search-up' &&
    bindkey -M viins '^P' history-substring-search-up
has 'history-substring-search-down' &&
    bindkey -M viins '^N' history-substring-search-down



#Ctrl-R
_peco-select-history() {
    if true; then
        BUFFER="$(
        history  \
            | sort -k1,1nr \
            | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' \
            | fzf --query "$LBUFFER"
        )"

        CURSOR=$#BUFFER
        #zle accept-line
        #zle clear-screen
        zle reset-prompt
    else
        if is-at-least 4.3.9; then
            zle -la history-incremental-pattern-search-backward && bindkey "^r" history-incremental-pattern-search-backward
        else
            history-incremental-search-backward
        fi
    fi
}
zle -N _peco-select-history
bindkey '^R' _peco-select-history


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

for keymap in 'viins'; do
  bindkey -M "$keymap" "$key_info[Home]" beginning-of-line
  bindkey -M "$keymap" "$key_info[End]" end-of-line

  bindkey -M "$keymap" "$key_info[Insert]" overwrite-mode
  bindkey -M "$keymap" "$key_info[Delete]" delete-char
  bindkey -M "$keymap" "$key_info[Backspace]" backward-delete-char

  bindkey -M "$keymap" "$key_info[Left]" backward-char
  bindkey -M "$keymap" "$key_info[Right]" forward-char

  # Expand history on space.
  bindkey -M "$keymap" ' ' magic-space

  # Clear screen.
  bindkey -M "$keymap" "$key_info[Control]L" clear-screen

  # Expand command name to full path.
  for key in "$key_info[Escape]"{E,e}
    bindkey -M "$keymap" "$key" expand-cmd-path

  # Duplicate the previous word.
  for key in "$key_info[Escape]"{M,m}
    bindkey -M "$keymap" "$key" copy-prev-shell-word

  # Use a more flexible push-line.
  for key in "$key_info[Control]Q" "$key_info[Escape]"{q,Q}
    bindkey -M "$keymap" "$key" push-line-or-edit

  # Bind Shift + Tab to go to the previous menu item.
  bindkey -M "$keymap" "$key_info[BackTab]" reverse-menu-complete

done



unset key{,map,bindings}