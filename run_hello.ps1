## Self-elevate the script if required
#if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
#  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
#    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
#    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
#    Exit
#  }
#}

function Test-IsElevated {
    return (New-Object Security.Principal.WindowsPrincipal(
      [Security.Principal.WindowsIdentity]::GetCurrent()))
      .IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# if ((Test-IsElevated) -eq $false) {
#     Write-Warning "This script requires local admin privileges. Elevating..."
#     Start-Process powershell -Verb RunAs -ArgumentList "-NoExit -Command cd '$PWD'"
#     Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit -Command cd '$PWD'; & '$($MyInvocation.MyCommand.Source)' $args"
#     exit
# }

# From https://jdhitsolutions.com/blog/powershell/8526/doing-more-with-myinvocation/
# https://superuser.com/questions/1619630/run-powershell-script-as-a-different-user-and-elevated

Function Get-Foo {
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0, Mandatory)]
        [string]$Name, 
        [datetime]$Since = (Get-Date).TimeofDay
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Processing $Name"

        #create a global copy for testing purposes
        $global:mi = $myinvocation

        Write-Host "Getting $name since $since" -fore yellow
        If (Test-Foo $name) {
            $name
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end
}

Function Test-Foo {
    [cmdletbinding()]
    Param([string]$Name)

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"

    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Testing $name"
        $True
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"

    } #end
}

Get-Foo Jeff -Since 8/1/2021 -Verbose
# Get-Foo Jeff -Since 8/1/2021 -Verbose

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
 {    
  Echo "This script needs to be run As Admin"
  Break
 }