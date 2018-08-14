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
hi clear SpellBad
hi SpellBad cterm=underline,bold

"fixes YAML indentation issues
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'rakr/vim-one'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'rakr/vim-two-firewatch'
Plug 'mattn/emmet-vim'
Plug 'nikvdp/ejs-syntax'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdcommenter'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'wakatime/vim-wakatime'
Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'reedes/vim-wordy'
Plug 'Chiel92/vim-autoformat' 
Plug 'w0rp/ale' 
call plug#end()

"vim-ctrlspace config
set nocompatible
set hidden

"commenting plugin config 
filetype plugin on
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1

"autocompelete config
let g:deoplete#enable_at_startup = 1

"functions
"remove trailing whitespace from file
fun! TrimWhitespace()
    %s/\s\+$//g
endfun
command! TrimWhitespace call TrimWhitespace()

"==================
"theme 'One' config

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
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
endif

" theme One
let g:one_allow_italics=1
colorscheme one

" theme Deep-Space 
" let g:deepspace_italics=1
" colorscheme deep-space

set background=dark
