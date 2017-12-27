" basic preferences
set ambiwidth=double
set autoindent
set backspace=indent,eol,start
set expandtab
set hidden
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set magic
set nocompatible
set nrformats-=octal
set number
set numberwidth=1
set shiftwidth=2
set smartindent
set tabstop=2
set title
set virtualedit=block
set whichwrap=b,s,[,],<,>

syntax on

" NeoBundle Scripts
" Be iMproved
if &compatible
  set nocompatible
endif

set runtimepath+=/home/le96/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('/home/le96/.vim/bundle'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" Personal:
" More usable fileopen
NeoBundle 'Shougo/unite.vim'
" Fileopen history enable
NeoBundle 'Shougo/neomru.vim'
" Tree fileopen
NeoBundle 'scrooloose/nerdtree'
" Easy toggle comment on/off
NeoBundle 'tomtom/tcomment_vim'
" Change ' and "
NeoBundle 'tpope/vim-surround'
" Guide indent by color
NeoBundle 'nathanaelkane/vim-indent-guides'
" Interpretable ANSI escape color code
NeoBundle 'vim-scripts/AnsiEsc.vim'
" Visualize unnecessary spaces on end of line
NeoBundle 'bronson/vim-trailing-whitespace'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
" Settings for unite.vim
" Start on insert mode
let g:unite_enable_start_insert=1
" List of buffer
noremap <C-P> :Unite buffer<CR>
" List of file
noremap <C-N> :Unite -buffer-name=file file<CR>
" List of recentry used file
noremap <C-Z> :Unite file_mru<CR>
" Sources as current directory
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" Window separated open
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" Window vertically separated open
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" End on <ESC><ESC>
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" for vim-fugitive
" Show QuickFix List after grep-search
autocmd QuickFixCmdPost *grep* cwindow
" Show current Git branch on status line
set statusline+=%{fugitive#statusline()}

" for vim-indent-guides
" Auto enable on launching vim
let g:indent_guides_enable_on_vim_startup = 1

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
