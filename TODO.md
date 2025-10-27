TODO: 
<!-- Setup vscode setting
    Add vscode extensions -->

Setup github mac
Setup gh mac

Install gopass Windows
Save Configure
Configure home directory

git rebase non-interactive
https://stackoverflow.com/questions/2719579/how-to-add-a-changed-file-to-an-older-not-last-commit-in-git



AWS fix Ubuntu completion

Setup espanso
Register get mac app to start
Ubuntu add dive https://github.com/wagoodman/dive
Checkout dotnet tools https://www.nuget.org/packages?packagetype=dotnettool

Rework dotnet install 
    # TODO: Rework 24.04 install
    # https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?tabs=dotnet9&pivots=os-linux-ubuntu-2404

git-delta ubuntu to use cargo or native?

gpg WSL use windows own gpg
   google search wsl use gnupg
   more configure for WSL https://stackoverflow.com/questions/57619460/trying-to-sign-commits-on-git-using-gpg-on-wsl-but-does-not-work

gopass configure

lsd config fix wsl may not work

neovim configure neovim

---
Review README
tryout https://github.com/Hidetoxin/dotfiles?tab=readme-ov-file


----
Update font

WSL windows size
# Setup WSL
Change size to fit fastfetch
Windows Size
- 120
- 33

-----
Add cleanuop code
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

dotnet tool update --all -g
----

ROLE_NAME="powershell"
mkdir -p roles/$ROLE_NAME/tasks
echo "# code: language=ansible
---" > roles/$ROLE_NAME/tasks/main.yml
---

Ubuntu Install powershell
https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.5

---
LSD tryout theme from thrid part, such as
https://github.com/catppuccin/lsd

---
- Test GPG
- Test chezmoi
---
- GOPASS
- Add gopass
- Add https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e
- Eval SSH https://alexnorell.com/post/set-up-gpg/
---
dotnet add nuget path
https://learn.microsoft.com/en-us/nuget/consume-packages/configuring-nuget-behavior
mac ~/.nuget/NuGe
- user
- system
- local
=>
a b c d e
----
Windows install as admin

===
---
ssh https://superuser.com/questions/1183176/can-i-share-my-ssh-keys-between-wsl-and-windows

---
 Review https://maas.hu/dev/secrets/

---
another one
https://danielmschmidt.de/posts/2024-07-28-dev-env-setup-with-chezmoi/

on gpg
https://superuser.com/questions/594116/clean-up-my-gnupg-keyring

----
Add font
https://github.com/microsoft/cascadia-code
https://community.chocolatey.org/packages?q=Cascadia

Add radmmzerf 
https://www.reddit.com/r/vscode/comments/1gess8f/best_fonts_for_vs_code/

VS Code style multiple fonts
https://razvanpredescu.medium.com/customize-visual-studio-code-for-multiple-fonts-and-styles-96f83562af58

---
# TODO Window Install

# TODO: More choc to Add
# choco install notepadplusplus
# choco install neovim
# choco install obs-studio
# choco install obsidian
# choco install anki
# choco install keepass
# choco install mp3tag
# choco install qfinderpro
# choco install smplayer
# choco install foxitreader
# choco install espanso
# choco install slack
# choco install putty
# choco install googleearthpro

# choco install zoom
# choco install webex

# choco install ollama

# choco install exiftool
# choco install delta
# choco install deno

# choco install ffmpeg
# choco install fzf

# choco install hadolint

# choco install imagemagick
# choco install jq
# choco install yq

# ? choco install navi
# choco install ripgrep

# choco install unxutils

# # choco install youtube-dl # Not active
# choco install yt-dlp

# choco install pasteboard # pbcopy copies the standard input and places it in the specified pasteboard. pbpaste copies the data from the pasteboard and writes it to the standard output.



# TODO: Add Winget
# $GamePackages = @()
# $GamePackages += 'Guru3D.RTSS'
# $GamePackages += 'Guru3D.Afterburner'
# $DesktopPackages += 'Microsoft.BingWallpaper'
# $DesktopPackages += '9NKSQGP7F2NH' # WhatsApp
# $DesktopPackages += 'WhatsApp.WhatsApp' # Ask to use msstore version
# $DesktopPackages += '9WZDNCRFJ3MB'
# $DesktopPackages += 'evernote.evernote' # Always install.  No version check
# $DesktopPackages += '9NCTDW2W1BH8' # Raw Image Extension

----

Add brew install --cask font-victor-mono-nerd-font

---
Update VSCode
{
  "diffEditor.ignoreTrimWhitespace": false,
  "editor.fontFamily": "'VictorMono Nerd Font', 'JetBrainsMono Nerd Font', Menlo, Monaco, 'Courier New', monospace",
  "editor.fontLigatures": true,
  "editor.fontSize": 16,
  "editor.renderWhitespace": "all",
  "editor.minimap.enabled": false,
  // "editor.cursorStyle": "line",
  // "editor.cursorBlinking": "smooth",
  "terminal.integrated.fontFamily": "'Hack Nerd Font', Menlo, Monaco, 'Courier New', monospace",
  "terminal.integrated.fontLigatures.enabled": true,
  "editor.semanticHighlighting.enabled": true,
  "workbench.colorTheme": "Abyss",
  // "workbench.fontAliasing": "antialiased",
  "editor.tokenColorCustomizations": {
    "textMateRules": [
      {
        "scope": "comment",
        "settings": {
          "fontStyle": "italic",
        }
      // },
      // {
      //   "scope": "variable",
      //   "settings": {
      //     "fontStyle": "bold",
      //     // "foreground": "#FF0000" // Example: red color
      //   }
      }
    ]
  }
}

---
Another nice setup
https://github.com/adamchristiansen/dotfiles/tree/main

---
Tempalte 
use this

{{ $foo := "assets.d/bash/common_bash_aliases.sh.tmpl" }}
{{   includeTemplate $foo . }}

----

SSH add to 
https://linux.die.net/man/5/ssh_config


# Host canonw
#   HostName github.com
#   User canonw
#   ForwardAgent ~/.ssh/id_github
#   IdentityFile ~/.ssh/id_github
#   IdentitiesOnly yes

# Host github.com
#   AddKeysToAgent yes
#   UseKeychain yes
#   IdentityFile ~/.ssh/id_github
