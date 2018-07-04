" Gui {{{
	" Source layer gui config.
	for layer in g:layers
		call SourceLayerFile(layer, 'gui')
	endfor

	" Source the user's gui config.
	call SourceUserFile('gui')
" }}}

