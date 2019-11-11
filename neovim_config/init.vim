set tabstop=4
set shiftwidth=4
set expandtab
set wrap
set number
set spell
set mps+=<:>
set nostartofline
" allows pasting yanked / deleted lines in a different application
set clipboard=unnamedplus
" preview substitutions
set inccommand=nosplit
hi clear SpellBad
hi SpellBad cterm=underline,bold
" enable persistent undo so that undo history persists across sessions
set undofile
"undodir is not really necessary for neovim
set undodir=~/.config/nvim/undo

"fixes YAML indentation issues
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'rakr/vim-one'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'rakr/vim-two-firewatch'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'Chiel92/vim-autoformat'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'lumiliet/vim-twig'
Plug 'leafgarland/typescript-vim'
Plug 'simnalamburt/vim-mundo'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovimhaskell/haskell-vim'
Plug 'lervag/vimtex'
call plug#end()

"vim-ctrlspace config
set nocompatible
set hidden

"commenting plugin config
filetype plugin on
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1

"trigger coc completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"trigger coc snippet completion
let g:coc_snippet_next = '<tab>'

"vim-mundo config
nnoremap <F5> :MundoToggle<CR>
let g:mundo_width = 25
let g:mundo_preview_bottom = 1

"functions
"remove trailing whitespace from file
fun! TrimWhitespace()
    %s/\s\+$//g
endfun
command! TrimWhitespace call TrimWhitespace()
"sort TODO file by moving completed items (marked with X) to the bottom
fun! SortTodo()
    %sort /X/
endfun
command! SortTodo call SortTodo()

"==================
"theme 'One' config

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif

" vim-airline themes
let g:airline_theme='lucius'
" let g:airline_theme='ravenpower'

" theme One
let g:one_allow_italics=1
colorscheme one

" theme Deep-Space
" let g:deepspace_italics=1
" colorscheme deep-space

set background=dark
