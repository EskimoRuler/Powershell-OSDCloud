Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

#Change Display Resolution for Virtual Machine
if ((Get-MyComputerModel) -match 'Virtual') {
	Write-Host -ForegroundColor Green "Setting Display Resolution to 1600x"
	Set-DisRes 1600
}

#Start OSDCloud ZTI the RIGHT way
Write-Host -ForegroundColor Green "Start OSDCloud"
try {
	Start-OSDCloud -ZTI -OSLanguage es-mx -OSName 'Windows 11 22H2 x64' -OSEdition Enterprise -OSLicense Volume -Restart
}
catch {
	Write-Host "$_"
	Start-Sleep -Seconds 60
}