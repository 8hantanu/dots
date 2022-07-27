set nocompatible                  " be iMproved, required
filetype off                      " required
syntax on

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    Plug 'tpope/vim-vinegar'
    Plug 'preservim/tagbar'
    Plug 'junegunn/goyo.vim'
if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'github/copilot.vim'
endif
call plug#end()

set hidden                        " Possibility to have more than one unsaved buffers.
set noshowmode
set number
set incsearch                     " Incremental search, hit `<CR>` to stop.
set ruler                         " Shows the current line number at the bottom-right
                                  " of the screen.
set backspace=indent,eol,start    " Intuitive backspace behavior.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autochdir
set autoindent
set encoding=UTF-8
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:␣,trail:·
set wildmenu                      " Great command-line completion, use `<Tab>` to move
                                  " around and `<CR>` to validate.

" tmux like separators
set fillchars+=vert:\|
hi VertSplit cterm=NONE

" cursor fix for WSL
let &t_SI.="\e[5 q"
"let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

" backspace fix in some shells
noremap! <C-?> <C-h>

" move around in insert
inoremap <A-k> <C-o>gk
inoremap <A-h> <Left>
inoremap <A-l> <Right>
inoremap <A-j> <C-o>gj

" enable markdown syntax for md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" search ctags
set tags=./tags,tags;$HOME

" tmux like splits
map <C-w>% :vnew<CR>
map <C-w>" :new<CR>

" tmux like zoom
noremap <c-w>Z <c-w>_ \| <c-w>\|
noremap <c-w>z <c-w>=

" visual block command remap
" since <C-v> used for paste from windows clipboard
map <leader>vb <C-v>

" minimal mode toggle
map <leader>min :Goyo<CR>

if has('nvim')
    " Better contrast with light themes
    set background=light
endif

