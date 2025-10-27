Function Write-Output-Done { param ([string]$Message) Write-Output "✅  $Message." }
Function Write-Output-Execute { param ([string]$Message) Write-Output "🏃  $Message..." }
Function Write-Output-Inform { param ([string]$Message) Write-Output "ℹ️  $Message." }
Function Write-Output-Install { param ([string]$Message) Write-Output "🛠️  $Message." }

Function Test-IsElevated {
    return (New-Object Security.Principal.WindowsPrincipal(
      [Security.Principal.WindowsIdentity]::GetCurrent()))
      .IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

Function Install-Chocolatey {
    Write-Output-Execute "Checking Chocolatey"

    # Install Chocolatey https://chocolatey.org/install
    if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
        Write-Output-Done "Chocolatey is already installed"
    } else {
        Write-Output-Install "Installing Chocolatey"
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        # iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

        Write-Output-Done "Installed Chocolatey"
    }
}

Function Install-Scoop {

    # Install scoop https://scoop.sh/
    Write-Output-Execute "Checking scoop"
    if (Get-Command scoop.ps1 -ErrorAction SilentlyContinue) {
        Write-Output-Done "scoop is already installed"
    } else {
        Write-Output-Install "Installing scoop"

        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

        Write-Output-Done "Installed scoop"
    }
}

$ScopeBuckets = @()
$ScopeBuckets += [PSCustomObject]@{ Name = "main" }

# https://github.com/ScoopInstaller/Extras
$ScopeBuckets += [PSCustomObject]@{ Name = "extras" }

# https://github.com/matthewjberger/scoop-nerd-fonts
$ScopeBuckets += [PSCustomObject]@{ Name = "nerd-fonts" }

Function Install-Scope-Buckets {

    $Items = $($ScopeBuckets)
    foreach ($item in $Items)
    {
        $name = $item.Name
        Write-Output-Execute "Checking bucket $name"
        if(scoop bucket list | Select-Object -ExpandProperty Name | Select-String $name)
        {
            Write-Output-Done "scoop has already added bucket $name"
        } else {
            Write-Output-Install "Installing scoop bucket $name."
            scoop bucket add $name
            Write-Output-Done "Installed scoop bucket $name"
        }
    }
}

$ScopePackages = @()
# https://boxes.thomasjensen.com/
$ScopePackages += [PSCustomObject]@{ Name = "boxes"; AppName = "main/boxes" }
# https://github.com/lukesampson/figlet
$ScopePackages += [PSCustomObject]@{ Name = "figlet"; AppName = "main/figlet" }
Function Install-Scope-Packages {

    $Items = $($ScopePackages)
    foreach ($item in $Items)
    {
        $name = $item.Name
        $appName = $item.AppName
        Write-Output-Execute "Checking scoop application $name"
        if(scoop list "$name" | Select-Object -ExpandProperty Name)
        {
            Write-Output-Done "scoop has already installed $name"
        } else {
            Write-Output-Install "Installing scoop application $name."
            scoop install "$appName"
            Write-Output-Done "Installed scoop application $name"
        }
    }
}

Function Main {
    if (-not (Test-IsElevated)) {
        Write-Host "Please run this script as Administrator."
        exit 1
    }

    Install-Chocolatey
    Install-Scoop

    Install-Scope-Buckets
    Install-Scope-Packages
}

# Action
Main