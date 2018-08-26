set wrap
set linebreak

"vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'rakr/vim-two-firewatch'
Plug 'wakatime/vim-wakatime'
Plug 'junegunn/goyo.vim'
call plug#end()

"Goyo config
let g:goyo_height=100
let g:goyo_width=65
let g:goyo_margin_top=1
let g:goyo_margin_bottom=2
autocmd VimEnter * Goyo 

"'q' quits even if Goyo is active 
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

"remove broken linebreaks which occur when dumping webpage from w3m
fun! FixLinebreaks()
    %s/\(\S\)\n\(\S\)/\1 \2/
endfun

" TODO fix: the substitution doesn't work
function ReadFromWeb(link) 
    execute "!w3m -dump "a:link"" 
    " execute "call FixLinebreaks()"
    execute "normal gg"
endfunction

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

let g:two_firewatch_italics=1
colo two-firewatch
set background=light
