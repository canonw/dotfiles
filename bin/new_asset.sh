#!/usr/bin/env bash

pushd .
cd "$(git rev-parse --show-toplevel)" || exit 1

asset_path="./dotfiles/.chezmoitemplates/assets.d/$1"
mkdir -p $asset_path

# Crete header file and content
header_path="$asset_path/header.sh.tmpl"
if [ ! -f "$header_path" ]; then
    echo "{{/* Header script block */ -}}" > $header_path
    echo "{{/* {{ template \"assets.d/$1/header.sh.tmpl\" . }} */ -}}" >> $header_path
    echo "{{ if (or (eq .chezmoi.os \"linux\") (eq .chezmoi.os \"darwin\") (eq .chezmoi.os \"windows\")) -}}" >> $header_path
    ./bin/block_header.sh "$1" >> $header_path
    echo "" >> $header_path
    echo "{{- else -}}" >> $header_path
    echo "{{   fail (printf \"Unsupported OS for the client system: %s\" .chezmoi.os) }}" >> $header_path
    echo "{{ end -}}" >> $header_path

    # Trim trailing whitespace
    sed -i 's/[[:space:]]*$//' $header_path
fi

# Crete .bashrc file and content
dot_bashrc_path="$asset_path/dot_bashrc.sh.tmpl"
if [ ! -f "$dot_bashrc_path" ]; then
    echo "{{/* .bashrc script block */ -}}" > $dot_bashrc_path
    echo "{{/* {{ template \"assets.d/$1/dot_bashrc.sh.tmpl\" . }} */ -}}" >> $dot_bashrc_path
    echo "{{ template \"assets.d/$1/header.sh.tmpl\" . }}" >> $dot_bashrc_path
    cat >> $dot_bashrc_path << EOF
{{ if eq .chezmoi.os "linux" -}}
{{-  if eq .chezmoi.osRelease.id "ubuntu" -}}
# TODO: Update setup ubuntu $1
{{-    if (.chezmoi.kernel.osrelease | lower | contains "microsoft") -}}
# TODO: Update setup wsl $1
{{-    else -}}
# TODO: Update setup non-wsl $1
{{-    end -}}
{{-  else -}}
# TODO: Update setup non-ubuntu $1
{{-  end -}}
{{- else if eq .chezmoi.os "darwin" -}}
# TODO: Update setup darwin $1
{{- else if eq .chezmoi.os "windows" -}}
# TODO: Update setup windows $1
{{- else -}}
{{   fail (printf "Unsupported OS for the client system: %s" .chezmoi.os) }}
{{ end -}}
EOF

    # # Trim trailing whitespace
    # sed -i 's/[[:space:]]*$//' $dot_bashrc_path
fi

# Crete .zshrc file and content
dot_zshrc_path="$asset_path/dot_zshrc.sh.tmpl"
if [ ! -f "$dot_zshrc_path" ]; then
    echo "{{/* .zshrc script block */ -}}" > $dot_zshrc_path
    echo "{{/* {{ template \"assets.d/$1/dot_zshrc.sh.tmpl\" . }} */ -}}" >> $dot_zshrc_path
    echo "{{ template \"assets.d/$1/header.sh.tmpl\" . }}" >> $dot_zshrc_path
    cat >> $dot_zshrc_path << EOF
{{ if eq .chezmoi.os "linux" -}}
{{-  if eq .chezmoi.osRelease.id "ubuntu" -}}
# TODO: Update setup ubuntu $1
{{-    if (.chezmoi.kernel.osrelease | lower | contains "microsoft") -}}
# TODO: Update setup wsl $1
{{-    else -}}
# TODO: Update setup non-wsl $1
{{-    end -}}
{{-  else -}}
# TODO: Update setup non-ubuntu $1
{{-  end -}}
{{- else if eq .chezmoi.os "darwin" -}}
# TODO: Update setup darwin $1
{{- else if eq .chezmoi.os "windows" -}}
# TODO: Update setup windows $1
{{- else -}}
{{   fail (printf "Unsupported OS for the client system: %s" .chezmoi.os) }}
{{ end -}}
EOF

    # # Trim trailing whitespace
    # sed -i 's/[[:space:]]*$//' $dot_zshrc_path
fi

# Crete aliases file and content
aliases_path="$asset_path/aliases.sh.tmpl"
if [ ! -f "$aliases_path" ]; then
    echo "{{/* shell alias script block */ -}}" > $aliases_path
    echo "{{/* {{ template \"assets.d/$1/aliases.sh.tmpl\" . }} */ -}}" >> $aliases_path
    cat >> $aliases_path << EOF
{{ if eq .chezmoi.os "linux" -}}
{{-  if eq .chezmoi.osRelease.id "ubuntu" -}}
# TODO: Update setup ubuntu $1
{{-    if (.chezmoi.kernel.osrelease | lower | contains "microsoft") -}}
# TODO: Update setup wsl $1
{{-    else -}}
# TODO: Update setup non-wsl $1
{{-    end -}}
{{-  else -}}
# TODO: Update setup non-ubuntu $1
{{-  end -}}
{{- else if eq .chezmoi.os "darwin" -}}
# TODO: Update setup darwin $1
{{- else if eq .chezmoi.os "windows" -}}
# TODO: Update setup windows $1
{{- else -}}
{{   fail (printf "Unsupported OS for the client system: %s" .chezmoi.os) }}
{{ end -}}
EOF

    # # Trim trailing whitespace
    # sed -i 's/[[:space:]]*$//' $aliases_path
fi
