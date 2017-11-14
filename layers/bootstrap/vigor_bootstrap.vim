"
" vim-vigor bootstrap file
"
" This file contains basic startup settings for the Vigor distribution. Nothing
" that goes in this file should be objectionable to any users of Vigor, so it
" should only include the minimum amount of code needed to be able to run Vigor.
"

" Environment setup {{{
	" We need to determine if we're running in Neovim or not. Do the check once and
	" hang onto the result in a global.
	let g:vigor_is_neovim = has('nvim')

	" If we're running in Neovim mode, we need to know where the config base directory
	" is. By default, this is $XDG_CONFIG_HOME/nvim, but we need to make sure we have
	" that environment variable if we need it. We'll set it to the default value if
	" it's not already set.
	if g:vigor_is_neovim && empty($XDG_CONFIG_HOME)
		" Normally, we would avoid changing envvars, but since this is a fairly
		" standard one, we'll do it just this once.
		let $XDG_CONFIG_HOME = $HOME . '/.config'
	endif

	" Finally, we'll define the root directory of the config.
	let g:vigor_home = $HOME . "/.vim"
	if g:vigor_is_neovim
		let g:vigor_home = $XDG_CONFIG_HOME . "/nvim"
	endif

	" We'll also define a place where users can store their customizations.
	let g:vigor_userdir = $HOME . "/.vigor"
	execute "silent !mkdir -p " . g:vigor_userdir
" }}}


" Plugin manager {{{
	" We need a plugin manager to be able to do anything as Vigor starts up, so
	" we'll make sure we have one available here. Vigor currently uses vim-plug.
	if !filereadable(g:vigor_home . "/autoload/plug.vim")
		let s:plug_path = g:vigor_home . "/autoload/plug.vim"
		execute "silent !curl -fLo " . s:plug_path . " --create-dirs " .
			\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	endif
" }}}


" Utility functions {{{
	" Given a file suffix, this function will source a file from either the
	" user-defined layers or vigor's core layers.
	function! SourceLayerFile(layerName, suffix)
		let s:script_path = g:vigor_home . "/layers/" . a:layerName . "/" . a:layerName . a:suffix
		let s:user_layer_path = g:vigor_userdir . "/layers/" . a:layerName
		let s:userscript_path = s:user_layer_path . "/" . a:layerName . "." . a:suffix . ".vim"

		" If the layer directory exists in the user's layer dir, we shouldn't
		" look at Vigor's copy of the layer *at all*.
		if isdirectory(s:user_layer_path)
			if filereadable(s:userscript_path)
				source s:userscript_path
			endif
		elseif filereadable(s:script_path)
			source s:script_path
		endif
	endfunction

	" Given a name, source ~/.vigor/name.vim
	function! SourceUserFile(name)
		if filereadable(g:vigor_userdir . "/" . a:name . ".vim")
			source g:vigor_userdir . "/" . a:name . ".vim"
		endif
	endfunction
" }}}
