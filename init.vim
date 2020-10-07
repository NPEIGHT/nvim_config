autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeShowLineNumbers = 1
let g:coc_disable_startup_warning = 1
let g:coc_node_path = '/usr/bin/node'

set encoding=utf-8
set backspace=2
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set expandtab
set modelines=0
set cursorline
set cursorcolumn
colorscheme desert

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
function! MyTabLine()
    let s = ''
    let wn = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= '%' . i . 'T'
        let s .= (i == t ? '%1*' : '%2*')
        let s .= ' '
        let wn = tabpagewinnr(i,'$')

        let s .= '%#TabNum#'
        let s .= i
        " let s .= '%*'
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
        let bufnr = buflist[winnr - 1]
        let file = bufname(bufnr)
        let buftype = getbufvar(bufnr, 'buftype')
        if buftype == 'nofile'
            if file =~ '\/.'
                let file = substitute(file, '.*\/\ze.', '', '')
            endif
        else
            let file = fnamemodify(file, ':p:t')
        endif
        if file == ''
            let file = '[No Name]'
        endif
        let s .= ' ' . file . ' '
        let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
endfunction
set stal=2
set tabline=%!MyTabLine()
set showtabline=1
highlight link TabNum Special

set nu rnu
set foldmethod=indent
set helpheight=40

set background=dark
syntax on
filetype on

let mapleader= '\'
map <F5> :call Compile()<CR>
map <F6> :call Run()<CR>
map <F7> :call Debug()<CR>

nnoremap <silent> <leader>ee :e ~/.config/nvim/init.vim <CR>
"nnoremap <silent> <leader>ep :e ~/.dotfile/vim/preference/plugin.vim <CR>
"nnoremap <leader>w :w<CR>
"nnoremap <leader>c :call Compile()<CR><CR>:call Run()<CR>

nmap gi         <Plug>(coc-implementation)
nmap gd         <Plug>(coc-definition)
nmap gl         <Plug>(coc-declaration)     
nmap gr         <Plug>(coc-references)     
nmap <F8>       <Plug>(coc-diagnostic-next)
nmap <S-F8>     <Plug>(coc-diagnostic-prev-error)

nnoremap tn :tabNext<CR>
nnoremap tp :tabp<CR>


autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
"autocmd FileType c ClangFormatAutoEnabl
"autocmd FileType cpp ClangFormatAutoEnable

call plug#begin('~/.vim/plugged')

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdtree'
    Plug 'rhysd/vim-clang-format'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

call plug#end()

call coc#config('languageserver', {
            \"ccls": {
            \  "command": "ccls",
            \  "args":["-log-file=/tmp/ccls.log -v=1"],
            \  "filetypes": ["c", "cpp", "cuda", "objc", "objcpp"],
            \  "rootPatterns": [".ccls", "compile_commands.json"],
            \  "initializationOptions": {
            \    "cache": {
            \      "directory": ".ccls-cache"
            \    },
            \  }
            \}
            \})

