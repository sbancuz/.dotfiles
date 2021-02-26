  " Install plugins
  if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
      !sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    auto VimEnter * PlugInstall
  endif

  " Install fzf and rg
  if !empty(glob("~/.fzf/bin/fzf"))
    if empty(glob("~/.fzf/bin/rg"))
      silent !curl -fLo /tmp/rg.tar.gz
              \ https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep-0.10.0-x86_64-unknown-linux-musl.tar.gz
      silent !tar xzvf /tmp/rg.tar.gz --directory /tmp
      silent !cp /tmp/ripgrep-0.10.0-x86_64-unknown-linux-musl/rg ~/.fzf/bin/rg
    endif
  endif

" Plugins will be downloaded under the specified directory.
  call plug#begin('~/.vim/plugged')

" Declare list of plugins
  Plug 'tpope/vim-sensible'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'                                              
  Plug 'neoclide/coc.nvim', {'branch': 'release'}  
  Plug 'unblevable/quick-scope'
  Plug 'chrisbra/Colorizer'
  Plug 'scrooloose/nerdtree'  
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'tpope/vim-fugitive'
  Plug 'puremourning/vimspector'
" Color scheme
  Plug 'phanviet/vim-monokai-pro'

" Bottom line
  Plug 'itchyny/lightline.vim'

" List ends here. Plugins become visible to Vim after this call.
  call plug#end()

  set termguicolors
  colorscheme monokai_pro

  let g:lightline = {
      \ 'colorscheme': 'monokai_pro',
      \ }

" Other Configurations
  set fillchars+=vert:\ 
  set foldenable foldmethod=syntax foldlevelstart=99
  set autoindent
  set ignorecase smartcase
  set number relativenumber
  set cursorline
  set showmatch
  set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  set title
  set lazyredraw
  syntax enable
  set undofile
  set mouse=a 

" Search settings
  set ignorecase
  set incsearch
  set smartcase
  set scrolloff=10
  set hlsearch

  " debugger keys
  nnoremap <F1> :call vimspector#ToggleBreakpoint()<CR>
  nnoremap <F2> :call vimspector#Continue()<CR>
  nnoremap <F3> :call vimspector#Restart()<CR>
  nnoremap <F4> :call vimspector#Reset()<CR>
  
  " coc bindings
  nnoremap <F5> :call CocActionAsync('doHover')<cr>
  nnoremap <S-F5> :call CocActionAsync('showSignatureHelp')<cr>
  nnoremap <F6> :call CocActionAsync('rename')<cr>
  nnoremap <F7> :call CocAction('jumpReferences')<cr>
  nnoremap <F8> :CocAction<cr>

" fzf config
  nnoremap <C-p> :Files<cr>
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-i': 'split',
    \ 'ctrl-s': 'vsplit' }
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \ -g "*.{tf,yml,yaml,vim,viml,tsx,ts,js,jsx,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,graphql,gql,sql}"
    \ -g "!{.config,.git,node_modules,vendor,yarn.lock,*.sty,*.bst,build,dist}/*" '

  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command . shellescape(<q-args>), 1, <bang>0)
  command! -bang -nargs=* FU call fzf#vim#grep(g:rg_command . '-m1 ' . shellescape(<q-args>), 1, <bang>0)

