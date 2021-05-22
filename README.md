# Personal dotfiles

[homeschick](https://github.com/andsens/homeshick) managed dot files.


If git repository locates in other path, link it.
```
ln -Ffs <path to dotfiles> ${HOME}/.homesick/repos/dotfiles
```

Map castle
```
homesick symlink dotfiles
```

## Other config
espano

Each OS has its own directory setting.  Checkout [https://espanso.org/docs/get-started/](https://espanso.org/docs/get-started/)

- Mac
``` sh
cd home/.config/espanso
ln -s $PWD $HOME/Library/Preferences/espanso
````
-Win
TODO

