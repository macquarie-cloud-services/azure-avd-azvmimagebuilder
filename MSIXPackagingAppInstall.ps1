# Apps for MSIX Packaging
Write-Host 'AIB Customization: Install apps for MSIX Packaging'
$appName = 'msixapps'
$drive = 'C:\'
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
$LocalPath = $drive + '\' + $appName 
Set-Location $LocalPath

Write-Host 'AIB Customization: Removing AppX Packages ...'
$appxPackage = @(
  "Microsoft.WindowsCamera",
  "Clipchamp.Clipchamp",
  "MSTeams",
  "Microsoft.Todos",
  "Microsoft.Windows.Photos",
  "Microsoft.WindowsSoundRecorder",
  "Microsoft.MicrosoftStickyNotes"
)
Foreach ($item in $appxPackage) {
  Write-Host "Removing AppXPackage $($item) ..."
	Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -like ("*$item*") } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Out-Null
}

# Registry Key to disable Windows Privacy Experience
Write-Host 'AIB Customization: Disabling Windows Privacy Experience ...'
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_DWORD /d 1 /f

# Registry Key to disable prompt for Windows location permissions at startup
Write-Host 'AIB Customization: Disabling Windows Location Access ...'
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessLocation /t REG_DWORD /d 1 /f

# Registry Key to disable prompt for Windows find my device at startup
Write-Host 'AIB Customization: Disabling Windows Find My Device ...'
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FindMyDevice" /v AllowFindMyDevice /t REG_DWORD /d 0 /f

# Registry Key to disable prompt for sending diagnostic data at startup
Write-Host 'AIB Customization: Disabling Windows Sending Diagnostics Data ...'
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f

# Registry Key to disable prompt for improve inking and typing at startup
Write-Host 'AIB Customization: Disabling Windows Improve Inking and Typing ...'
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v AllowLinguisticDataCollection /t REG_DWORD /d 0 /f

# Registry Key to disable tailored experiences with diagnostic data at startup
Write-Host 'AIB Customization: Disabling Windows Tailored Experiences with Diagnostic Data ...'
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f

# Disable UAC
Write-Host 'AIB Customization: Disabling UAC ...'
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

# Disable UAC File Virtualization service (service will error if UAC is disabled)
Set-Service -Name "luafv" -StartupType Disabled

# Disable Windows Search service
Set-Service -Name "WSearch" -StartupType Disabled
