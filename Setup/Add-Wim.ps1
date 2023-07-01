# Set your OSDCloud Template
Set-OSDCloudTemplate -Name 'WinRE'

# Create a new OSDCloud Workspace
$WorkspacePath = "$($env:SystemDrive)\OSDCloud_Test"
New-OSDCloudWorkspace -WorkspacePath "$WorkspacePath"

### Cleanup OSDCloud Workspace Media
# Set the directories to keep
$KeepTheseDirs = @('boot','efi','en-us','sources','fonts','resources')
# Clean the below directories
Get-ChildItem "$($WorkspacePath)\Media" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
Get-ChildItem "$($WorkspacePath)\Media\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force
Get-ChildItem "$($WorkspacePath)\Media\EFI\Microsoft\Boot" | Where {$_.PSIsContainer} | Where {$_.Name -notin $KeepTheseDirs} | Remove-Item -Recurse -Force

# Edit WinPE and rebuild ISO
Edit-OSDCloudWinPE -Wallpaper "C:\_OSDCloud\Wallpaper\511-WindowsPE-DesktopBackground-V2.jpg" -StartURL 'https://raw.githubusercontent.com/EskimoRuler/Powershell-OSDCloud/main/OSDCloud-511.ps1'