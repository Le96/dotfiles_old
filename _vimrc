"basic preferences
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

"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/le96/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('/home/le96/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
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

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------
