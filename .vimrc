set nocompatible                  " be iMproved, required
filetype off                      " required
syntax on

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC | qa!
endif

call plug#begin()
    Plug 'tpope/vim-vinegar'
    Plug 'junegunn/goyo.vim'
    Plug 'wellle/context.vim'
if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'github/copilot.vim'
endif
call plug#end()

set hidden                        " Possibility to have more than one unsaved buffers.
set noshowmode
set number
set nowrap
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

" context toggle
map <leader>ct :ContextToggle<CR>
let s:contect_buffer_name = ''

" netrw - vim file explorer
"" tree file format (toggle using `i`)
let g:netrw_liststyle = 3
let g:netrw_banner = 0
"" toggle hide dot files (`gh`)
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex

" nvim specific
if has('nvim')

" Find files using Telescope command-line
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>

" Enable clangd lsp
lua require'lspconfig'.clangd.setup{}

" Enable rust-tools
lua << EOF

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

EOF

endif

