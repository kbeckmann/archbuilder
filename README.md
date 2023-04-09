# kbeckmann/archbuilder: Build machine running archlinux

This is a simple Docker environment for building packages in an Archlinux environment.

`yay` will be installed. Useful in order to test if packages have undocumented dependencies.

`asp` will be installed. Useful to build official packages with other build flags quickly.

I had some problems building a package on my machine, so in order to confirm this wasn't a local issue, I made this Dockerfile so that others can reproduce the issues i was facing.

## Example
```
$ docker pull kbeckmann/archbuilder
$ docker run -ti kbeckmann/archbuilder
[docker@53642656badd opt]$ yay -S stupidterm-git
... installing dependencies
... building
... installing your package
```



