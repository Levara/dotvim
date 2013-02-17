" http://mislav.uniqpath.com/2011/12/vim-revisited/


set nocompatible " choose no compatibility with legacy vi
call pathogen#infect()
"" To update pathogen run:
""curl -Sso ~/.vim/autoload/pathogen.vim \https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
"" After a new plugin is installed, run :Helptags command in vim command line

syntax enable
filetype plugin indent on " load file type plugins + indentation
set encoding=utf-8
set showcmd " display incomplete commands
set background=dark
color molokai " set Molokai theme
set ruler     " show cursor position in statusbar
set cursorline cursorcolumn "highlight the current cursor line
set history=200 "larger history
set relativenumber "show line numbers


"" =================================
"" ========= G U I   OPTIONS =======
"" Remove toolbar and scrollbars from GVIM
set guioptions-=T  "" remove toolbar
set guioptions-=L  "" remove left scrollbar
set guioptions-=r  "" remove right scrollbar
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=50 columns=160
endif
"" ================================



"" set default working directory to Dropbox
chdir /home/levara/Dropbox
set autochdir  "" automagicaly set working dir to current dir

"" Statusline magic: Stolen from github.com/spf13
if has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=\ %f\ " Filename
  "set statusline+=%w%h%m%r " Options
  set statusline+=%{fugitive#statusline()} " Git Hotness
  set statusline+=\ [%{&ff}/%Y] " filetype
  set statusline+=\ %<[%{getcwd()}] " current dir
  set statusline+=%=\ %-3.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif


"" Whitespace
"set wrap " wrap lines
set showbreak=\ \ \ \ \ \ \  

set tabstop=2 shiftwidth=2 " a tab is two spaces (or set this to 4)
set expandtab " use spaces, not tabs (optional)
set backspace=indent,eol,start " backspace through everything in insert mode

"" Searching
set hlsearch " highlight matches
set incsearch " incremental searching
set ignorecase " searches are case insensitive...
set smartcase " ... unless they contain at least one capital letter
"" Map <delete> to remove highlighting
nnoremap  <delete> :noh<CR>


"" Filename Tab completition
set wildmode=longest,list,full
set wildmenu

"" Set Leader key to space
let mapleader = "\<Space>"

"" Map leader+n to toggle the NerdTree
nnoremap <leader>n :NERDTreeToggle<cr>

"" Use ctrl+jklh to move through splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

""======== TABMAGIC ========""
"" Use  leader+t+ h or l to move through tabs
nnoremap <leader>tl :tabnext<cr>
nnoremap <leader>th :tabprev<cr>
"" Use leader+tn to open new tab
nnoremap <leader>tn :tabnew<cr>
"" Use leader+tq to close a tab
nnoremap <leader>tq :tabclose<cr>
"" ====== END TABMAGIC ======""


"" Opening and reloading of my .vimrc configuration
nnoremap <leader>rc :so $MYVIMRC<cr>
nnoremap <leader>orc :vsplit $MYVIMRC<cr>

"" Force exiting insert mode by pressing jj 
inoremap jj <Esc>
inoremap <esc> <esc>:echo "budalo koristi j j!!!!"<cr>

"" Map leader+K to split lines, leader+j to join lines
nnoremap <leader>k <esc>i<cr><esc>k$
nnoremap <leader>j J 
vnoremap <leader>j J
"" map J and K to 15line jump up-down, H and L to 15char jump left-right
nnoremap J 15j
nnoremap K 15k
nnoremap L 15l
nnoremap H 15h
vnoremap J 15j
vnoremap K 15k
vnoremap L 15l
vnoremap H 15h

"" See diff between original file and current version
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
nnoremap <leader>diff :DiffOrig


"" Force using hjkl for moving around!
nnoremap <Left> :echo "no!"<cr>
nnoremap <Right> :echo "no!"<cr>
nnoremap <Up> :echo "no!"<cr>
nnoremap <Down> :echo "no!"<cr>
""inoremap <up> <esc>:echo "no!"<cr>i
""inoremap <down> <esc>:echo "no!"<cr>i
""inoremap <left> <esc>:echo "no!"<cr>i
""inoremap <right> <esc>:echo "no!"<cr>i

"" map keys to uppercase a word with ctrl + u
inoremap <c-u> <esc>viwU<esc>i
nnoremap <c-u> viwU<esc>

"" map U to redo
nnoremap U <c-R>

"" mapping for session save and load
command Swin mksession! ~/mysession.vim 
command Lwin source ~/mysession.vim

"" operator mapping ...
"" ...inside next parentheses
onoremap in( :<c-u>normal! f(vi(<cr>
"" ...inside last parentheses
onoremap il( :<c-u>normal! F)vi(<cr>

"" Surround word with single quotes
:nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
"" Surround word with double quotes
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

set backupdir=~/.vim/_backup " where to put backup files.
set directory=~/.vim/_temp " where to put swap files.
set undodir=~/.vim/_undodir " where tu put undo files.
set undofile               " use persistent undo

set colorcolumn=85
set textwidth=79

""------------------------------------------------
"" Filter HTML content through tidy
command Thtml %!tidy -q -i -html -utf8

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

function! SplitWindowSwap()
  "Mark destination
  exe "split"
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe g:markedWinNum . "wincmd w"
  "Switch to source and shuffle dest->source
  let markedBuf = bufnr( "%" )
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' curBuf
  "Switch to dest and shuffle source->dest
  exe curNum . "wincmd w"
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' markedBuf 
  exe "q"
endfunction

nmap <leader>mw :call MarkWindowSwap()<CR>
nmap <leader>pw :call DoWindowSwap()<CR>
nmap <leader>sw :call SplitWindowSwap()<CR>


"" -----------------------------------
"" Automatically refresh Firefox window using MozRepl
autocmd BufWriteCmd *.html,*.css,*.gtpl :call Refresh_firefox()
function! Refresh_firefox()
  if &modified
    write
    silent !echo  'vimYo = content.window.pageYOffset;
          \ vimXo = content.window.pageXOffset;
          \ BrowserReload();
          \ content.window.scrollTo(vimXo,vimYo);
          \ repl.quit();'  |
          \ nc -w 1 localhost 9876 2>&1 > /dev/null
  endif
endfunction

"" Now, when working on local html files, if you switch files often then just press
"" <leader>ml and the file is shown in Firefox. Also, <leader>mh will bring you to 
"" ex mode where you can type in a URL and go there in Firefox etc. 

command! -nargs=1 Repl silent !echo
      \ "repl.home();
      \ content.location.href = '<args>';
      \ repl.enter(content);
      \ repl.quit();" |
      \ nc localhost 9876 

nmap <leader>mh :Repl http://
" mnemonic is MozRepl Http
nmap <silent> <leader>ml :Repl file:///%:p<CR>
" mnemonic is MozRepl Local
nmap <silent> <leader>md :Repl http://localhost/
" mnemonic is MozRepl Development
