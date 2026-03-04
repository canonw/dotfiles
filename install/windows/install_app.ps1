$ErrorActionPreference = "Stop"

$FontPackages = @(
  "nerd-fonts-firacode",
  "nerd-fonts-meslo",
  "cascadiacodepl",
  "nerd-fonts-hack",
  "cascadiacode",
  "cascadiamono",
  "cascadiamonopl"
)

$ChocoPackages = @()

$ChocoPackages += "git"
$ChocoPackages += "delta" # git-delta
$ChocoPackages += "python"
# $ChocoPackages += 'steam' # Steam is a video game digital distribution service and storefront by Valve.
# $ChocoPackages += 'epicgameslauncher' # Epic Games Launcher


$ChocoPackages += 'geosetter.installer'
$ChocoPackages += 'chezmoi'
$ChocoPackages += 'filezilla'
# $ChocoPackages += 'gimp'
$ChocoPackages += 'gpg4win'
$ChocoPackages += 'joplin'
$ChocoPackages += 'sharex'
$ChocoPackages += 'trilium-notes'
$ChocoPackages += 'wireshark' # Wireshark is the world’s foremost and widely-used network protocol analyzer.
# $ChocoPackages += 'itunes'
$ChocoPackages += 'ripgrep' # ripgrep is a line-oriented search tool that recursively searches your current directory for a regex pattern.
$ChocoPackages += 'zoxide' # zoxide is a smarter cd command.

$ChocoPackages += 'awscli'

# $ChocoPackages += '7zip' # 7-Zip is a file archiver with a high compression ratio.
# $ChocoPackages += 'autohotkey' # AutoHotkey is a free, open source macro-creation and automation software utility.

# https://www.reddit.com/r/AutoHotkey/comments/lvzqlx/share_your_most_useful_ahk_scripts_my_huge/
# https://www.autohotkey.com/docs/v1/scripts/
# https://github.com/ahkscript/awesome-AutoHotkey?tab=readme-ov-file

# $ChocoPackages += 'hwinfo' # In-depth Hardware Information and real time monitoring


function Install-ChocoApplications {
  $AllPackages = $($ChocoPackages; $FontPackages)

  foreach ($package in $AllPackages) {
    % {
      $Result = choco list --local-only --limit-output --exact $package | ConvertFrom-Csv -delimiter "|" -Header Id,Version
      if ($Result) {
        Write-Host "'$package' is installed. Version: $($Result.Version)"
      } else {
        Write-Host "'Installing' $package"
        choco install $package -y
      }
    }
  }

  # https://community.chocolatey.org/packages/powershell-core/7.5.4#files
  choco install powershell-core -y --install-arguments="ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 USE_MU=1 ENABLE_MU=1 REGISTER_MANIFEST=1 ENABLE_PSREMOTING=1 DISABLE_TELEMETRY=1"

}

function Set-Configuration-WindowsTerminal {
  $WTSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
  $WTSettings = Get-Content $WTSettingsPath | Out-String | ConvertFrom-Json

  Copy-Item -Path $WTSettingsPath -Destination "$env:USERPROFILE\settings.$(Get-Date -Format 'yyyy-MM-ddTHH_mm_ss').json.bak"

  # Define default profiles
  $WTSettings.profiles.defaults = @{ font = @{face = "Hack Nerd Font"; size = 14 } }

  # Set default profile to PowerShell
  $PowerShellProfile = $WTSettings.profiles.list | Where-Object { $_.name -eq "PowerShell" }
  if ($PowerShellProfile) {
    $WTSettings.defaultProfile = $PowerShellProfile.guid
  }

  $UbuntuProfile = $WTSettings.profiles.list | Where-Object { $_.name -eq "Ubuntu" }
  if ($UbuntuProfile) {
    $UbuntuProfile.font = @{face = "UbuntuMono Nerd Font"; size = 13 }
  }

  # Save the updated settings
  $WTSettings | ConvertTo-Json -Depth 32 | Set-Content $WTSettingsPath
}

$DevPacakges = @()
$DevPacakges += 'Microsoft.DotNet.SDK.8'
$DevPacakges += 'Microsoft.DotNet.SDK.9'
$DevPacakges += 'Microsoft.DotNet.SDK.10'

function Install-Winget-Packages {
  $AllPackages = $($DevPacakges;)

  foreach ($package in $AllPackages)
  {
    Write-Host 'Installing' $package
    % { winget install --accept-source-agreements --accept-package-agreements --id $package --exact }
  }
}

Install-ChocoApplications

# Install-Winget-Packages
# Set-Configuration-WindowsTerminal
