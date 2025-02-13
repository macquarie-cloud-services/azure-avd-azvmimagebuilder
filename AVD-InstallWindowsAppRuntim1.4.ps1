#Install the WindowsAppRuntime1.4. A Prerequisite for running AppAttach packages created using the MSIX Packaging Tool.
$installerUrl = "https://aka.ms/windowsappsdk/1.4/1.4.240802001/windowsappruntimeinstall-x64.exe"
$outputPath = "$env:TEMP\windowsappruntimeinstall-x64.exe"

# Download the installer
Invoke-WebRequest -Uri $installerUrl -OutFile $outputPath

# Silently install for all users
Start-Process -FilePath $outputPath -Wait

# Clean up
Remove-Item -Path $outputPath