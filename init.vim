" reset augroup for init
augroup MyAutoCmd
  autocmd!
augroup END

" path for config
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME

" basic config
"set ambiwidth=double  " double width for Zenkaku letters
set autoindent  " auto complete indent
set backspace=indent,eol,start  " enable backspace on insert mode
let &backupdir=s:config_home . '/nvim/backup'  " backup directory
set browsedir=buffer  " start file manager on directory of buffered file
set cmdheight=2  " used 2 line for command line
set expandtab  " <Tab> to spaces
set hidden  " enable open file when there are unsaved files
set hlsearch  " hilight searching word
set laststatus=2  " always show status line on the 2nd last line
set list  " visualize invisible characters
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%  " ... by there characters
set magic  " always think meta characters as magic-mode when searching
set noswapfile  " not use swap file
set nrformats-=octal  " not use octal
set number  " line number
set numberwidth=1  " minimum width for line number
set ruler  " ruler
set shiftwidth=2  " width of indent
set showcmd  " show command
set showmatch  " show corresponding bracket and brace
set smartcase  " auto ignoring upper/lowercase when searching
set smartindent  " enable smart indent
set smarttab  " indent shitwidth number when <Tab> on beginning of line
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P  " informations on status line
let &tags=s:config_home . '/nvim/tags.vim'  " tag file
set tabstop=2  " width of <Tab>
set title  " show file name on title of terminal
set virtualedit=onemore  " enable virtual edit (movable cursor to non-character area)
set whichwrap=b,s,h,l,[,],<,>  " movable prev/next line by key which move cursor to left/right
set wildmenu  " command line complete

" dein
" Required:
let s:dein_dir = s:config_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  " Required:
  call dein#end()
  call dein#save_state()
endif
" Required:
filetype plugin indent on
syntax enable
" If you want to install not installed plugins on startup.
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" End dein

" other scripts
" http://inari.hatenablog.com/entry/2014/05/05/231307
" Visualize ZenkakuSpace
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
" Change color of status line on insert mode
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
"
if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction
function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
