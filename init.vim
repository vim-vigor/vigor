"
" vim-vigor: An opinionated, yet customizable vim distribution.
"
" This file is only a loader for other files. All of the functionality of this
" distribution comes from enabling layers.
"


" Bootstrap {{{
	" Find the path of the current script, and then source vigor_bootstrap.vim.
	let s:current_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
	execute 'source ' . fnameescape(s:current_path . "/layers/bootstrap/vigor_bootstrap.vim")

	" Source the user's early bootstrap file.
	call SourceUserFile('bootstrap')

	" The user must tell us what to enable, or we aren't going to do anything at all.
	let g:layers = []
	call SourceUserFile('layers')
" }}}

" Early {{{
	" Source all layers' early.vim file, preferring the user's copy if it's present.
	for layer in g:layers
		call SourceLayerFile(layer, 'early')
	endfor

	" Source the user's early.vim file if it's present.
	call SourceUserFile('early')
" }}}

" Plugins {{{
	" Set up plugins.
	call plug#begin(g:vigor_home . '/plugins')
		" Set up plugins that layers depend on.
		for layer in g:layers
			call SourceLayerFile(layer, 'plugins')
		endfor

		" Install any additional plugins that the user has requested outside of a
		" layer.
		call SourceUserFile('plugins')
	call plug#end()

	" Install missing plugins on startup.
	if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
		echo "Installing missing plugins. Please wait..."
		PlugInstall | q
		echo "Done!"
	endif
" }}}

" Config {{{
	" Source layer config.
	for layer in g:layers
		call SourceLayerFile(layer, 'config')
	endfor

	" Source the user's config.
	call SourceUserFile('config')
" }}}

" Keymap {{{
	" Source layer keymap.
	for layer in g:layers
		call SourceLayerFile(layer, 'keymap')
	endfor

	" Source the user's keymap.
	call SourceUserFile('keymap')
" }}}

" Late {{{
	" Source layer late config.
	for layer in g:layers
		call SourceLayerFile(layer, 'late')
	endfor

	" Source the user's late config.
	call SourceUserFile('late')
" }}}
