" BASIC SETUP:
set noro
set modifiable

function! FindProjectRoot()
  " Prefer current buffer's dir, otherwise fallback to cwd
  let l:startdir = expand('%:p:h')
  if empty(l:startdir)
    let l:startdir = getcwd()
  endif

  " If .project_root exists right here
  if filereadable(fnamemodify(l:startdir, ':p') . '/.project_root')
    return fnamemodify(l:startdir, ':p')
  endif

  " Otherwise look upwards for .project_root
  let l:root = findfile('.project_root', l:startdir . ';')
  if empty(l:root)
    return fnamemodify(l:startdir, ':p')
  endif

  return fnamemodify(l:root, ':p:h')
endfunction

let g:project_root = FindProjectRoot()

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
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-latex/vim-latex'
Plug 'tpope/vim-sleuth'
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" vim-gutentags
let g:gutentags_add_default_project_roots = 1
let g:gutentags_project_root = ['src']
let g:gutentags_enabled = 0
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--recurse=yes', '--languages=C,C++,Make', '--c-kinds=+p', '--c++-kinds=+p']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_save = 1

" Enable ALE
let g:ale_enabled = 1

let g:ale_completion_enabled = 1

let g:ale_pattern_options = {
      \ '.*': {'ale_lint_cwd': 'project'},
      \}

" Enable specific linters (optional)
let g:ale_linters = {
\   'c': ['gcc'],
\}

" Function to build recursive -I flags from a given root directory
let g:ale_c_cc_options = '-Wall -Wextra -I/usr/include -I/usr/local/include '
let g:curdir = findfile('ale_completion.vim', g:project_root . ';')
if !empty(g:curdir)
  execute 'source ' . g:project_root . '/ale_completion.vim'
endif

" Enable real-time linting (optional)
" let g:ale_lint_on_text_changed = 'always'
" Enable automatic linting when the file is saved
" let g:ale_lint_on_save = 1

" Display error messages in a popup or the status line
let g:ale_echo_err = 1
let g:ale_echo_msg_error_str = 'Error: '
let g:ale_echo_msg_warning_str = 'Warning: '

" Show linting errors in the sign column
let g:ale_sign_column_always = 1

" Optional: Set make to run with the -n option to simulate a dry run
" let g:ale_makeprg = 'make -n'

" To see the linting messages, you can use :ALEDetail or :ALELint.
" You can trigger linting with :ALELint, show errors with :ALEDetail, and navigate through errors with :ALENext or :ALEPrevious.

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:livepreview_previewer = 'python3'
let g:livepreview_previewer = 'evince'
let g:livepreview_cursorhold_recompile = 0
let g:livepreview_use_biber = 1
let g:Imap_UsePlaceHolders = 0

" Initialize configuration dictionary
let g:fzf_vim = {}

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
" set noexpandtab
" set autoindent
" set fileformat=unix

" Set split to the right and below
set splitright
set splitbelow

" Enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" Enable relative numbers and colorscheme
set relativenumber
colorscheme industry

" Enable status bar
 set statusline=
 set statusline+=%y\       " File Type
 set statusline+=%F\       " Full File Path
 set statusline+=%m\       " [+] if modified
 set statusline+=%r\       " [RO] if read-only
 set statusline+=%=        " Right align the next items
 set statusline+=%{gutentags#statusline()} " Gutentags Status
 set statusline+=\ %c,%l/%L " Cursor Position: column, line/total lines

set laststatus=2 " Always show statusline

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
let g:curdir = findfile('tags.vim', g:project_root . ';')
if !empty(g:curdir)
  execute 'source ' . g:project_root . '/tags.vim'
endif

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

" Tell Vim to use ALE for omni completion
set omnifunc=ale#completion#OmniFunc
" For C/C++
" set omnifunc=ccomplete#Complete

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

" Show tabs as »
set list
set listchars=tab:»\ ,trail:·

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
nnoremap <silent> <leader>[ :tabp<CR>

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" vsplit
nnoremap <leader>w :vsplit<cr>
nnoremap <leader>W :split<cr>

" Autocomment
vnoremap <leader>c <c-v>^I//<Esc>
vnoremap <leader>C <c-v>^o^lx

" Wrap
vnoremap " s""<Esc>P
vnoremap { s{}<Esc>P
vnoremap [ s[]<Esc>P
vnoremap ( s()<Esc>P

" move selected line up
vnoremap <C-j> dpV
vnoremap <C-k> dkPV

" Open bottom terminal
nnoremap <C-\> :term<CR><C-w>w:set winheight=38<CR><C-w>w

" Harpoon
nnoremap <leader>h :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>H :lua require("harpoon.ui").toggle_quick_menu()<CR>

" FZF
nnoremap <leader>f :BLines<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>g :BCommits<CR>
nnoremap <leader>G :Commits<CR>

" Completion
" pumvisible() returns 1 (true) if the popup menu (the completion menu that drops down with suggestions) is currently visible.
" inoremap <C-n> <>
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-x><C-o>'
" inoremap <expr> <C-p> pumvisible() ? '<C-p>' : '<C-x><C-o>'

" Jumps
" nnoremap <leader>] :tnext<CR>
" nnoremap <leader>t :tprev<CR>
