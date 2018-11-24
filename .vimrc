set nonumber		"行番号表示しない
set noswapfile 		"スワップファイルは作らない
set ruler		"ルーラーの表示
set cmdheight=2		"コマンドラインの高さ
set hlsearch

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
set backspace=indent,eol,start

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""

"~~~~~~~~~~~~~~~~~~~~~~~~~~~
" カラースキーマ
"~~~~~~~~~~~~~~~~~~~~~~~~~~~
colorscheme desert
if &term =~ "xterm-256color" || "screen-256color"
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

syntax enable
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c


" Powerline
if has('unix')
    set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
endif
if has('mac')
    set rtp+=$HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim/
endif
set laststatus=2
set t_Co=256
set showtabline=2
set noshowmode

