function DeleteHiddenBuffers()
	let tpbl=[]
	call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
	for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
		silent execute 'bwipeout' buf
	endfor
endfunction

function ShowFileFormatFlag(var)
	if ( a:var == 'dos' )
		return ' [dos] '
	elseif ( a:var == 'mac' )
		return ' [mac] '
	else
		return ''
	endif
endfunction

function ShowCurrentStatusLine()
	return 'StatusLine'
endfunction

function MoveToPrevTab()
	"there is only one window
	if tabpagenr('$') == 1 && winnr('$') == 1
		return
	endif
	"preparing new window
	let l:tab_nr = tabpagenr('$')
	let l:cur_buf = bufnr('%')
	if tabpagenr() != 1
		close!
		if l:tab_nr == tabpagenr('$')
			tabprev
		endif
		sp
	else
		close!
		exe "0tabnew"
	endif
	"opening current buffer in new window
	exe "b".l:cur_buf
endfunc

function MoveToNextTab()
	"there is only one window
	if tabpagenr('$') == 1 && winnr('$') == 1
		return
	endif
	"preparing new window
	let l:tab_nr = tabpagenr('$')
	let l:cur_buf = bufnr('%')
	if tabpagenr() < tab_nr
		close!
		if l:tab_nr == tabpagenr('$')
			tabnext
		endif
		sp
	else
		close!
		tabnew
	endif
	"opening current buffer in new window
	exe "b".l:cur_buf
endfunc

function YcmToggleUI()
	if g:ycm_show_diagnostics_ui
		let g:ycm_show_diagnostics_ui = 0
	else
		let g:ycm_show_diagnostics_ui = 1
	endif

	silent execute 'YcmRestartServer'
	silent execute 'e'
endfunc

function TagUnderCursor()
	let wordUnderCursor = expand("<cword>")
	silent execute 'Tags' wordUnderCursor
endfunction

function AgUnderCursor()
	let wordUnderCursor = expand("<cword>")
	silent execute 'Ag' wordUnderCursor
endfunction
