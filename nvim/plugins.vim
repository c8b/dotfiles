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

Plug 'takac/vim-hardtime'

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


" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

Plug 'phpactor/phpactor',  {'do': 'composer install', 'for': 'php'}
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

"HTTP requests
Plug  'nicwest/vim-http' 

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

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

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

