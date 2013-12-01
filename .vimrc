" clear existing commands
autocmd!

call pathogen#infect()
call pathogen#helptags()

" set to auto read when a file is changed from outside of the buffer
set autoread

" highlighting for various file types
syntax on

" enable filetype plugin
filetype on
filetype plugin on
filetype indent on

set history=250
" tab completion for filenames, help topics, option names
set wildmode=list:longest,full
" for displaying lists with bullets (i think)
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)

" set the map leader for key combinations
let mapleader=","
let g:mapleader=","

" editor options
set showmode
set showcmd
set nocompatible        " prevents vi like bugs and behaviour
set mouse=a
set nomodeline
set showmatch
set ruler
set number
set cursorline
set nostartofline       " don't jump to first char while paging
set equalalways         " force splits to be 50/50
set backspace=indent,eol,start

" text formatting
set nowrap
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set shiftround
set autoindent
set smartindent

" search & replace
set ignorecase
set smartcase
set incsearch
set gdefault

" persistent undo if version is 7.3 or later
if v:version >= 7.3
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000   " maximum number of changes that can be undone
  set undoreload=10000  " maximum number lines to save for undo on a buffer reload
endif

" split rules - changes MiniBufExplorer
"set splitright
"set splitbelow

set t_Co=256
set term=xterm-256color
"let g:solarized_termcolors=256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
set background=dark
colorscheme solarized

" highlight lines that go too long
au BufRead * hi OverLength ctermbg=blue ctermfg=white guibg=#592929
au BufRead * match OverLength /\%121v.\+/

" set a bar for the column width
if exists('+colorcolumn')
  set colorcolumn=81,121
  hi ColorColumn ctermbg=7
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif

" statusbar
set laststatus=2
set statusline=
set statusline+=%f\                    " file name
set statusline+=%h%1*%m%r%w%0*         " flags
set statusline+=%=                     " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P  " offset

" commands for various useful tasks
au BufWritePre * :%s/\s\+$//e  " strip trailing whitespace on save

" taglist setup
let Tlist_Show_One_File = 1
let Tlist_WinWidth = 40
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0

" NERDtree setup - don't enable yet, something doesn't like this
"au VimEnter * NERDTree         " auto open NERDtree with vim
"au BufEnter * NERDTreeMirror
"au VimEnter * wincmd w
"let g:nerdtree_tabs_open_on_console_startup=1

" configure indentation guide colors
let g:indent_guides_auto_colors = 0
au VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
au VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" settings needed for latex-suite
"let g:tex_flavor='latex'
"set grepprg=grep\ -nH\ $*
"let g:Tex_Folding=0
"set iskeyword+=:
"set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" latex specific settings, eg. spell checking
"au BufRead,BufNewFile *.tex setfiletype latex
"au BufRead,BufNewFile *.bib setfiletype latex
"au FileType tex call AlternativeTabbing()
"au FileType tex set spell

" text files
"au BufRead,BufNewFile *.txt setfiletype text
"au FileType text set spell

" dotfiles
"au BufRead,BufNewFile .* setfiletype dotfiles
"au FileType dotfiles call AlternativeTabbing()

" c source files
au BufRead,BufNewFile *.c setfiletype c
au FileType c so ~/.vim/syntax/gtk-highlight.vim

" vala source files
au BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala
let vala_comment_strings = 1        " enable comment strings
let vala_space_errors = 1           " highlight space errors
let vala_no_tab_space_error = 1     " disable space-tab-space errors
let tlist_vala_settings='c#;d:macro;t:typedef;n:namespace;c:class;E:event;g:enum;s:struct;i:interface;p:properties;m:method'

" valgrind suppression files
"au BufNewFile,BufRead *.supp set filetype=supp

" python source files
"au BufRead *.py set filetype=python
"au FileType python call AlternativeTabbing()
"" automatically strip trailing whitespace from python files
""au BufWrite *.py :call RmTrailingWsp()

" set the filetypes for some other types
"au BufRead,BufNewFile *.vbs setfiletype vbnet
"au BufRead,BufNewFile *.asp setfiletype aspvbs

" enable auto completion - complete things with Ctrl+X O
au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType c set omnifunc=ccomplete#Complete

"""
" functions to extend awesomeness of vim

function! CommentLines()
  :'<,'>s/^\(.\)/\/\/\1/
endfunction

function! UncommentLines()
  :'<,'>s/^\/\///
endfunction

function! RmTrailingWsp()
  :%s/\s\+$//
endfunction

function! DisableFolding()
  echo "Code folding disabled"
  set nofoldenable
  set foldcolumn=0
endfunction

function! EnableFolding()
  echo "Code folding enabled"
  set foldenable
  set foldcolumn=2
  set foldmethod=indent
  set foldminlines=2
  set foldlevel=4
  set foldopen=
endfunction

function! AlternativeTabbing()
  echo "Enabling alternative tabbing settings"
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
endfunction

function! DefaultTabbing()
  echo "Enabling default tabbing settings"
  set tabstop=4
  set shiftwidth=4
  set softtabstop=4
endfunction

" another way of generating incremented numbers
"=============================================================================
" File: increment.vim
" Author: Stanislav Sitar
" Put increment.vim into a plugin directory.
" Use in replacement strings
" :let I=0
" :%s/my_token_word_to_be_replaced_by_the_auto_incremented_numbers/\=INC(1)/
" or
" :let I=95
" :%s/@/\=INC(5)/
" to replace each occurrence of character @ with numbers starting with 100 and
" growing by 5 (100, 105, 110, ...)
let g:I=0
function! AddIncrement(increment)
  let g:I= g:I + a:increment
  return g:I
endfunction

function! MpdPause()
  echo "MPD server - Pause"
  :call system("mpc pause")
endfunction

function! MpdPlay()
  echo "MPD server - Play"
  :call system("mpc play")
endfunction

"""
" key mappings, older versions of vim might need
"   C-v + C-m instead of <CR>

map ,v :sp ~/.vimrc<CR>
map <silent> ,V :source ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
"""
" C-s doesn't work in terminal mode
" map <silent> <C-S> :w<CR>
map <F2> :call CommentLines()<CR>
map <F3> :call UncommentLines()<CR>
map <F4> :TlistToggle<CR>
map <F5> :NERDTreeTabsToggle<CR>
" map <F6> :call MpdPause()<CR>
" map <F7> :call MpdPlay()<CR>
map <F8> :make<CR>
map <F9> :call EnableFolding()<CR>
map <F10> :call DisableFolding()<CR>
imap ,a Geoff Johnson, <geoff.jay@gmail.com><CR>
imap ,d <C-R>=strftime('%Y-%m-%d')<CR>
imap ,h <ESC>:0<CR>i<CR><ESC> :execute "r ~/.blob/c.hdr"<CR>a
"""
" C-s doesn't work in terminal mode
" imap <C-s> <C-o><C-s><CR>
"imap <C-v> <Esc><C-v>a
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

"map <C-[> :resize +5<CR>
"map <C-]> :resize -5<CR>

"""
" some regular expressions to consider adding
" :%s/^\w*/\"\0\"/ => wrap first word in "
" :%s/\w*$/\"\0\"/ => wrap last word in "
