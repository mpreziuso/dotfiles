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
Plug 'sbdchd/neoformat'
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
    },
    file_ignore_patterns = { "node_modules", "ansible_collections" }
}
require('telescope').load_extension('fzy_native')

EOF
set completeopt=menuone,noinsert
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Disabling Java LSP for now
" if has('nvim-0.5')
"     augroup javalsp
"         au!
"         au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}, root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'})})
"     augroup end
" endif

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

colorscheme gruvbox
set background=dark

" Using lua functions
nnoremap <leader>f <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>gr <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>bf <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>hh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader>3 <cmd>bprev<cr>
nnoremap <leader>4 <cmd>bnext<cr>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==i
inoremap <C-k> <esc>:m .-2<CR>==i
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

lua << EOF

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>g', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'tsserver', 'bashls' }
for _, lsp in ipairs(servers) do
  require'lspconfig'[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF


