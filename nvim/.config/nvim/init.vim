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
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'tpope/vim-fugitive'
  Plug 'puremourning/vimspector'
  Plug 'lambdalisue/suda.vim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'romgrk/barbar.nvim'
  Plug 'liuchengxu/vim-which-key'
  Plug 'akinsho/nvim-toggleterm.lua'
  Plug 'airblade/vim-gitgutter' 
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  Plug 'mhinz/vim-startify'
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
  set hidden
  set nobackup
  set nowritebackup
  set cmdheight=2
  set updatetime=300
  set shortmess+=c
  :hi NonText guifg=bg
  highlight LineNr guibg=bg
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

  " Nerd tree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  nnoremap <C-n> :NERDTreeTabsToggle<CR>
  let NERDTreeChDirMode=2
  let g:NERDTreeDirArrowExpandable = '├'
  let g:NERDTreeDirArrowCollapsible = '└'
  let g:NERDTreeMapActivateNode = '<tab>'

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

  " terminal
  lua << EOF
  require"toggleterm".setup{
    size = 10,
    open_mapping = [[<c-x>]],
    shade_filetypes = {},
    direction = 'horizontal',
  }
EOF

  " Colorizer
  let g:Hexokinase_highlighters = ['virtual']
  let g:Hexokinase_optInPatterns = [
  \     'full_hex',
  \     'triple_hex',
  \     'rgb',
  \     'rgba',
  \     'hsl',
  \     'hsla',
  \     'colour_names'
  \ ]
  
  auto VimEnter silent :HexokinaseToggle

  " Tabs
  let bufferline = get(g:, 'bufferline', {})
  let bufferline.animation = v:true
  let bufferline.auto_hide = v:false
  let bufferline.closable = v:true
  let bufferline.clickable = v:true
  let bufferline.icons = v:true
  let bufferline.icon_custom_colors = v:false
  let bufferline.icon_separator_active = '▎'
  let bufferline.icon_separator_inactive = '▎'
  let bufferline.icon_close_tab = ''
  let bufferline.icon_close_tab_modified = '●'
  let bufferline.maximum_padding = 4
  let bufferline.semantic_letters = v:true
  let bufferline.letters =
    \ 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP'
  let bufferline.no_name_title = v:null
  " Move to previous/next
  nnoremap <silent>    <A-,> :BufferPrevious<CR>
  nnoremap <silent>    <A-.> :BufferNext<CR>
  " Re-order to previous/next
  nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
  nnoremap <silent>    <A->> :BufferMoveNext<CR>
  " Goto buffer in position...
  nnoremap <silent>    <A-1> :BufferGoto 1<CR>
  nnoremap <silent>    <A-2> :BufferGoto 2<CR>
  nnoremap <silent>    <A-3> :BufferGoto 3<CR>
  nnoremap <silent>    <A-4> :BufferGoto 4<CR>
  nnoremap <silent>    <A-5> :BufferGoto 5<CR>
  nnoremap <silent>    <A-6> :BufferGoto 6<CR>
  nnoremap <silent>    <A-7> :BufferGoto 7<CR>
  nnoremap <silent>    <A-8> :BufferGoto 8<CR>
  nnoremap <silent>    <A-9> :BufferLast<CR>
  " Close buffer
  nnoremap <silent>    <A-c> :BufferClose<CR>
  
  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command . shellescape(<q-args>), 1, <bang>0)
  command! -bang -nargs=* FU call fzf#vim#grep(g:rg_command . '-m1 ' . shellescape(<q-args>), 1, <bang>0)

  " Git gutter
  let g:gitgutter_sign_added = '█'
  let g:gitgutter_sign_modified = '█'
  let g:gitgutter_sign_removed = '█'
  let g:gitgutter_sign_removed_first_line = '█'
  let g:gitgutter_sign_modified_removed = "█"
  highlight! link SignColumn LineNr
  highlight GitGutterAdd    guifg=#009900 ctermfg=2
  highlight GitGutterChange guifg=#bbbb00 ctermfg=3
  highlight GitGutterDelete guifg=#ff2222 ctermfg=1
  " Coc
  "
  " Autocompletion with tab
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  "
  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  "
  " Documentation
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  "
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
  "
  " Imoport organizer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
  "
  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " 
  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')
  "
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)
  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
