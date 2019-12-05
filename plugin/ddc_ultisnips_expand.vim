if exists('g:loaded_ddc_ultisnips_expand')
  finish
endif
let g:loaded_ddc_ultisnips_expand = v:true

let g:ddc_ultisnips_expand_debug = get(g:, 'ddc_ultisnips_expand_debug', v:false)

augroup ddc_ultisnips_expand
  autocmd!
  if has('#CompleteDonePre')
    autocmd CompleteDonePre * if complete_info(['mode']).mode !=? '' | call ddc_ultisnips_expand#on_complete_done(v:completed_item) | endif
  else
    autocmd CompleteDone * call ddc_ultisnips_expand#on_complete_done(v:completed_item)
  endif
augroup END

