Write-Host -ForegroundColor Green "Starting 5.11 OSDPad"
Start-Sleep -Seconds 5

#Change Display Resolution for Virtual Machine
if ((Get-MyComputerModel) -match 'Virtual') {
	Write-Host -ForegroundColor Green "Setting Display Resolution to 1600x"
	Set-DisRes 1600
}

#Make sure I have the latest OSD Content
Write-Host -ForegroundColor Green "Updating OSD PowerShell Module"
Install-Module OSD -Force

Write-Host -ForegroundColor Green "Importing OSD PowerShell Module"
Import-Module OSD -Force

#Start OSDCloud ZTI the RIGHT way
Write-Host -ForegroundColor Green "Start OSDCloud"
try {
	#Start-OSDCloud -ZTI -OSLanguage en-us -OSName 'Windows 11 22H2 x64' -OSEdition Enterprise -OSLicense Volume -Restart
	Start-OSDPad -RepoOwner EskimoRuler -RepoName Powershell-OSDCloud -RepoFolder WebScripts
}
catch {
	Write-Host "$_"
	Start-Sleep -Seconds 60
}