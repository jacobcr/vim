" jacob cr vim configuration file
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

" always set autoindenting on
set ai 

"ignnore case when searching
set ignorecase
set incsearch
set magic

"show matching bracets
set showmatch

filetype plugin indent on

"MiniBuffer"
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1


" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

"" Taglist variables
"" Display function name in status bar:
"let g:ctags_statusline=1
"" " Automatically start script
"let generate_tags=1
"" " Displays taglist results in a vertical window:
"let Tlist_Use_Horiz_Window=0
"" " Shorter commands to toggle Taglist display
"nnoremap TT :TlistToggle<CR>
"map <F4> :TlistToggle<CR>
"" " Various Taglist diplay config:
"let Tlist_Use_Right_Window = 1
"let Tlist_Compact_Format = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_File_Fold_Auto_Close = 1

"Fold with space"
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
"Always hide the statusline
set laststatus=2

function! CurDir()
   let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
   return curdir
endfunction

"Format the statusline
set statusline=\ %t%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

" change leader key 
let mapleader = ","

" CommandT
let g:CommandTMatchWindowAtTop = 1

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" Fast calling nerdtree
map <leader>n :NERDTreeToggle<CR>

"Paste toggle - when pasting something in, don't indent.
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"PEP8"
set expandtab
set textwidth=140
set tabstop=8
set softtabstop=4
set shiftwidth=4
set autoindent
syntax on

"PyFlakes
command Pyflakes :call Pyflakes()
function! Pyflakes()
    let tmpfile = tempname()
    execute "w" tmpfile
    execute "set makeprg=(pyflakes\\ " . tmpfile . "\\\\\\|sed\\ s@" . tmpfile ."@%@)"
    make
    cw
endfunction

"Pylint
command Pylint :call Pylint()
function! Pylint()
    setlocal makeprg=(echo\ '[%]';\ pylint\ %)
    setlocal efm=%+P[%f],%t:\ %#%l:%m
    silent make
    cwindow
endfunction
