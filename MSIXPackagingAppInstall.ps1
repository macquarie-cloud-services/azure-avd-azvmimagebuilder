# Apps for MSIX Packaging
Write-Host 'AIB Customization: Install apps for MSIX Packaging'
$appName = 'msixapps'
$drive = 'C:\'
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
$LocalPath = $drive + '\' + $appName 
Set-Location $LocalPath
Write-Host 'AIB Customization: Downloading MSIX Packaging Tool ...'
Invoke-WebRequest -Uri "https://download.microsoft.com/download/e/2/e/e2e923b2-7a3a-4730-969d-ab37001fbb5e/MSIXPackagingtoolv1.2024.405.0.msixbundle" -OutFile "MSIXPackagingTool.msixbundle"
Write-Host 'AIB Customization: Installing MSIX Packaging Tool ...'
Add-AppxProvisionedPackage -Online -PackagePath 'MSIXPackagingTool.msixbundle' -SkipLicense
Write-Host 'AIB Customization: Installing DotNET Desktop Runtime 8 (Prerequisite for MSIXHero) ...'
winget install "Microsoft.DotNet.DesktopRuntime.8" --accept-source-agreements --accept-package-agreements --disable-interactivity
Write-Host 'AIB Customization: Downloading MSIXHero ...'
Invoke-WebRequest -Uri "https://msixhero.net/msix-hero-3.1.0.0.msix" -Outfile "msix-hero.msix"
Write-Host 'AIB Customization: Installing MSIXHero ...'
Add-AppxProvisionedPackage -Online -PackagePath 'msix-hero.msix' -SkipLicense
Write-Host 'AIB Customization: MSIX Packaging Apps installed ...'

# Registry Key to disable Windows Privacy Experience
Write-Host 'AIB Customization: Disabling Windows Privacy Experience ...'
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_DWORD /d 1 /f
