" ========================================
" Vim plugin configuration
" ========================================
filetype off

set rtp+=~/.vim/vimplug/ "Submodules

call plug#begin('~/.vim/plugged')
runtime languages.vimplug
runtime git.vimplug
runtime appearance.vimplug
runtime textobjects.vimplug
runtime search.vimplug
runtime project.vimplug
runtime vim-improvements.vimplug
call plug#end()

"Filetype plugin indent on is required by vundle
filetype plugin indent on
