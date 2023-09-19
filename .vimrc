" For plugins to load correctly
filetype plugin indent on
set encoding=utf-8

filetype on	    " enable file type detection
syntax on	    " syntax highlighting

:colorscheme default
set shiftwidth=4
set softtabstop=4
set textwidth=100
set colorcolumn=100
highlight ColorColumn ctermbg=darkgray

" set statusline display
set statusline=%F%m%r%h%w\ [POS=%l,%v][%p%%]\ [BUFFER=%n]}

set showmode
" Line numbers
set nu
set numberwidth=1   " In order to have the line of 100 character fitting a half window
set smartindent
set smarttab
" Ignore case in search
set ignorecase
" Highlight search
set hlsearch
" Replace the tabs by spaces
set expandtab
set ruler
set rulerformat=%l,%v
" Look in the current directory for tags, and work up the tree towards root until found.
set tags=./tags;/

" Show trailing whitespace:
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd Syntax * syn match ExtraWhitespace /\s\+$/

" Remap escape to jk
inoremap jk <esc>
" This mapping needs to have vim +xterm_clipboard when executing vim --version
vnoremap <C-c> "+y

" Example of conditional mapping (the visual check doesn't work)
"noremap <expr> <C-j> (mode() == "\<C-V>") ? 'c<C-r>0<ESC>' : 'caw<C-r>0<ESC>'
"
" Leader key
let mapleader = "\<Space>"
" Execute current file
nnoremap <leader>e :!%:p<Enter>
" To open a terminal as a split window
nnoremap <leader>t :terminal<CR>
" To escape terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
" Resize current window
nnoremap <C-j> :resize +5<CR>
nnoremap <C-k> :resize -5<CR>
nnoremap <C-l> :vertical resize +5<CR>
nnoremap <C-h> :vertical resize -5<CR>
nnoremap <leader>th <C-w>t<C-w>H
nnoremap <leader>tk <C-w>t<C-w>K
" To replace with the last copied buffer
vnoremap <leader>r c<C-r>0<ESC>
nnoremap <leader>r ciw<C-r>0<ESC>
" To remove the search highlight of the previous search
nnoremap <leader><Space> :nohlsearch<CR>
" To remove all extra spaces of the file
map <leader><Space> :%s/\s\+$//e<CR>
" To replace the CURRENT word
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
" To search the CURRENT word and search word
nnoremap <Leader>sc /\<<C-r><C-w>\><CR>
nnoremap <Leader>sw /\<\><Left><Left>
" To search the current visual selection
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
" Note here that \V is to specify very no magic :help /\V all literals, escape backslash

" Trying to remove the work inbetween two underscore
nnoremap ca_ dt_cT_

" Yank the current visual selection in the z buffer and / search for it
"vnoremap <Leader>s "zy/<C-r>z<CR>


"" Comment a line in C++ mode
"map <C-c> ^i//<ESC>
"map <C-u> ^xx<ESC>
" B for browse
map <C-y> :NERDTree<CR>
"map <C-t> :help NERDTree.txt<CR>
map <C-p> :set paste<CR>
map <C-n> :set nopaste<CR>
" Move the split bar
map <S-h> <C-W><
map <S-l> <C-W>>
"map <S-j> <C-W>-
map <S-k> <C-W>+
" To remap the opening of an include file in a split (instead of the same window)
nnoremap gf <C-W>f
vnoremap gf <C-W>f
" To wrap a word or a visual selection with `` (code spec in markdown)
nnoremap cow ciw``<Esc>P
vnoremap cow c``<Esc>P

" In order to glob the name of the file to split with
command -nargs=1 Vs exe 'vs' . '**/*' . <q-args> . '*'
command -nargs=1 Sp exe 'sp' . '**/*' . <q-args> . '*'
command Sex exe 'Sexplore'
command Vex exe 'Vexplore'
" In order to still open the splits when several files found
command Sps -nargs=+ exe 'args' . '**/*' . <q-args> . '*' . ' | argdo split'
command Vss -nargs=+ exe 'args' . '**/*' . <q-args> . '*' . '\ \|\ argdo\ vsplit'
"command -nargs=? Vss exe 'vs' . '**/*' . <q-args> . '*'
"command -nargs=? Sps exe 'sp' . '**/*' . <q-args> . '*'

" To replace each line by its line number
command LineNumber :%s/^/\=line(".") . ". "/g

" Replace on the line
function! ReplFunc(...) abort
    " a:0 is the number of argument
    exec 's/' . a:1 . '/' . a:2 . '/gc'
endfunction
command! -nargs=+ R :call ReplFunc(<f-args>)
" Replace in all file
function! ReplAllFunc(...) abort
    " a:0 is the number of argument
    exec '%s/' . a:1 . '/' . a:2 . '/gc'
endfunction
command! -nargs=+ Ra :call ReplAllFunc(<f-args>)
" Replace word
function! ReplAllWordFunc(...) abort
    " a:0 is the number of argument
    exec '%s/\<' . a:1 . '\>/' . a:2 . '/gc'
endfunction
command! -nargs=+ Rw :call ReplAllWordFunc(<f-args>)

" Comment the current line
function CommentLines()
    exe "norm!^i" .g:Comment. ""
    exe "norm!$i" .g:EndComment. ""
endfunction
noremap co :call CommentLines()<CR>

" Sam mapping to rotate between line numbering, relative nb and no numbers
"noremap <silent> <Leader>n :if &number<bar>set nonumber<bar>set rnu<bar>elseif &rnu<bar>set nornu<bar>else<bar>set number<bar>endif<cr>

" List all the files if several matches
set wildmenu
set wildmode=list:longest,full

" Macros
"let @p='oprintf("\n");jk'   "Here the escape is mapped by jk

" To syntax highlight according to filetype
au BufNewFile,BufRead *.vert,*.frag,*.glsl,*.comp set filetype=cpp
au BufNewFile,BufRead *.tpp set filetype=cpp
au BufNewFile,BufRead *.cl set filetype=cpp
au BufRead,BufNewFile *.pc set filetype=pc
" The rest is defined in each syntax/*.vim files

" This plugin manager installs all the plugins in the bundle directory
" To check if the plugin is installed type :help <plugin_name>

" Load all vim packages
packloadall

" Tagbar
nmap <F2> :TagbarToggle<CR>

" Ctrlp  (https://github.com/ctrlpvim/ctrlp.vim)

" Vista  (https://github.com/liuchengxu/vista.vim)
  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

  set statusline+=%{NearestMethodOrFunction()}

  " By default vista.vim never run if you don't call it explicitly.
  "
  " If you want to show the nearest function in your statusline automatically,
  " you can add the following line to your vimrc
  autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

  " How each level is indented and what to prepend.
  " This could make the display more compact or more spacious.
  " e.g., more compact: ["▸ ", ""]
  " Note: this option only works for the kind renderer, not the tree renderer.
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

  " Executive used when opening vista sidebar without specifying it.
  " See all the avaliable executives via `:echo g:vista#executives`.
  let g:vista_default_executive = 'ctags'

  " Set the executive for some filetypes explicitly. Use the explicit executive
  " instead of the default one for these filetypes when using `:Vista` without
  " specifying the executive.
  let g:vista_executive_for = {
    \ 'cpp': 'vim_lsp',
    \ 'php': 'vim_lsp',
    \ }

  " Declare the command including the executable and options used to generate ctags output
  " for some certain filetypes.The file path will be appened to your custom command.
  " For example:
  let g:vista_ctags_cmd = {
        \ 'haskell': 'hasktags -x -o - -c',
        \ }

  " To enable fzf's preview window set g:vista_fzf_preview.
  " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
  " For example:
  let g:vista_fzf_preview = ['right:50%']
    " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
  let g:vista#renderer#enable_icon = 1

  " The default icons can't be suitable for all the filetypes, you can extend it as you wish.
  let g:vista#renderer#icons = {
  \   "function": "\uf794",
  \   "variable": "\uf71b",
  \  }

" Ultisnips
    let g:UltiSnipsExpandTrigger="<c-l>"    "No tab if we use YouCompleteMe
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="horizontal"

" YCM
    " Disable (=0) the question to load ycm_extra_conf.py and load it automatically
    "let g:ycm_confirm_extra_conf = 1
    "let g:ycm_goto_buffer_command="split"
    "nnoremap <leader>jd :sp <CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>

    " Open split with possible definitions for the symbol
    nnoremap <leader>jd ::YcmCompleter GoToReferences<CR>
    nnoremap <leader>j ::YcmCompleter GoToDefinition<CR>
    nnoremap <leader>d ::YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>i ::YcmCompleter GoToInclude<CR>
    " To prevent the quickfix window from closing after opening a file
    autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave
    " To open the quickfix file in a split, mapping only valid in the qf win
    autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter>
    " Search symbols and add them to the quickfix window
    nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
    nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)
    let g:ycm_show_diagnostics_ui = 0
    " Shortcuts Ctrl-O to jump back


" clangd
    " Let clangd fully control code completion
    let g:ycm_clangd_uses_ycmd_caching = 0
    " Use installed clangd, not YCM-bundled clangd which doesn't get updates.
    let g:ycm_clangd_binary_path = exepath("clangd")
    " Command line flags
    let g:ycm_clangd_args = ['-log=verbose', '-pretty']

" Syntastic
    let g:syntastic_c_checkers=['make']
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_check_on_open=1
    let g:syntastic_enable_signs=1
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
    set statusline+=%#warningmsg#
"    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*gbar


" YCM
" go to definition of variable/type/function under cursor
nnoremap <leader>d  ::YcmCompleter GoTo<CR>
" print type of symbol under the cursor
nnoremap <leader>ty  ::YcmCompleter GetType<CR>
" use suggested fix when available
nnoremap <leader>f  ::YcmCompleter FixMe<CR>
" refactor the name under the cursor
nnoremap <leader>n  ::YcmCompleter RefactorRename<space>

"" Ctrl-P
"    "let g:ctrlp_prompt_mappings = {
"    "\ 'AcceptSelection("e")': ['<c-v>', '<2-LeftMouse>'],
"    "\ 'AcceptSelection("v")': ['<cr>', '<RightMouse>'],
"    "\ }
"    " (r) the nearest ancestor which has .git, or (a) current working dir if no ancestor
"    let g:ctrlp_working_path_mode = 'r'
"    let g:ctrlp_open_multiple_files = '2hjr'

filetype plugin indent on
