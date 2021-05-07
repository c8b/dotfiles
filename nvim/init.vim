" Neovim config file


" Copy settings from previous vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
source ~/dotfiles/nvim/plugins.vim

"let g:hardtime_default_on = 1
"let g:UltiSnipsSnippetDirectories=['~/.vim/plugged/ultisnips', '~/.vim/plugged/vim-snippets']

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>q :Bdelete<CR>
nnoremap <Leader>e :Bwipeout<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>

nnoremap <Leader>ev :e $MYVIMRC<CR>

" Phpactor imports
nnoremap <Leader>ic :PhpactorImportClass<CR>
nnoremap <Leader>gd :PhpactorGotoDefinition<CR><CR>

" vim-http shortcuts
nnoremap <Leader>hp :Http<CR>
nnoremap <Leader>ha :HttpAuth<CR>
