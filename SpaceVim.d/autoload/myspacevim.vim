func! myspacevim#before() abort
    " FileType AutoCmd: {{{
    augroup MyAutoCmd
      " Automatically set read-only for files being edited elsewhere
      autocmd SwapExists * nested let v:swapchoice = 'o'

      " Check if file changed when its window is focus, more eager than 'autoread'
      autocmd WinEnter,FocusGained * checktime

      autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif

      " Update filetype on save if empty
      autocmd BufWritePost * nested
        \ if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

      " Reload Vim script automatically if setlocal autoread
      autocmd BufWritePost,FileWritePost *.vim nested
        \ if &l:autoread > 0 | source <afile> |
        \   echo 'source '.bufname('%') |
        \ endif

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      autocmd BufReadPost *
        \ if &ft !~ '^git\c' && ! &diff && line("'\"") > 0 && line("'\"") <= line("$")
        \|   execute 'normal! g`"zvzz'
        \| endif

      " Disable paste and/or update diff when leaving insert mode
      autocmd InsertLeave *
          \ if &paste | setlocal nopaste mouse=a | echo 'nopaste' | endif |
          \ if &l:diff | diffupdate | endif

      autocmd TabLeave * let g:lasttab = tabpagenr()

      autocmd FileType crontab setlocal nobackup nowritebackup

      autocmd FileType css setlocal equalprg=csstidy\ -\ --silent=true

      autocmd FileType yaml.docker-compose setlocal expandtab

      autocmd FileType gitcommit setlocal spell

      autocmd FileType gitcommit,qfreplace setlocal nofoldenable

      " https://webpack.github.io/docs/webpack-dev-server.html#working-with-editors-ides-supporting-safe-write
      autocmd FileType html,css,javascript,jsx,javascript.jsx setlocal backupcopy=yes

      autocmd FileType zsh setlocal foldenable foldmethod=marker

      autocmd FileType html
        \ setlocal path+=./;/
        \ | setlocal equalprg=tidy\ -i\ -q

      autocmd FileType json setlocal equalprg=python\ -c\ json.tool

      autocmd FileType markdown
        \ set expandtab
        \ | setlocal spell autoindent formatoptions=tcroqn2 comments=n:>

      autocmd FileType apache setlocal path+=./;/

      autocmd FileType cam setlocal nonumber synmaxcol=10000

      autocmd FileType tex let g:tex_conceal = ""

      autocmd FileType go highlight default link goErr WarningMsg |
        \ match goErr /\<err\>/

      autocmd FileType xml
        \ setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

    augroup END " }}}
		" Neoformat settings:{{{
let g:neoformat_enabled_tex = ['latexindent']
let g:neoformat_tex_latexindent = {
		\ 'exe': 'latexindent',
		\ 'stdin': 1,
		\ 'no_append': 1,
		\ }"}}}
endf

func! myspacevim#after() abort
    " Denite: {{{
		let insert_mode_mappings = [
      \  ['jj', '<denite:enter_mode:normal>', 'noremap'],
      \  ['<Esc>', '<denite:enter_mode:normal>', 'noremap'],
      \  ['<C-N>', '<denite:assign_next_matched_text>', 'noremap'],
      \  ['<C-P>', '<denite:assign_previous_matched_text>', 'noremap'],
      \  ['<Up>', '<denite:assign_previous_text>', 'noremap'],
      \  ['<Down>', '<denite:assign_next_text>', 'noremap'],
      \  ['<C-Y>', '<denite:redraw>', 'noremap'],
      \  ['<BS>', '<denite:smart_delete_char_before_caret>', 'noremap'],
      \  ['<C-h>', '<denite:smart_delete_char_before_caret>', 'noremap'],
      \ ]

    let normal_mode_mappings = [
      \   ["'", '<denite:toggle_select_down>', 'noremap'],
      \   ['<C-n>', '<denite:jump_to_next_source>', 'noremap'],
      \   ['<C-p>', '<denite:jump_to_previous_source>', 'noremap'],
      \   ['gg', '<denite:move_to_first_line>', 'noremap'],
      \   ['st', '<denite:do_action:tabopen>', 'noremap'],
      \   ['sg', '<denite:do_action:vsplit>', 'noremap'],
      \   ['sv', '<denite:do_action:split>', 'noremap'],
      \   ['sc', '<denite:quit>', 'noremap'],
      \   ['r', '<denite:redraw>', 'noremap'],
      \ ]

    for m in insert_mode_mappings
      call denite#custom#map('insert', m[0], m[1], m[2])
    endfor
    for m in normal_mode_mappings
      call denite#custom#map('normal', m[0], m[1], m[2])
    endfor"}}}
    " Deoplete: {{{  
		let g:vimtex_compiler_programe = 'nvr'
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif
    let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
 
    call deoplete#custom#source('omni',          'mark', '⌾')
    call deoplete#custom#source('flow',          'mark', '⌁')
    call deoplete#custom#source('padawan',       'mark', '⌁')
    call deoplete#custom#source('TernJS',        'mark', '⌁')
    call deoplete#custom#source('go',            'mark', '⌁')
    call deoplete#custom#source('jedi',          'mark', '⌁')
    call deoplete#custom#source('vim',           'mark', '⌁')
    call deoplete#custom#source('neosnippet',    'mark', '⌘')
    call deoplete#custom#source('tag',           'mark', '⌦')
    call deoplete#custom#source('around',        'mark', '↻')
    call deoplete#custom#source('buffer',        'mark', 'ℬ')
    call deoplete#custom#source('tmux-complete', 'mark', '⊶')
    call deoplete#custom#source('syntax',        'mark', '♯')
    call deoplete#custom#source('member',        'mark', '.')

    call deoplete#custom#source('padawan',       'rank', 660)
    call deoplete#custom#source('go',            'rank', 650)
    call deoplete#custom#source('vim',           'rank', 640)
    call deoplete#custom#source('flow',          'rank', 630)
    call deoplete#custom#source('TernJS',        'rank', 620)
    call deoplete#custom#source('jedi',          'rank', 610)
    call deoplete#custom#source('omni',          'rank', 600)
    call deoplete#custom#source('neosnippet',    'rank', 510)
    call deoplete#custom#source('member',        'rank', 500)
    call deoplete#custom#source('file_include',  'rank', 420)
    call deoplete#custom#source('file',          'rank', 410)
    call deoplete#custom#source('tag',           'rank', 400)
    call deoplete#custom#source('around',        'rank', 330)
    call deoplete#custom#source('buffer',        'rank', 320)
    call deoplete#custom#source('dictionary',    'rank', 310)
    call deoplete#custom#source('tmux-complete', 'rank', 300)
    call deoplete#custom#source('syntax',        'rank', 200)"}}}
    " Hlsearch: {{{
    let s:save_cpo = &cpoptions
    set cpoptions&vim

    augroup hlsearch
      autocmd!
      " trigger when hlsearch is toggled
      autocmd OptionSet hlsearch call <SID>toggle(v:option_old, v:option_new)
    augroup END

    function! s:StartHL()
      silent! if v:hlsearch && !search('\%#\zs'.@/,'cnW')
        call <SID>StopHL()
      endif
    endfunction

    function! s:StopHL()
      if ! v:hlsearch || mode() !=? 'n'
        return
      else
        silent call feedkeys("\<Plug>(StopHL)", 'm')
      endif
    endfunction

    function! s:toggle(old, new)
      if a:old == 0 && a:new == 1
        " nohls --> hls
        "   set up
        noremap  <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
        noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]

        autocmd hlsearch CursorMoved * call <SID>StartHL()
        autocmd hlsearch InsertEnter * call <SID>StopHL()
      elseif a:old == 1 && a:new == 0
        " hls --> nohls
        "   tear down
        nunmap <expr> <Plug>(StopHL)
        unmap! <expr> <Plug>(StopHL)

        autocmd! hlsearch CursorMoved
        autocmd! hlsearch InsertEnter
      else
        " nohls --> nohls
        "   do nothing
        return
      endif
    endfunction

    call <SID>toggle(0, &hlsearch)

    let &cpoptions = s:save_cpo "}}}
    " Wildmenu: {{{
    if has('wildmenu')
      set nowildmenu
      set wildmode=list:longest,full
      set wildoptions=tagfile
      set wildignorecase
      set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
      set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
      set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
      set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
      set wildignore+=__pycache__,*.egg-info
      set wildignore+=*.aux,*.lof,*.log,*.lot,*.fls,*.out,*.toc,*.fmt,*.fot,*.cb,*.cb2,.*.lb
      set wildignore+=*.bbl,*.bcf,*.blg,*-blx.aux,*-blx.bib,*.run.xml
      set wildignore+=*.fdb_latexmk,*.synctex,*.synctex(busy),*.synctex.gz,*.synctex.gz(busy),*.pdfsync
    endif
    " }}}
		" NERDTree: {{{

autocmd MyAutoCmd FileType nerdtree call s:nerdtree_settings()

function! s:nerdtree_settings() abort
	setlocal expandtab " Enabling vim-indent-guides
	vertical resize 25
endfunction

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
autocmd MyAutoCmd WinEnter * if exists('t:NERDTreeBufName') &&
	\ bufwinnr(t:NERDTreeBufName) != -1 && winnr("$") == 1 | q | endif

" if the current window is NERDTree, move focus to the next window
autocmd MyAutoCmd TabLeave * call s:NERDTreeUnfocus()
function! s:NERDTreeUnfocus()
	if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) == winnr()
		let l:winNum = 1
		while (l:winNum <= winnr('$'))
			let l:buf = winbufnr(l:winNum)

			if buflisted(l:buf) && getbufvar(l:buf, '&modifiable') == 1 &&
					\ ! empty(getbufvar(l:buf, '&buftype'))
				exec l:winNum.'wincmd w'
				return
			endif
			let l:winNum = l:winNum + 1
		endwhile
		wincmd w
	endif
endfunction




let g:NERDTreeMapOpenSplit = 'sv'
let g:NERDTreeMapOpenVSplit = 'sg'
let g:NERDTreeMapOpenInTab = 'st'
let g:NERDTreeMapOpenInTabSilent = 'sT'
let g:NERDTreeMapUpdirKeepOpen = '<BS>'
let g:NERDTreeMapOpenRecursively = 't'
let g:NERDTreeMapCloseChildren = 'T'
let g:NERDTreeMapToggleHidden = '.'
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize = 25
let g:NERDTreeCascadeOpenSingleChildDir = 1
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeShowHidden = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeAutoDeleteBuffer = 0
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeHijackNetrw = 1
let NERDTreeIgnore = [
	\ '\.git$', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.svn$',
	\ '\.DS_Store$', '\.sass-cache$', '__pycache__$', '\.egg-info$', '\.cache$'
	\ ]

" Custom plugins{{{
" ---
" Private helpers {{{
function! s:SID()
	if ! exists('s:sid')
		let s:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
	endif
	return s:sid
endfunction
let s:SNR = '<SNR>'.s:SID().'_'

function! s:get_containing_dir(node)
	let path = a:node.path
	if ! path.isDirectory || ! a:node.isOpen
		let path = path.getParent()
	endif
	return path.str()
endfunction
" }}}
" Plugin: Open diff split on current file {{{
" ---
call NERDTreeAddKeyMap({
	\ 'key': 'gd',
	\ 'callback': s:SNR.'diff',
	\ 'quickhelpText': 'open diff on current file',
	\ 'scope': 'FileNode' })

function! s:diff(node)
	wincmd w
	diffthis
	execute 'vsplit '.fnameescape(a:node.path.str())
	diffthis
endfunction
" }}}
" Plugin: Jump to project root / user home {{{
" ---
call NERDTreeAddKeyMap({
	\ 'key': '&',
	\ 'callback': s:SNR.'jump_project_root',
	\ 'quickhelpText': 'Open current git root' })

call NERDTreeAddKeyMap({
	\ 'key': 'gh',
	\ 'callback': s:SNR.'jump_home',
	\ 'quickhelpText': 'open user home directory' })

function! s:jump_project_root()
	let project_dir = badge#root()
	if ! empty(project_dir)
		call s:_set_root(project_dir)
	endif
endfunction

function! s:jump_home()
	call s:_set_root($HOME)
endfunction

function! s:_set_root(dir)
	let path = g:NERDTreePath.New(a:dir)
	let node = g:NERDTreeDirNode.New(path, b:NERDTree)
	call b:NERDTree.changeRoot(node)
endfunction
" }}}
" Plugin: Create a new file or dir in path {{{
" ---
call NERDTreeAddKeyMap({
	\ 'key': 'N',
	\ 'callback': s:SNR.'create_in_path',
	\ 'quickhelpText': 'Create file or dir',
	\ 'scope': 'Node' })

function! s:create_in_path(node)
	if a:node.path.isDirectory && ! a:node.isOpen
		call a:node.parent.putCursorHere(0, 0)
	endif

	call NERDTreeAddNode()
endfunction
" }}}
" Plugin: Find and grep in path using Denite {{{
" ---
call NERDTreeAddKeyMap({
	\ 'key': 'gf',
	\ 'callback': s:SNR.'find_in_path',
	\ 'quickhelpText': 'Search in dir',
	\ 'scope': 'Node' })
call NERDTreeAddKeyMap({
	\ 'key': 'gr',
	\ 'callback': s:SNR.'grep_dir',
	\ 'quickhelpText': 'Grep in dir',
	\ 'scope': 'Node' })

function! s:find_in_path(node)
	execute 'Denite file/rec:'.s:get_containing_dir(a:node)
endfunction

function! s:grep_dir(node)
	execute 'Denite -buffer-name=grep grep:'.s:get_containing_dir(a:node)
endfunction
" }}}
" Plugin: Yank path {{{
" ---
call NERDTreeAddKeyMap({
	\ 'key': 'yy',
	\ 'callback': s:SNR.'yank_path',
	\ 'quickhelpText': 'yank current node',
	\ 'scope': 'Node' })

function! s:yank_path(node)
	let l:path = a:node.path.str()
	call setreg('*', l:path)
	echomsg 'Yank node: '.l:path
endfunction
" }}}
" Plugin: Toggle width {{{
" ---
call NERDTreeAddKeyMap({
	\ 'key': 'w',
	\ 'callback': s:SNR.'toggle_width',
	\ 'quickhelpText': 'Toggle window width' })

function! s:toggle_width()
	let l:max = 0
	for l:z in range(1, line('$'))
		let l:len = len(getline(l:z))
		if l:len > l:max
			let l:max = l:len
		endif
	endfor
	exe 'vertical resize '.(l:max == winwidth('.') ? g:NERDTreeWinSize : l:max)
endfunction
" }}}
" Menu-item: Modify .local.vimrc of project {{{
" ---
call NERDTreeAddMenuItem({
	\ 'text': '(l)ocal rc',
	\ 'shortcut': 'l',
	\ 'callback': s:SNR.'modify_localvimrc'})

function! s:modify_localvimrc()
	let current_dir = g:NERDTreeDirNode.GetSelected().path.str({'format': 'Cd'})
	if empty(current_dir)
		echoerr 'Unable to find current directory'
		return
	endif
	let lvimrc_path = current_dir.'/.local.vimrc'
	let cwd = getcwd()
	if ! filereadable(lvimrc_path)
		call writefile([
			\ 'lcd <sfile>:h',
			\ '" set isk+=!,?',
			\ ],
			\ lvimrc_path)
	endif
	wincmd w
	execute 'vsplit '.fnameescape(lvimrc_path)
endfunction
" }}}
" Plugin: Smart h/l navigation {{{
" @see https://github.com/jballanc/nerdtree-space-keys
" ---
call NERDTreeAddKeyMap({
	\ 'key':           'l',
	\ 'callback':      s:SNR.'descendTree',
	\ 'quickhelpText': 'open tree and go to first child',
	\ 'scope':         'DirNode' })
call NERDTreeAddKeyMap({
	\ 'key':           'l',
	\ 'callback':      s:SNR.'openFile',
	\ 'quickhelpText': 'open file',
	\ 'scope':         'FileNode' })
call NERDTreeAddKeyMap({
	\ 'key':           'h',
	\ 'callback':      s:SNR.'closeOrAscendTree',
	\ 'quickhelpText': 'close dir or move to parent dir',
	\ 'scope':         'DirNode' })
call NERDTreeAddKeyMap({
	\ 'key':           'h',
	\ 'callback':      s:SNR.'ascendTree',
	\ 'quickhelpText': 'move to parent dir',
	\ 'scope':         'FileNode' })

function! s:descendTree(dirnode)
	call a:dirnode.open()
	call b:NERDTree.render()
	if a:dirnode.getChildCount() > 0
		let chld = a:dirnode.getChildByIndex(0, 1)
		call chld.putCursorHere(0, 0)
	end
endfunction

function! s:openFile(filenode)
	call a:filenode.activate({'reuse': 'all', 'where': 'p'})
endfunction

function! s:closeOrAscendTree(dirnode)
	if a:dirnode.isOpen
		call a:dirnode.close()
		call b:NERDTree.render()
	else
		call s:ascendTree(a:dirnode)
	endif
endfunction

function! s:ascendTree(node)
	let parent = a:node.parent
	if parent != {}
		call parent.putCursorHere(0, 0)
		if parent.isOpen
			call parent.close()
			call b:NERDTree.render()
		end
	end
endfunction
" }}}
" Plugin: Execute file with system associated utility {{{
" ---
call NERDTreeAddKeyMap({
	\ 'key': 'x',
	\ 'callback': s:SNR.'execute_system_associated',
	\ 'quickhelpText': 'Execute system associated',
	\ 'scope': 'FileNode' })

function! s:execute_system_associated(filenode)
	let current_dir = getcwd()
	let path = a:filenode.parent.path.str()

	" if exists(g:nerdtree_plugin_open_cmd)
	" 	let cmd = g:nerdtree_plugin_open_cmd.' '.path
	" 	call system(cmd)
	" endif

	" Snippet from vital.vim
	try
		execute (haslocaldir() ? 'lcd' : 'cd') fnameescape(path)
		let filename = fnamemodify(a:filenode.path.str(), ':p')

		let s:is_unix = has('unix')
		let s:is_windows = has('win16') || has('win32') || has('win64') || has('win95')
		let s:is_cygwin = has('win32unix')
		let s:is_mac = !s:is_windows && !s:is_cygwin
					\ && (has('mac') || has('macunix') || has('gui_macvim') ||
					\   (!isdirectory('/proc') && executable('sw_vers')))
		" As of 7.4.122, the system()'s 1st argument is converted internally by Vim.
		" Note that Patch 7.4.122 does not convert system()'s 2nd argument and
		" return-value. We must convert them manually.
		let s:need_trans = v:version < 704 || (v:version == 704 && !has('patch122'))

		" Detect desktop environment.
		if s:is_windows
			" For URI only.
			if s:need_trans
				let filename = iconv(filename, &encoding, 'char')
			endif
			" Note:
			"   # and % required to be escaped (:help cmdline-special)
			silent execute printf(
						\ '!start rundll32 url.dll,FileProtocolHandler %s',
						\ escape(filename, '#%'),
						\)
		elseif s:is_cygwin
			" Cygwin.
			call system(printf('%s %s', 'cygstart',
						\ shellescape(filename)))
		elseif executable('xdg-open')
			" Linux.
			call system(printf('%s %s &', 'xdg-open',
						\ shellescape(filename)))
		elseif exists('$KDE_FULL_SESSION') && $KDE_FULL_SESSION ==# 'true'
			" KDE.
			call system(printf('%s %s &', 'kioclient exec',
						\ shellescape(filename)))
		elseif exists('$GNOME_DESKTOP_SESSION_ID')
			" GNOME.
			call system(printf('%s %s &', 'gnome-open',
						\ shellescape(filename)))
		elseif executable('exo-open')
			" Xfce.
			call system(printf('%s %s &', 'exo-open',
						\ shellescape(filename)))
		elseif s:is_mac && executable('open')
			" Mac OS.
			call system(printf('%s %s &', 'open',
						\ shellescape(filename)))
		else
			throw 'vital: System.File: open(): Not supported.'
		endif
	finally
		execute (haslocaldir() ? 'lcd' : 'cd') fnameescape(current_dir)
	endtry
endfunction
" }}}}}}
"}}}
		" Duplicate lines: {{{
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv"}}}
endf
" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
