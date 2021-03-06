" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Set default encoding
set encoding=utf-8
set fileencoding=utf-8
set number

" Show mouse
set mouse=a
set nomousehide
" Allow backups
set backup
set backupdir=$HOME/.vim/tmp/
set directory=$HOME/.vim/tmp/

" Allow status line
if has("gui_running")
    set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %r\ Row:\ %l/%L\ [%p%%]\ Col:\ %c-%v
    set laststatus=2
else
    set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %r\ Row:\ %l/%L\ [%p%%]\ Col:\ %c-%v
    set laststatus=2
endif
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
  filetype plugin on
endif

let twitvim_browser_cmd = 'google-chrome'
set ofu=syntaxcomplete#Complete
set completeopt=longest,menuone
" Set coloscheme to molokai and fix colors when in terminal
colorscheme github
set t_Co=256

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Automatic Idention
set smarttab
set smartindent

set softtabstop=4
set shiftwidth=4
set noexpandtab

" Automatisches Einrücken mit Intelligenz
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" A tab is 4 spaces as in PEP 8 here the settings:
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

" Testing the backspace fix
"set backspace=indet,eol,start

" Ins Verzeichnis der aktuellen Datei wechseln
nmap <silent> <Leader>cc :cd %:p:h<CR>:pwd<CR>

" Autostart python scripts
autocmd FileType python map <F5> :w<CR>:!python '%'<CR>

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

if has("autocmd")

    " Die .vimrc-Datei nach dem Speichern automatisch neu laden
    autocmd bufwritepost .vimrc source ~/.vimrc

    " Lädt Template-Funktion bei neuer Datei
    autocmd! BufNewFile * call LoadTemplate()

    " Die Syntax dieser Sprachen benötigt genaues Einhalten von Tab oder Space
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " Anpassungen nach eigenem Geschmack
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType less setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType ruby,eruby,yaml setlocal ts=2 sts=2 sw=2 expandtab

    " Wrap lines in html tags
    autocmd FileType html,php nmap <Leader>li yss<li>
    autocmd FileType html,php nmap <Leader>a yss<p>
    autocmd FileType html,php nmap <Leader>h1 yss<h1>
    autocmd FileType html,php nmap <Leader>h2 yss<h2>
    autocmd FileType html,php nmap <Leader>h3 yss<h3>
    autocmd FileType html,php nmap <Leader>h4 yss<h4>
    autocmd FileType html,php nmap <Leader>br A<br /><esc>
    autocmd FileType html,php nmap <Leader>b ysiw<strong>
    autocmd FileType html,php nmap <Leader>i ysiw<em>
    autocmd FileType html,php nmap <Leader><space> i&nbsp;<esc>lx
    autocmd FileType html,php nmap <Leader>b <S-v>gss<div style="color: white; background: red; padding: 10px;">

    " OmniCompletion für bestimmte Dateitypen
    set omnifunc=syntaxcomplete#Complete
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
    autocmd FileType python runtime! autoload/pythoncomplete.vim
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete

    " Einstellungen für Ruby
    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

    " Erkenne bestimmte Dateitypen
    autocmd BufNewFile,BufRead *.rss set filetype=xml
    autocmd BufNewFile,BufRead *.json set filetype=json
    autocmd BufNewFile,BufRead jquery.*.js set filetype=javascript syntax=jquery
    autocmd BufNewFile,BufRead *.less set filetype=less syntax=less
    autocmd BufNewFile,BufRead *.command set filetype=sh syntax=sh

    " Einstellungen für automatisches Einklappen bei bestimmten Dateitypen
    autocmd FileType ruby setlocal foldmethod=syntax
    autocmd FileType css setlocal foldmethod=marker foldmarker={,} shiftwidth=2 tabstop=2

    " Cursorposition wieder herstellen
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

endif

