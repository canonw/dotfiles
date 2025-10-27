# Check if the "Microsoft-Windows-Subsystem-Linux" feature is enabled
$wslFeature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

if ($wslFeature.State -ne "Enabled") {
    Write-Host "Windows Subsystem for Linux feature is not enabled. Enabling it now..."
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All
    Write-Host "Windows Subsystem for Linux feature enabled. A restart may be required for changes to take effect."
} else {
    Write-Host "Windows Subsystem for Linux feature is already enabled."
}

# Check if the "VirtualMachinePlatform" feature is enabled (required for WSL2)
$vmPlatformFeature = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform

if ($vmPlatformFeature.State -ne "Enabled") {
    Write-Host "Virtual Machine Platform feature is not enabled. Enabling it now..."
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All
    Write-Host "Virtual Machine Platform feature enabled. A restart may be required for changes to take effect."
} else {
    Write-Host "Virtual Machine Platform feature is already enabled."
}
