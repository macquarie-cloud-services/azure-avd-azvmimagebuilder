# Apps for MSIX Packaging
Write-Host 'AIB Customization: Install apps for MSIX Packaging'
$appName = 'msixapps'
$drive = 'C:\'
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
$LocalPath = $drive + '\' + $appName 
Set-Location $LocalPath
Write-Host 'AIB Customization: Downloading MSIX Packaging Tool ...'
Invoke-WebRequest -Uri "https://download.microsoft.com/download/e/2/e/e2e923b2-7a3a-4730-969d-ab37001fbb5e/MSIXPackagingtoolv1.2024.405.0.msixbundle" -OutFile "MSIXPackagingTool.msixbundle"
Invoke-WebRequest -Uri "https://download.microsoft.com/download/e/2/e/e2e923b2-7a3a-4730-969d-ab37001fbb5e/MSIXPackagingtoolv1.2024.405.0.License.xml" -Outfile "License.xml"
Write-Host 'AIB Customization: Installing MSIX Packaging Tool ...'
Start-Process powershell -ArgumentList "Add-AppxPackage -Path .\MSIXPackagingTool.msixbundle" -Verb RunAs -Wait
#Write-Host '>>> Downloading MSIXHero ...'
#Invoke-WebRequest -Uri "https://msixhero.net/msix-hero-3.1.0.0.msix" -Outfile "msix-hero.msix"
#Write-Host '>>> Installing MSIXHero ...'
#Start-Process powershell -ArgumentList "Add-AppxPackage -Path .\msix-hero.msix" -Verb RunAs -Wait
Write-Host '>>> MSIX Packaging Apps installed ...'
