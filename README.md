# vim-vigor

This project is a WIP! Feedback and help welcome, but don't expect stability
just yet.

Vigor is a distribution to manage your vim configuration in layers. Layers are a
combination of vim plugins and related configuration. The hope with Vigor is that
it will provide a solid foundation for the community to build layers on top of
that will work for everyone, as well as codify the "best practices" in the vim
community.

This repository will include other layers as submodules, but the only actual code
in this repository will be the basic framework for loading layers.

The core Vigor framework does *not* prescribe any particular way of doing things.
In fact, Vigor doesn't do anything *at all* unless a user tells it to.
