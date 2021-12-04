set nocompatible              " be iMproved, required
filetype off                  " required
syntax on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'vimwiki/vimwiki'
Plugin 'mattn/calendar-vim'
Plugin 'wakatime/vim-wakatime'
call vundle#end()            " required
filetype plugin indent on    " required

set noshowmode
set number
set backspace=indent,eol,start
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autochdir
set encoding=UTF-8

" tmux like separators
set fillchars+=vert:\|
hi VertSplit cterm=NONE
" hi VertSplit ctermbg=NONE guibg=NONE

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

" visual block command map
" since <C-v> used for paste from windows clipboard
map <leader>vb <C-v>

" minimal mode toggle
map <leader>m :Goyo<CR>

" insert vimwiki table
map <leader>t :VimwikiTable<CR>

" vimwiki config
if filereadable('/home/i8hantanu/.me_dev')
  let me_wiki = {}
  let me_wiki.path = '~/blog/wiki'
  let me_wiki.path_html = '~/blog/docs'
  let me_wiki.syntax = 'default'
  let me_wiki.ext = '.md'
  let g:vimwiki_list = [me_wiki]
endif

if filereadable('~/.work_dev')
  let work_wiki = {}
  let work_wiki.path = '/proj/xhdhdstaff2/shmishra/projects/git/dev_log/wiki'
  let work_wiki.path_html = '/proj/xhdhdstaff2/shmishra/projects/git/dev_log/docs'
  let work_wiki.syntax = 'default'
  let work_wiki.ext = '.md'
  let g:vimwiki_list = [work_wiki]
endif
