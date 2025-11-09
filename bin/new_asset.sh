#!/usr/bin/env bash

pushd .
cd "$(git rev-parse --show-toplevel)" || exit 1

asset_path="./dotfiles/.chezmoitemplates/assets.d/_shell"
mkdir -p $asset_path

# General purpose templates
read -r -d '' HEADER_VAR << EOF
{{/* FOO header script block */ -}}
{{/* {{ template "assets.d/_shell/FOO_header.sh.tmpl" . }} */ -}}
{{- if (or (eq .chezmoi.os "linux")
        (eq .chezmoi.os "darwin")
        (eq .chezmoi.os "windows")) -}}
EOF

read -r -d '' FOOTER_VAR << EOF
{{- else -}}
{{    fail (printf "Unsupported OS for the client system: %s" .chezmoi.os) }}
{{- end -}}
EOF

# Crete header file and content
header_path="$asset_path/$1_header.sh.tmpl"
if [ ! -f "$header_path" ]; then
    echo "$HEADER_VAR" > $header_path
    ./bin/block_header.sh "$1" >> $header_path
    echo "" >> $header_path
    echo "$FOOTER_VAR" >> $header_path
    sed -i "s/FOO/$1/" $header_path

    # # Trim trailing whitespace
    # sed -i 's/[[:space:]]*$//' $header_path
fi

# Crete shell file and content
# General purpose templates
read -r -d '' FILE_VAR << EOF
{{/* FOO .bashrc and .zhrc script block */ -}}
{{/* {{ template "assets.d/_shell/FOO_shell.sh.tmpl" . }} */ -}}
{{ template "assets.d/_shell/FOO_header.sh.tmpl" . }}

{{- if (or (and (eq .chezmoi.os "linux") (.is_ubuntu_wsl))
        (eq .chezmoi.os "darwin")
        (eq .chezmoi.os "windows")) }}

# TODO Update FOO shell

{{ template "assets.d/_shell/FOO_aliases.sh.tmpl" .}}

{{- else -}}
{{    fail (printf "Unsupported OS for the client system: %s" .chezmoi.os) }}
{{  end -}}
EOF

shell_path="$asset_path/$1_shell.sh.tmpl"
if [ ! -f "$shell_path" ]; then
    echo "$FILE_VAR" > $shell_path
    sed -i "s/FOO/$1/" $shell_path
fi


# Crete aliases file and content
# General purpose templates
read -r -d '' FILE_VAR << EOF
{{/* FOO shell alias script block */ -}}
{{/* {{ template "assets.d/_shell/FOO_aliases.sh.tmpl" . }} */ -}}

{{- if (or (and (eq .chezmoi.os "linux") (.is_ubuntu_wsl))
  (eq .chezmoi.os "darwin")
  (eq .chezmoi.os "windows")) }}

# TODO Update FOO aliases

{{- else -}}
{{    fail (printf "Unsupported OS for the client system: %s" .chezmoi.os) }}
{{  end -}}
EOF

aliases_path="$asset_path/$1_aliases.sh.tmpl"
if [ ! -f "$aliases_path" ]; then
    echo "$FILE_VAR" > $aliases_path
    sed -i "s/FOO/$1/" $aliases_path
fi
