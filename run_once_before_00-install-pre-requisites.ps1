Function Test-IsElevated {
    return (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

Function Install-Chocolatey {

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing $Name"

        If (Test-IsElevated -eq $False) {
            throw "This script requires local admin privileges. Please run as Administrator."
        }

        if(test-path "C:\ProgramData\chocolatey\choco.exe") {
            Write-Output "Chocolatey is already installed"
        } else {
            Write-Output "Installing Chocolatey"
            Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
            Write-Output "Installed Chocolatey"
        }

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}

Install-Chocolatey -Verbose