" this is to receive CTRL-S and CTRL-Q
silent !stty -ixon > /dev/null 2>/dev/null

" disable vi compatibility (emulation of old bugs)
set nocompatible

" setup Vundle (run :PluginInstall to install plugins)
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugin to enable Vundle 
Plugin 'VundleVim/Vundle.vim'

" plugin to enable git integration
Plugin 'tpope/vim-fugitive'

" plugins to enable snippets support
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" enable NERD tree - allows you to explore your filesystem 
" and to open files and directories.
Plugin 'scrooloose/nerdtree.git'

" enable CTRLP - Full path fuzzy file, buffer, mru, tag, 
" etc, finder for Vim
Plugin 'kien/ctrlp.vim'

" enable linuxsty - Linux Kernel Coding Style
Plugin 'vivien/vim-addon-linux-coding-style'

" enable doxygen plugin
Plugin 'mrtazz/DoxygenToolkit.vim'

" enable Wordpress Integration plugin
Plugin 'vim-scripts/VimRepress'

" syntax checking plugin for Vim that runs files through external syntax
" checkers and displays any resulting errors to the user.
Plugin 'scrooloose/syntastic'

" buffer explorer
Plugin 'jlanzarotta/bufexplorer'

"enable GDB integration
Plugin 'vim-scripts/Conque-GDB'

" end of Vundle initialization
call vundle#end()
filetype plugin indent on
filetype on

" disable Linux Kernel Coding Style
let g:loaded_linuxsty=1

" set path variable to current directory (from which you launched vim)
" and to all directories under current directory recursively
set path=$PWD/**

" set spell check
"autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=pt
"autocmd FileType gitcommit set spell spelllang=en
"autocmd FileType txt setlocal spell spelllang=pt
" set spell spelllang=en

" autocomplete words
set complete+=kspell

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" wrap lines at 120 chars.
" set textwidth=120

" show column number
set ruler

" turn syntax highlighting on
syntax on

" turn line numbers on
"set number

" highlight matching braces
set showmatch

" enhanced tab completion on commands
set wildmenu
set wildmode=longest:list,full

" buffer can be in the background if it’s modified
set hidden

" Search
set hlsearch     " highlight matches
set incsearch    " incremental searching
set ignorecase   " searches are case insensitive...
set smartcase    " ... unless they contain at least one capital letter

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="-------------------------------"
let g:DoxygenToolkit_blockFooter="---------------------------------"
let g:DoxygenToolkit_authorName="Sergio Prado <sergio.prado@e-labworks.com>"
let g:DoxygenToolkit_licenseTag="MIT"

" MyNext() and MyPrev(): Movement between tabs OR buffers
function! MyNext()
    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
        " Tab support && tabs open
        normal gt
    else
        " No tab support, or no tabs open
        execute ":bnext"
    endif
endfunction
function! MyPrev()
    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
        " Tab support && tabs open
        normal gT
    else
        " No tab support, or no tabs open
        execute ":bprev"
    endif
endfunction

" OmniCppComplete options
let OmniCpp_NamespaceSearch = 1      
let OmniCpp_GlobalScopeSearch = 1      
let OmniCpp_ShowAccess = 1      
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1      
let OmniCpp_MayCompleteArrow = 1      
let OmniCpp_MayCompleteScope = 1      
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window      
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif      
set completeopt=menuone,menu,longest,preview

" cscope
set cscopetag

" tags definition
set tags+=tags;                     " search tags automagically

" project tags
" let g:ProjTags = ["/opt/labs/ex/02/linux/"]
" let g:ProjTags = [["/opt/labs/ex/", "/opt/labs/ex/02/linux/tags"]]

" open a NERDTree automatically when vim starts up if no files were specified
" autocmd vimenter * if !argc() | NERDTree | endif

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" exclude files and directories using Vim's wildignore and CtrlP's own g:ctrlp_custom_ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" CTRLP configuration
let g:ctrlp_by_filename = 1
let g:ctrlp_switch_buffer = 't'

" Syntastic configuration (source code syntax checking)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1
let b:syntastic_mode = 'passive'
let g:syntastic_c_checkers=['gcc','cppcheck']

" ConqueGDB configuration
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly

" COMMANDS ALIAS
ca gdb ConqueGdb

" MAPPINGS

" (F2, CTRL-S) Save file
nmap <c-s> :w<CR>
imap <c-s> <c-o><c-s>
nmap <F2> :w<CR>
imap <F2> <c-o><F2>

" (CTRL-Q) close file
nmap <c-q> :q<CR>
imap <c-q> <c-o><c-q>

" (F5) Build tags of your own project
map <F5> <ESC>:!ctags -R --extra=+fq --c-kinds=+px --fields=+iaS .<cr><cr>

" (F6) create doxygen comment
map <F6> <ESC>:Dox<CR>
" map <F6> <ESC>:DoxAuthor<CR>

" (F7, CTRL-B) Build project
"nmap <C-b> :make<CR>
"nmap <C-b> :make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- uImage<CR>
"nmap <C-b> :make <CR>
nmap <C-b> :make && make install <CR>
imap <C-b> <c-o><c-b>
nmap <F7>  <C-b>
imap <F7>  <c-o><F7>

" (F8) Open file explorer
map <silent> <F8> <ESC>:Explore<CR>

" (F12) buffer explorer
noremap <silent> <F12> <ESC>:BufExplorer<CR>

" (CTRL-T, CTRL-right, CTRL-left, L, H) tabs/buffer management
nnoremap <C-t> <ESC>:tabnew<CR>
map <C-Right> <ESC>:tabnext<CR>
map <C-Left> <ESC>:tabprev<CR>
nnoremap L <ESC>:call MyNext()<CR>
nnoremap H <ESC>:call MyPrev()<CR>

" (CTRL-O) open nerd tree
nnoremap <C-o> <ESC>:NERDTreeToggle<CR>

" (CTRL_A, CTRL-I) change to *.C/*.H file 
nnoremap <C-a> <ESC>:A<CR>
nnoremap <C-i> <ESC>:IH<CR>

" (CTRL-P) go back to previous tag
nnoremap <C-p> <ESC>:pop<CR>

" (CTRL-W ]) Open tag under cursor in new tab
nnoremap <C-W>] <C-W>]:tab split<CR>gT:q<CR>gt 

" default command to invoke CtrlP:
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
