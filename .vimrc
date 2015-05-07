" Indentation Settings
"
" Hard tab
set tabstop=4
set shiftwidth=4
set noexpandtab


" Vundle Section
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

Bundle 'gmarik/Vundle.vim'

" My bundles here:
" Bundle 'bling/vim-airline'
Bundle 'itchyny/lightline.vim'
Bundle 'majutsushi/tagbar'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/syntastic'
" Bundle 'xsunsmile/showmarks.git'
Bundle 'vim-scripts/colorizer'
Bundle 'kien/rainbow_parentheses.vim'
" Bundle 'ntpeters/vim-better-whitespace'
Bundle 'airblade/vim-gitgutter'

Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
Bundle 'gioele/vim-autoswap'
Bundle 'scrooloose/nerdtree'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'thinca/vim-localrc'
Bundle 'gregsexton/gitv'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'godlygeek/tabular'

Bundle 'groenewege/vim-less'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'aaronj1335/underscore-templates.vim'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'sophacles/vim-processing'


" Generic next-line match
set autoindent

" Smart indentions
filetype plugin indent on


" Visual helpers
let g:indent_guides_color_change_percent=2
autocmd VimEnter * :IndentGuidesEnable


" Whitespace Cleaning
nnoremap <leader>dw :%s/\s\+$//<cr>:let @/=''<CR>"


" Matching parenthesis blink
set showmatch

" Line numbers
set number
set relativenumber

" Status bar visible always
set laststatus=2

" Search as you type, highlight
set incsearch
set hlsearch


" Block selection with short lines
set ve+=block


" Create file / directory under cursor
map <leader>cf :tabe <cfile><cr>
map <leader>wd :!mkdir %:p:h<cr>


" Copy current file name / directory to system clipboard
map <leader>yn :let @*=expand("%:p")<CR>
map <leader>yd :let @*=expand("%:p:h")<CR>


" Fuzzy file/buffer opener
map <leader>e :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
map <leader>f :CtrlPCurFile<CR>
map <leader>a :e#<CR>


" Buffer Explorer
nnoremap ge :BufExplorer<CR>

" Ack under cursor
" (or ctrl+r ctrl+w)
" TODO remap to a different leader key? so one can do like ]f ]b ]d
" file/buffer/directory (same with ctrlp)
nnoremap <leader>[ :Ack! <cword><CR>
nnoremap <leader>\ :AckWindow! <cword><CR>
nnoremap <leader>] :AckFile! <cword><CR>
nnoremap <leader>' :Ack! expand('%:t')<CR>

" Close quickfix
nnoremap <leader>q :cclose<CR>

" Swap Warnings
set shortmess+=A

" Session open
nnoremap <leader>o :OpenSession!<CR>
nnoremap <leader>s :SaveSession <C-R>=fnamemodify(getcwd(),":t")<CR>


" Tab Control
map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt
map <c-t> :tabnew<CR>
map <A-w> :tabclose<CR>

map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt


" GUI Minify
set guioptions-=T
set guioptions-=e
set guioptions-=m
set guioptions-=r
set guioptions-=


" Theme
color molokai
set gfn=Monospace\ Regular\ 15
set gfn=Menlo\ Regular:h16


" Syntax
syntax on


" Highlight whitespace
hi link ExtraWhitespace Error
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Indentation/Whitespace Visibility
" :dig for characters
set list listchars=tab:»-,trail:·

" Quiet vim
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Dont save sessions from vim-session automatically
let g:session_autosave = 'no'

" Run per language configs
if filereadable(glob("~/.vimrc.languages"))
    source ~/.vimrc.languages
endif

" Run per folder configs
" (You can also place .local.vimrc files directly in a folder)
if filereadable(glob("~/.vimrc.folders"))
    source ~/.vimrc.folders
endif

" Run per machine config
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
