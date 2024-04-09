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

set hidden                          " View other buffers without saving current buffer
set noshowmode                      " Hide current vim mode
set number                          " Show line numbers
set nowrap                          " Dont wrap lines
set incsearch                       " Start search without hitting `<CR>`
set ruler                           " Current line number at the bottom-right of screen
set expandtab
set autochdir                       " Change to directory of current file
set autoindent
set wildmenu                        " Command completion menu
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:␣,trail:·
set encoding=UTF-8
set fillchars+=vert:│               " Tmux like vertical separators
set backspace=indent,eol,start      " Intuitive backspace behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Enable markdown syntax for md files
au BufNewFile,BufFilePre,BufEnter,BufRead *.md set filetype=markdown

" Search ctags
set tags=./tags,tags;$HOME

" Tmux like splits
map <C-w>% :vnew<CR>
map <C-w>" :new<CR>

" Tmux like zoom
noremap <c-w>z <c-w>_ \| <c-w>\|

" Specific to nvim
if has('nvim')

" Telescope utils
nnoremap <leader>ft <cmd>Telescope <cr>
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

