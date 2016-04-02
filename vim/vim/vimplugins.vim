" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Once you've updated the list of plugin, you can run vundle update by issuing
" the command :BundleInstall from within vim or directly invoking it from the
" command line with the following syntax:
" vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
" Filetype off is required by vundle
filetype off

set rtp+=~/.vim/vimplug/ "Submodules

call plug#begin('~/.vim/plugged')
" YADR's vundles are split up by category into smaller files
" This reduces churn and makes it easier to fork. See
" ~/.vim/vundles/ to edit them:
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
