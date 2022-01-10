" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2015 Mar 24
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Townk/vim-autoclose'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'steffanc/cscopemaps.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'lyuts/vim-rtags'
" fzf requires installed packages: fzf, rgrep
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" configure tags - add additional tags here or comment out not-used ones
set tags+=$HOME/.vim/tags/cpp
set tags+=$HOME/.vim/tags/qt4
" build tags of your own project with Ctrl-C

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file (restore to previous version)
	" Setting up backup folder
	set backupdir=$HOME/.vim/vimtmp,.
	set directory=$HOME/.vim/vimtmp,.
	set undofile		" keep an undo file (undo changes after closing)
endif
set ff=unix
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase		" needed for smartcase search
set smartcase		" case insensitive search if in lowercase
set hidden

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		autocmd BufReadPost *
					\ if line("'\"") >= 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END
else
	set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
	" Prevent that the langmap option applies to characters that result from a
	" mapping.  If unset (default), this may break plugins (but it's backward
	" compatible).
	set langnoremap
endif

"filetype on

" Cores
set term=screen-256color
colorscheme Tomorrow-Night-Bright

" Setting relative line numbering, which is really useful
set relativenumber
set number

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
syntax on
set hlsearch
"endif

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" Adjusting colors for YouCompleteMe
"highlight Pmenu ctermfg=15 ctermbg=1
"highlight YcmErrorLine ctermfg=13 ctermbg=15
"highlight YcmErrorSection ctermfg=13 ctermbg=15
"highlight YcmErrorSign ctermfg=13 ctermbg=15
"highlight YcmWarningSection ctermfg=13 ctermbg=9
"highlight YcmWarningSign ctermfg=13 ctermbg=9
" Highlighting line numbers
highlight LineNr ctermfg=2

" Column Settings
set cc=80
set cino=:0,:(0
highlight ColorColumn ctermbg=black
" highlight extra whitespace
highlight ExtraWhitespace ctermbg=blue guibg=blue
match ExtraWhitespace /\s\+\%#@<!$/

nmap <C-N> :bnext<CR>
nmap <C-P> :bprevious<CR>

let mapleader="," " remap leader key

" configure custom command to be run inside a tmux tab
" viml map <leader>nt :call VimuxRunCommand("<command-to-be-run>")
nnoremap <leader>fn :call VimuxRunCommand("find . -name ''")<Left><Left><Left>
nnoremap <leader>fi :call VimuxRunCommand("find . -iname ''")<Left><Left><Left>
nnoremap <leader>fg :call VimuxRunCommand("find . -name '' -exec grep '' {} \+")<Left><Left><Left>
nmap <leader>ma :call VimuxRunCommand("make all")<CR>
nmap <leader>mc :call VimuxRunCommand("make clean")<CR>
nmap <leader>md :call VimuxRunCommand("make debug")<CR>

nmap <leader>yd :YcmCompleter GoToDeclaration<CR>
nmap <leader>yf :YcmCompleter GoToDefinition<CR>
nmap <leader>yu :YcmCompleter GoToReferences<CR>
nmap <leader>yx :YcmCompleter FixIt<CR>
nmap <leader>yr :YcmCompleter RefactorRename<Space>

nnoremap ;; :%s:::g<Left><Left><Left>

" Command to Rg ignore filenames
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Maps for fzf
nnoremap <silent> <Leader>F :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>

" host specific confs
if hostname() == "ABELHA2626" " Autotrac config
	set visualbell

	" configure tabwidth and insert spaces instead of tabs
	setlocal noexpandtab tabstop=4 shiftwidth=4
	au BufEnter,BufNewFile *.h,*.c,*.cpp setlocal expandtab tabstop=3 shiftwidth=3 cc=172
	autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4

	" configure custom command to be run inside a tmux tab
	" viml map <leader>nt :call VimuxRunCommand("<command-to-be-run>")
	autocmd BufNewFile,BufRead ~/projetos/SDP_UCC/ucc/* nnoremap <leader>ma :call VimuxRunCommand("cd ./UccImageBaseDir && make -l dep all image ; cd -")<CR>
	autocmd BufNewFile,BufRead ~/projetos/SDP_UCC/ucc/* nnoremap <leader>mc :call VimuxRunCommand("cd ./App && make clean CROSS=arm ; cd -")<CR>
	autocmd BufNewFile,BufRead ~/projetos/SDP_UCC/ucc/* nnoremap <leader>ms :call VimuxRunCommand("./setup-projects.sh ssh")<CR>

else
	" configure tabwidth and insert spaces instead of tabs
	setlocal noexpandtab tabstop=4 shiftwidth=4
	autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4

endif

