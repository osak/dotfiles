" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showmatch
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq
set t_Co=256

" In many terminal emulators the mouse works just fine, thus enable it.
" set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType scheme :let is_gauche=1
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType cpp setlocal omnifunc=omni#cpp#complete#Main


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  function AddExecMod()
	  let line = getline(1)
	  if strpart(line, 0, 2) == "#!"
		  call system("chmod a+x ".expand("%"))
	  endif
  endfunction

  function FileEncAdjust()
    let size = getfsize(expand('%'))
    let curenc = &fileencoding
    if size == 0 || curenc == 'iso-2022-jp'
      setlocal fileencoding=utf-8
    endif
  endfunction

  autocmd BufWritePost * call AddExecMod()
  autocmd BufNewFile * setlocal fileencoding=utf-8
  autocmd BufReadPost * call FileEncAdjust()
  
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
			"\ | wincmd p | diffthis

" Vundle
filetype off
set rtp+=~/.vim/bundle/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'gmarik/vundle'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'anekos/char-counter-vim'
filetype plugin indent on

nnoremap <silent> <Plug>select_cstyle_if :<C-u>call <SID>select_cstyle_if()<CR>

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

function! s:select_cstyle_if()  " {{{
  let orig_view = winsaveview()
  let if_start_pos = []
  while searchpair('{', '', '}', 'bW', 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string"') != 0
    let brace_start_pos = getpos('.')
    normal! ge
    let save = @"
    normal! yl
    let t = @"
    let @" = save
    if t == ')'
      "Block which needs () after keyword
      call searchpair('(', '', ')', 'bW', 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string"')
      normal! b
      let s = expand('<cword>')
      if s == 'if' || s == 'while' || s == 'for' || s == 'switch'
        let if_start_pos = getpos('.')
        break
      else
        "It may be function declaration
        normal! b
        let if_start_pos = getpos('.')
        break
      endif
    elseif expand('<cword>') == 'else'
      "Block which doesn't need () after keyword
      "elseはifごとコピーしたほうがいいのか？
      normal! b
      let if_start_pos = getpos('.')
      break
    endif
  endwhile
  if if_start_pos == []
    echohl ErrorMsg
    echo "'if' not found"
    echohl None
    call winrestview(orig_view)
    return
  endif

  normal! m[
  call setpos('.', brace_start_pos)
  call searchpair('{', '', '}', 'W', 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string"')
  normal! m]
  normal! `[v`]
endfunction " }}}
" example
"nmap <Space>if <Plug>select_cstyle_if
omap <silent> <Space>if :<C-U>call <SID>select_cstyle_if()<CR>

function! SynIDAttr()
  return synIDattr(synID(line("."), col("."), 0), "name")
endfunction
command! SynIDAttr 
  \ echo SynIDAttr()
nmap <silent> ;s :SynIDAttr<CR>

function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
      \        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
      \        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)

nnoremap Q :QuickRun<CR>

au BufNewFile,BufRead *.ctp setf php
au BufNewFile,BufRead *.io setf io
au BufNewFile,BufRead *.S setf gas
au BufNewFile,BufRead *.gbs setf gunbaiscript
set encoding=utf-8
set termencoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,cp932,utf-8

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
"set tags=tags;
set ambiwidth=double
set number
set list
set listchars=tab:>-
set exrc
set secure
set statusline=%q%h%w%f%r%m\ %=%l/%L,%c\ [%{b:charCounterCount}]
set laststatus=2

set mouse=a
set ttymouse=xterm2
set notitle

let g:solarized_termtrans=1
let g:solarized_termcolors=256
set background=dark
"colorscheme wombat256mod
hi Statement cterm=bold
hi Type cterm=bold
hi Pmenusel ctermbg=12

inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"

noremap  
noremap!  
noremap <BS> 
noremap! <BS> 

let g:acp_enableAtStartUp = 0
let g:neocomplcache_enable_at_startup = 1
"let g:NeoComplCache_ManualCompletionStartLength = 4
"let g:NeoComplCache_EnableWildCard = 0
"let g:NeoComplCache_EnableQuickMatch = 0
"let g:NeoComplCache_EnableQuickMatch = 0
"let g:neocomplcache_omni_functions = {'java': 'javacomplete#Complete'}
let g:changelog_dateformat = "%Y/%m/%d"
"let g:solarized_termcolors=256
let g:quickrun_config = {
      \ "cpp": {"cmdopt": "-D_GLIBCXX_DEBUG -Wall -g"}
      \ }

NeoBundleCheck
