set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader = "," 
source $VIMRUNTIME/defaults.vim
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'vim-syntastic/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-rails' 
Plugin 'rking/ag.vim'
Plugin 'shmup/vim-sql-syntax'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'stephpy/vim-yaml'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'spacewander/openresty-vim'
Plugin 'ervandew/supertab'
Plugin 'vim-test/vim-test'
Plugin 'tpope/vim-dispatch'
Plugin 'shime/vim-livedown'
Plugin 'prabirshrestha/vim-lsp'

call vundle#end()            " required
filetype plugin indent on    " required
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd BufRead,BufNewFile nginx*.conf set filetype=nginx
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set tabpagemax=100

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_eruby_checkers = ['ruby', 'html/tidy']
let g:syntastic_html_tidy_exec = '/usr/local/bin/tidy'
let test#strategy = "basic"
:command! -nargs=1 Silent execute ':silent!!'.<q-args>.' &' | execute ':redraw!'
map <Leader><Leader> <c-^>  
map <leader>_ a<C-V>u0336<Esc><Space>
nmap <Leader><Leader>f :1,$d<bar>:0r !htmlbeautifier < % > /dev/stdout<CR>
nmap <silent><Leader>cf :echo @% <bar> :Silent echo % \| pbcopy   <CR>

nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nmap <leader>w <c-w><c-w>
nmap <leader>n :NERDTreeFind<CR>
nmap <silent>gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>:noh<CR>
nmap <silent> <leader><leader>t :TestNearest<CR>
nmap <silent> <leader><leader>T :TestFile<CR>
nmap <silent> <leader><leader>a :TestSuite<CR>
nmap <silent> <leader><leader>l :TestLast<CR>
nmap <silent> <leader><leader>g :TestVisit<CR>

filetype plugin indent on
set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set tabstop=8                                                " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set nu

let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:gitgutter_enabled = 0
nnoremap <leader>cd :cd %:p:h<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ag_working_path_mode="r"
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let $BASH_ENV="~/.vim/vim_bash"

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

filetype plugin on
set omnifunc=syntaxcomplete#Complete



if executable('standardrb')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'standardrb',
        \ 'cmd': ['standardrb', '--lsp'],
        \ 'allowlist': ['ruby'],
        \ })
endif

let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fixers = {'ruby': ['standardrb']}
let g:ale_fix_on_save = 1

let g:lsp_diagnostics_echo_cursor = 1
