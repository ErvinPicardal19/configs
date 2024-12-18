" BASIC SETUP:

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
syntax enable
filetype plugin on

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
command! MakeTags !ctags -R  -f tags . /usr/include

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

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

" Create new tab
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>] :tabn<CR>
nnoremap <leader>[ :tabp<cr>

" vsplit
nnoremap <leader>w :vsplit<cr>
nnoremap <leader>W :split<cr>

" move selected line up
vnoremap <C-j> dpV
vnoremap <C-k> dkPV

" Open bottom terminal
nnoremap <C-\> :term<CR><C-w>w:set winheight=38<CR><C-w>w
