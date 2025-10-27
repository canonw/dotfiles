# dotfiles

A single repository to manage cross-platform, cross-shell dotfiles using [chezmoi](https://github.com/twpayne/chezmoi).

## Install

Follow the starter based on the operating system.  The setup assumes you have full admin right to setup the machine.

### Windows

### macOS on ARM

Package management

- [Homebrew](https://brew.sh/)

### Ubuntu WSL

run the following command
``` sh
chezmoi init canonw
```

To update existing configuration, execute this command

``` sh
chezmoi apply
```

## Tools Installed and Configured

| Command | macOS on ARM | Windows | Ubuntu (WSL) |
| ------------- | ------------- | ------------- | ------------- |
| AWS cli | | | |
| bash | | | |
| git | | | |
| zsh | | | |

## Reference

https://github.com/natelandau/dotfiles
https://github.com/shunk031/dotfiles/
https://github.com/renemarc/dotfiles.git

---
More
https://dotfiles.github.io/inspiration/

---
TODO: Delete below

If git repository locates in other path, link it.
```
ln -Ffs <path to dotfiles> ${HOME}/.homesick/repos/dotfiles
```

Map castle
```
homesick symlink dotfiles
```

## Other config
bash file

Add the following to .bash_profile
``` sh
[ -f ~/.kwbash_profile ] && . ~/.kwbash_profile

if [ -f ~/.kwbash_aliases ]; then
  . ~/.kwbash_aliases
fi

if [ -f ~/.kwwork_aliases ]; then
  . ~/.kwwork_aliases
fi
```

espano

Each OS has its own directory setting.  Checkout [https://espanso.org/docs/get-started/](https://espanso.org/docs/get-started/)

- Mac
``` sh
cd home/.config/espanso
ln -s $PWD $HOME/Library/Preferences/espanso
````
-Win
TODO

