call pathogen#runtime_append_all_bundles()
call pathogen#infect()
" call pathogen#helptags()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Not bothered about vi compatibility
" This must be first, because it changes other options as side effect
set nocompatible
" set term=ansi

" this is a tpope plugin for normalizing vim
" including this here should run it before vimrc to allow overrides
" runtime! plugin/sensible.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" more secure
set modelines=0

" copy the previous indentation on autoindenting
" set copyindent

" dont autofold on start or load
" set foldlevelstart=99

" shows all options in edit wild mode
set wildmode=list:longest

" increase command history and undo
set history=1000
set undolevels=1000

" show the $ at the end of word changes etc
set cpoptions+=$

set number

" search highlights on, and dynamic searching
" set hlsearch

" These two options, when set together, will
" make /-style searches case-sensitive only
" if there is a capital letter in the search
" expression. *-style searches continue to
" be consistently case-sensitive.
set ignorecase
" set gdefault

set cursorline
" set ttyfast

" no old messy files
set nobackup
set noswapfile
set nowb

" allow hiding buffers with pending changes
set hidden

" defaults
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" set clipboard=unnamed

" save undo history in file
set undofile
set undodir=~/.cache/vim/undo

" Look for the file in the current directory,
" then south until you reach home.
"set tags=tags;~/
" add the tag file generated by ctag-bundler
set tags+=gems.tags
set tags+=~/zend.tags

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc,.vimrc source $MYVIMRC

" handle long lines
set nowrap
set textwidth=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Don't use Ex mode, use Q for formatting
map Q gq

" Fast saving
nmap <leader>w :w!<cr>

" clear search buffer when hitting return
" this is mapped to ctrl l in sensible
" but is is a good key to use for something
nnoremap <silent> <leader><space> :set nolist!<cr>

" dont use cursor keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
nnoremap <right> :bn<cr>
nnoremap <left> :bp<cr>
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" makes j and k work the way you expect
nnoremap j gj
nnoremap k gk

" make ; do the same thing as :
nnoremap ; :

"set formatoptions=qrn1
" set colorcolumn=80
" augroup vimrc_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
"   autocmd BufEnter * match OverLength /\%80v.*/
" augroup END

" map leader-W to strip white space
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" insert a hash rocket with <c-l>
imap <C-r> <space>=><space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
" https://destroyallsoftware.com/file-navigation-in-vim.html
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open files with <leader>f
map <leader>f :ClearCtrlPCache<cr>\|:CtrlP<cr>
map <leader>r :CtrlPMRU<cr>
map <leader>b :CtrlPBuffer<cr>
map <leader>B :BuffergatorOpen<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :ClearCtrlPCache<cr>\|:CtrlP %%<cr>

" ri.vim remaps
nnoremap <leader>ri :call ri#OpenSearchPrompt(0)<cr> " horizontal split
nnoremap <leader>RI :call ri#OpenSearchPrompt(1)<cr> " vertical split
nnoremap <leader>RK :call ri#LookupNameUnderCursor()<cr> " keyword lookup

" Rails specific
map <leader>ga :ClearCtrlPCache<cr>\|:CtrlP app<cr>
map <leader>gv :ClearCtrlPCache<cr>\|:CtrlP app/views<cr>
map <leader>gc :ClearCtrlPCache<cr>\|:CtrlP app/controllers<cr>
map <leader>gm :ClearCtrlPCache<cr>\|:CtrlP app/models<cr>
map <leader>gh :ClearCtrlPCache<cr>\|:CtrlP app/helpers<cr>
map <leader>gl :ClearCtrlPCache<cr>\|:CtrlP lib<cr>
map <leader>gp :ClearCtrlPCache<cr>\|:CtrlP public<cr>
map <leader>gs :ClearCtrlPCache<cr>\|:CtrlP app/assets/stylesheets<cr>
map <leader>gj :ClearCtrlPCache<cr>\|:CtrlP app/assets/javascripts<cr>
map <leader>gr :e config/routes.rb<cr>
map <leader>gg :e Gemfile<cr>

" Show the current routes in the split
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! bundle exec rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
" map <leader>v :view %%

" reselect the text that was just pasted
nnoremap <leader>v V`]

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Run this file
let g:vroom_map_keys = 0
silent! map <unique> <Leader>t :VroomRunTestFile<CR>
silent! map <unique> <Leader>T :VroomRunNearestTest<CR>

" retag the current zend project
silent! map <leader>q :!ctags --extra=+f --exclude=.git --tag-relative --exclude=log -R application library<cr>

" beautify php
silent! map <leader>p :% ! php_beautifier -s2 -l "IndentStyles(style=allman) ArrayNested() Lowercase() NewLines(before=T_CLASS:T_PUBLIC:T_PRIVATE:T_PROTECTED)"<CR>

" avoid pressing F1
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unused mappings ATM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fold html tag
"nnoremap <leader>ft Vatzf

" double j for escape
"inoremap jj <ESC>

" use tab to move around brackets
"nnoremap <tab> %
"vnoremap <tab> %

" Close the current buffer
"map <leader>bd :bd<cr>

if has("autocmd")
  augroup vimrcEx
    autocmd!

    " what does this do?
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
  augroup END

  augroup FTOptions
    autocmd!

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Ruby
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    autocmd BufNewFile,BufRead Rakefile,*.rake,*.pill,Capfile,Gemfile,config.ru,Guardfile setfiletype ruby
    autocmd BufNewFile,BufRead *.scss.erb setfiletype scss.eruby
    autocmd BufNewFile,BufRead *.js.erb setfiletype javascript.eruby
    autocmd BufNewFile,BufRead *.coffee.erb setfiletype coffeescript.eruby
    autocmd BufNewFile,BufRead *.html.erb setfiletype html.eruby

    autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd Filetype ruby setlocal ts=2 sts=2 sw=2 expandtab
    autocmd Filetype javascript setlocal ts=4 sts=4 sw=4 expandtab
    autocmd Filetype go setlocal ts=2 sts=2 sw=2 noexpandtab

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " PHP
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    autocmd BufRead *.phtml set filetype=php
    " highlights interpolated variables in sql strings and does sql-syntax highlighting. yay
    autocmd FileType php let php_sql_query=1
    " does exactly that. highlights html inside of php strings
    autocmd FileType php let php_htmlInStrings=1

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Other languages
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    autocmd BufNewFile,BufRead *.mustache set syntax=mustache
    autocmd BufNewFile,BufRead *.ol setfiletype lisp
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd BufNewFile,BufRead *.md,*.markdown,README,*.txt set spell
    autocmd BufNewFile,BufRead *.jst set syntax=eruby
    autocmd BufNewFile,BufRead *.jst.tpl set syntax=jst

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Omnifunc
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    autocmd FileType ruby,eruby silent! setlocal omnifunc=rubycomplete#Complete
    autocmd FileType php silent! setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType javascript silent! setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html silent! setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css,scss silent! setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml silent! setlocal omnifunc=xmlcomplete#CompleteTags

  augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
set encoding=utf-8
set t_Co=16

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundles config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map for ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
nnoremap <leader>a :Ack

let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': ['ruby', 'php'],
      \ 'passive_filetypes': [] }

let g:ctrlp_custom_ignore = {
      \ 'dir':  'tmp\|\.git$\|system\|images\|uploads$',
      \ 'file': '\.jpg$\|\.pdf$\|\.png$\|\.gif$',
      \ }

let g:buffergator_suppress_keymaps = 1
let g:vroom_detect_spec_helper = 1
let g:slime_target = "tmux"

" add trailing white space indicator to power line
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')
let g:Powerline_symbols = 'unicode'
let g:Powerline_colorscheme="skwp"

" PIV disable php folding
let g:DisableAutoPHPFolding = 1

" this is for the switch plugin
nnoremap - :Switch<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display after bundles
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:solarized_termtrans=1
let g:solarized_termcolors=16
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"
colorscheme solarized

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
