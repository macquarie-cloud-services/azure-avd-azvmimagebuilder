# OS Optimizations for WVD
Write-Host 'AIB Customization: OS Optimizations for WVD'
$appName = 'optimize'
$drive = 'C:\'
New-Item -Path $drive -Name $appName  -ItemType Directory -ErrorAction SilentlyContinue
$LocalPath = $drive + '\' + $appName 
Set-Location $LocalPath
$osOptURL = 'https://github.com/macquarie-cloud-services/azure-wvd-optimization-tool/archive/master.zip'
$osOptURLexe = 'azure-wvd-optimization-tool-master.zip'
$outputPath = $LocalPath + '\' + $osOptURLexe
Invoke-WebRequest -Uri $osOptURL -OutFile $outputPath

Write-Host 'AIB Customization: Starting OS Optimizations script'
Expand-Archive -LiteralPath 'C:\\optimize\\azure-wvd-optimization-tool-master.zip' -DestinationPath $Localpath -Force -Verbose
Set-Location -Path C:\\optimize\\azure-wvd-optimization-tool-master

# Run script
.\Win10_VirtualDesktop_Optimize.ps1 -WindowsVersion 2009 -AcceptEULA -Verbose
Write-Host 'AIB Customization: Finished OS Optimizations script'
