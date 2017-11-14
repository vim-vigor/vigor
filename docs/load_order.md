# File load order

Vigor loads configuration in phases (in this order):

* Bootstrap: Early initialization for Vigor and anything that the user wants to do before anything else.
* Early: Post bootstrap, but still before plugins are configured.
* Plugins: Plugin definitions for vim-plug
* Config: Any integration with the rest of Vigor should normally happen here.
* Keymap: Any keymaps that a layer defines should happen here. This is intentionally separate from the config phase so that a user can find the keymaps easily.
* Late: Any configuration that needs to happen after everything else.

Here are the files that are loaded if they exist:

## Bootstrap
  * `$VIGOR_HOME/layers/bootstrap/vigor_bootstrap.vim`
  * `~/.vigor/bootstrap.vim`
  * `$VIGOR_HOME/layers/bootstrap/bootstrap.layers.vim`
  * `~/.vigor/layers.vim`

## Early
  * `$VIGOR_HOME/layers/*/*.early.vim`
  * `~/.vigor/early.vim`

## Plugins
  * `$VIGOR_HOME/layers/*/*.plugins.vim`
  * `~/.vigor/plugins.vim`

## Config
  * `$VIGOR_HOME/layers/*/*.config.vim`
  * `~/.vigor/config.vim`

## Keymap
  * `$VIGOR_HOME/layers/*/*.keymap.vim`
  * `~/.vigor/keymap.vim`

## Late
  * `$VIGOR_HOME/layers/*/*.late.vim`
  * `~/.vigor/late.vim`


# User layers

Users can also create layers in ~/.vigor/layers using the same filename patterns
as the Vigor layers. For instance, to create a layer `foo`, you might create:

  * `~/.vigor/layers/foo/foo.early.vim`
  * `~/.vigor/layers/foo/foo.plugins.vim`
  * `~/.vigor/layers/foo/foo.config.vim`
  * `~/.vigor/layers/foo/foo.keymap.vim`
  * `~/.vigor/layers/foo/foo.late.vim`

Note that none of these files are required, but they will be loaded if they exist.

If a layer is created that shares the same name as one of the Vigor layers, the
user's layer will be used instead in all cases except for the bootstrap layer.
