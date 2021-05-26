" tabs
set shiftwidth=4
set expandtab
set smartindent

" sources project specific init.vim
set exrc

" use blockcursor
set guicursor=

" set line + relative numbers
set relativenumber
set nu

" stops highlighting searches after you're done with it
set nohlsearch

" keeps buffer in the background
set hidden

" no error bells
set noerrorbells

" history and undotree cfg
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set incsearch
set scrolloff=8

set colorcolumn=80
set signcolumn=yes

set timeoutlen=200

let mapleader=" "

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/completion-nvim'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mfussenegger/nvim-jdtls'
call plug#end()

lua << EOF
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        propmpt_prefix = ' >',
        color_devicons = true
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}
require('telescope').load_extension('fzy_native')

EOF
set completeopt=menuone,noinsert
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }

if has('nvim-0.5')
    augroup javalsp
        au!
        au FileType java lua require('jdtls').start_or_attach({cmd = { 'java-lsp.sh' }})
    augroup end
endif

colorscheme gruvbox
set background=dark

" Using lua functions
nnoremap <leader>f <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>gr <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>bf <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>hh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>g  :GoDef<cr>

nnoremap <leader><leader> <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>3 <cmd>bprev<cr>
nnoremap <leader>4 <cmd>bnext<cr>
