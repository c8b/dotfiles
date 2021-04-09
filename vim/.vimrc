" vimrc, double quotes for comments
"
" Cool.
"
" A good portion of this file will be taken from
" https://vim.fandom.com/wiki/Example_vimrc
" I thank the internet for my education.

" -------------------------------------------------------------
" Features {{{1
"
" Useful stuff, for any user

" For compatibility (not 100% sure what this is)
set nocompatible

" Try to determine filetype. Used with intelligent auto-indent
" and filetype sepecific plugins.
filetype indent plugin on

" Syntax highlighting
syntax on 

" Syntax highlighting for odd extensions
autocmd BufNewFile,BufRead *.prolog set syntax=prolog

" Colour
" Set cool color
colorscheme industry

" Transparant background
hi Normal ctermbg=NONE

" Line highlighting
hi CursorLine term=bold cterm=bold ctermbg=black 

" I don't know what color 111111 is, nor do I know the appropriate values for
" ctermbg. But it produces a cool effect.
hi ColorColumn ctermbg=16 guibg=#2c2d27
set cursorline

" Set colorcolumn to show at column 80 and at column 120 onward
let &colorcolumn="80,".join(range(120,999),",")

" -------------------------------------------------------------
" Options {{{1
"
" Recommended options. Many are taken from:
" https://vim.fandom.com/wiki/Example_vimrc

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

" ------------------------------------------------------------
" Usability options {{{1
"
" Personal preference options.

" Case insensitive search, except when using Capital Letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of
" insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stops the "go to the first char of the line" thing.
set nostartofline

" Display the cursor position in the status line
set ruler

" Always display status line
set laststatus=2

" Ask to save changed files
set confirm

" Use visual bell instead of beeping
set visualbell

" Reset terminal code for visual bell.
set t_vb=

" Enable use of mouse for all modes
set mouse=a

" Set command window height to 2 lines (avoids 'press enter to contiue')
set cmdheight=2

" Display line numbers
set number
set relativenumber

" Turn off word wrap
set nowrap

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" <F11> toggles between 'paste' & 'nopaste'
set pastetoggle=<F11>

"------------------------------------------------------------
" Indentation options {{{1

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" ------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
"

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" ------------------------------------------------------------
" Autocommands {{{1
"
" Auto run some commands

augroup my_au
au BufWritePost ~/notes/*.md :! ~/notes/make_html ~/notes 

" ------------------------------------------------------------
" Misc.

" About vim-plug
" vim-plug gets its instructions from this part of the .vimrc.
" Add the plugins you want installed in between 'call plug#begin(...)'
" Question - where is a good place to look for plugins? github? vim.org?
" Something searchable preferred. Maybe like a repository.
"
"
" vim-plug auto-installation

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" installing plugins
call plug#begin('~/.vim/plugged')

Plug 'drmikehenry/vim-fontsize'

" Something from the example. Supposed to be a good vim starting point.
Plug 'tpope/vim-sensible'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree'
if has('nvim')
    Plug 'bfredl/nvim-miniyank'
endif

Plug 'moll/vim-bbye'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'

" Project mangement plugins
Plug 'amiorin/vim-project'
Plug 'mhinz/vim-startify'

" Syntax plugins
Plug 'StanAngeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'

" Autocompletion plugins
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
if has('nvim')
    Plug 'roxma/nvim-yarp'
endif


" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

Plug 'phpactor/phpactor'
Plug 'phpactor/ncm2-phpactor'

" Search/replacing plugins
Plug 'junegunn/fzf.vim'
Plug 'wincent/ferret'

" Code Quality
Plug 'neomake/neomake'

" Refoactoring plugins
Plug 'adoy/vim-php-refactoring-toolbox'

" Git plugins
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Snippets plugins
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Outline plugins
Plug 'majutsushi/tagbar'

" Debugger plugin
Plug 'joonty/vdebug'

" PHPDoc plugin
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'

call plug#end()

" vim-project
" Config for a vim project manager 

let g:project_use_nerdtree = 1
set rtp+=/.vim/bundle/vim-project/
call project#rc()

Project '~/projects/test/smclresearcher/'

" Custom functions

" NERDTree and Startify working at startup
autocmd VimEnter *
        \   if !argc()
        \ |   Startify
        \ |   NERDTree
        \ |   wincmd w
        \ | endif

" ripgrep shortcuts
nnoremap <leader>a :Rg<space>
nnoremap <leader>A :exec "Rg ".expand("<cword>")<cr>

autocmd VimEnter * command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ncm2 options

" supress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" enable auto complete for `<backspace>`, `<c-w>` keys.
" known issue https://github.com/ncm2/ncm2/issues/7
au TextChangedI * call ncm2#auto_trigger()

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })
