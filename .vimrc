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
set backspace=indent,eol,start      " Intuitive backspace behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Search ctags
set tags=./tags,tags;$HOME

" Tmux like UX
set fillchars+=vert:│               " Tmux like vertical separators
map <C-w>% :vnew<CR>
map <C-w>" :new<CR>
noremap <c-w>z <c-w>_ \| <c-w>\|

" Markdown settings
au BufNewFile,BufFilePre,BufEnter,BufRead *.md
  \ setlocal filetype=markdown |
  \ setlocal wrap nonumber textwidth=64 |
  \ setlocal tabstop=4 softtabstop=4 shiftwidth=4

augroup MarkdownMapping
  autocmd!
  autocmd FileType markdown nnoremap <buffer> gf :call GoToNote()<CR>
augroup END

function! GoToNote()
  let base_path = expand("%:p:h") . '/' . expand("<cfile>")
  let extensions = ['', '.md', '/README.md']
  for ext in extensions
    let path = base_path . ext
    if filereadable(path)
      execute "edit " . path
      return
    endif
  endfor
  echohl ErrorMsg | echo "Can't find note \"" . expand("<cfile>") . "\" in path" | echohl None
endfunction

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

