"
" .vimrc
"
" Vim configuration resource file.  Specifies desired
" behavior for the vim editor.
"

"
" Do some magic to get vim to do colors for terminal
" type 'xterm'.  Note these contain control characters.
"
if &term =~ "xterm"
    if has("terminfo")
        set t_Co=8
        set t_Sf=[3%p1%dm
        set t_Sb=[4%p1%dm
    else
        set t_Co=8
        set t_Sf=[3%dm
        set t_Sb=[4%dm
    endif
endif

"
" Fire up pathogen
"
execute pathogen#infect()

:set modeline          " Tell vim to look for a line in the file to
                       "     override settings (like tab stops)
:set showmode          " Tell you if you're in insert mode
:set tabstop=2         " Set the tabstop to 2 spaces
:set shiftwidth=2      " Shiftwidth should match tabstop
:set expandtab         " Convert tabs to <tabstop> number of spaces
:set nowrap            " Do not wrap lines longer than the window
:set nowrapscan        " Do not wrap to the top of the file while searching
:set ruler             " Show the cursor position all the time
:set showmatch         " Show matching [] () {} etc...
:set autoindent
:set nohlsearch        " Don't highlight strings you're searching for
:set formatoptions+=ro " Automatically insert the comment character when
                       "     you hit <enter> (r) or o/O (o) in a block comment
:set backspace=2       " Makes backspace work like you expect
:set report=0          " When doing substitutions, report the number of changes
:set background=dark   " Tell vim my background color is dark, so set
                       "     the colors appropriately
:set wildmenu          " Show menu on double-tab command completion
:set wildmode=list:longest,full " Control how 'wildmenu' things are listed
:set ttymouse=xterm2   " Enable mouse support in console vim
":set colorcolumn=80    " Highlight the 80th column -- help prevent long lines
:set cinoptions+=j1    " Format Java anonymous inner classes correctly.         
:set cinkeys-=0#       " Treat hash comments properly         
:set nu                " Set line numbers to on by default.
filetype on
filetype plugin indent on


:map <S-Enter>  O<ESC>
:map <Enter>    o<ESC>

"
" Switch syntax highlighting on, when the terminal can support colors
"
if &t_Co > 2 || has("gui_running")
    :syntax on
    "
    " Change the highlight color for Comment and Special
    " to Cyan.  Blue is too dark for a black background.
    "
    :highlight Comment  term=bold ctermfg=cyan guifg=cyan
    :highlight Special  term=bold ctermfg=cyan guifg=cyan
    :highlight Constant term=bold ctermfg=red  guifg=cyan
    :highlight cPreProc term=bold ctermfg=red  guifg=cyan
endif
":set background=dark


"
" Make vim turn *off* expandtab for files named Makefile or makefile
" We need the tab literal
"
:autocmd BufNewFile,BufRead [Mm]akefile* set noexpandtab


"
" Make vim recognize a file ending in ".template" be a C++ source file
"
:autocmd BufNewFile,BufRead *.template set filetype=cpp

"
" Make vim recognize a file ending in ".nc" as a nesC source file
"
:autocmd BufNewFile,BufRead *.nc set filetype=nc


"
" Make vim use 8 character tabstops and recognize # as a start-of-comment token
" in assembly source files
"
:autocmd BufNewFile,BufRead *.s set tabstop=8 noexpandtab | syn match asmComment "#"

"
" Set puppet files to ruby syntax highlighting
"
:autocmd BufNewFile,BufRead *.pp set syntax=ruby

"
" Set ruby files to ruby syntax
"
:autocmd BufNewFile,BufRead *.rb call SetRubyOptions()

"
" For now, we're doing 2 spaces for xml files
"
:autocmd BufNewFile,BufRead *.xml set shiftwidth=2 tabstop=2


"
" Make vim wrap e-mail text at 75 characters
"
augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
augroup END

:autocmd FileType mail set textwidth=75 | setlocal spell

"
" Use syntax highlighting for sshd.log
"
:autocmd BufRead sshd.log,postfix.log set filetype=messages


"                                                                               
" If I edit a .class file, load the buffer with the output of javap on that     
" class                                                                         
"                                                                               
augr class                                                                      
    au!                                                                             
    au BufNewFile,BufReadPost,FileReadPost *.class %!javap %:t:r                    
    au BufNewFile,BufReadPost,FileReadPost *.class set readonly                     
    au BufNewFile,BufReadPost,FileReadPost *.class set filetype=java                
    au BufNewFile,BufReadPost,FileReadPost *.class set nomodified                   
augr END                                                                        

"
" On the creation of a new .java file, automatically insert the class def
"
autocmd BufNewFile *.java
    \ exe "normal Opublic class " . expand('%:t:r') . " {\n}\<Esc>1G"

"
" Some ben stuff. Make the terminal clear on exit.
"
au VimLeave * :!clear

"au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"
"
" From the Ubuntu /etc/vim/vimrc file. Used to make vim open a file in the
" last position it was closed in. Only needed if such a line does not exist
" in vimrc that was loaded with the system.
"
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
endif

"
" Go support
"
if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif
set runtimepath+=/usr/lib/golang/misc/vim
filetype plugin indent on

"
" Format us some JSON
"
com! FormatJSON %!python -m json.tool 

"
" Ruby filetype options
"
function SetRubyOptions()
    setlocal syntax=ruby
    setlocal shiftwidth=2
    setlocal tabstop=2
endfunction
