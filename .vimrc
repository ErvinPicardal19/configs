" BASIC SETUP:

set noro
set modifiable

" Plugins
call plug#begin("~/.vim/plugged")

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

Plug 'dense-analysis/ale'

call plug#end()

" Enable ALE
let g:ale_enable = 1

" Enable specific linters (optional)
let g:ale_linters = {
\   'c': ['clang', 'clang-tidy-18', 'gcc'],
\   'make': ['make'],
\}

" Enable real-time linting (optional)
let g:ale_lint_on_text_changed = 'always'
" Enable automatic linting when the file is saved
let g:ale_lint_on_save = 1

" Display error messages in a popup or the status line
let g:ale_echo_err = 1
let g:ale_echo_msg_error_str = 'Error: '
let g:ale_echo_msg_warning_str = 'Warning: '

" Show linting errors in the sign column
let g:ale_sign_column_always = 1

" Optional: Set make to run with the -n option to simulate a dry run
let g:ale_makeprg = 'make -n'

" To see the linting messages, you can use :ALEDetail or :ALELint.
" You can trigger linting with :ALELint, show errors with :ALEDetail, and navigate through errors with :ALENext or :ALEPrevious.

" ----------------------- BASIC NATIVE VIM SETUP -----------------------

" Allow backspace
set backspace=indent,eol,start

" Set compatibility to Vim only
set nocompatible
" Set encoding
set encoding=utf-8

" Set tab size to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Convert tabs to spaces
set expandtab
set autoindent
set fileformat=unix

" Set split to the right and below
set splitright
set splitbelow

" Enable syntax and plugins (for netrw)
" syntax enable
" filetype plugin on

" Enable relative numbers and colorscheme
set relativenumber
colorscheme habamax

" Enable status bar
set laststatus=2

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" TAG JUMPING:

" Create the 'tags' file (may need to install ctags first)
command! MakeTags !ctags -R --languages=C,C++,Make --c-kinds=+p --make-kinds=+p -f tags . /usr/include /usr/local/include

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|
set completeopt=menuone,noinsert,noselect
" menuone: Shows a menu even if there's only one completion result.
" noinsert: Prevents the first completion from being inserted automatically.
" noselect: Prevents automatic selection of the first completion result.

" Enable completion from other open buffers
set complete+=k

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN: 
" - Use ^n and ^p to go back and forth in the suggestion list

" FILE BROWSING:
" Tweaks for browsing
let g:netrw_banner=0		" disable annoying banner
let g:netrw_browse_split=4	" open in prior window
let g:netrw_altv=1		" open splits to the right
let g:netrw_liststyle=3		" tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" MAPPINGS:
let mapleader = "\<Space>"
" Reload .vimrc
nnoremap <leader>r :source $MYVIMRC<CR>
" Save
nnoremap <C-s> :w<CR>

nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

" Create new tab
nnoremap <leader>t :tabnew<CR>
nnoremap <silent> <leader>] :tabn<CR>
nnoremap <silent> <leader>[ :tabp<cr>

" vsplit
nnoremap <leader>w :vsplit<cr>
nnoremap <leader>W :split<cr>

" move selected line up
vnoremap <C-j> dpV
vnoremap <C-k> dkPV

" Open bottom terminal
nnoremap <C-\> :term<CR><C-w>w:set winheight=38<CR><C-w>w

