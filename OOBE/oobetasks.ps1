# OOBE

$Global:Transcript = "$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-OOBEStuff.log"
Start-Transcript -Path (Join-Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\OSD\" $Global:Transcript) -ErrorAction Ignore

Write-Host "Execute Start-OOBEDeploy" -ForegroundColor Green

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Install-Module OSD -Force -Verbose
Start-OOBEDeploy
Start-Sleep -Seconds 30 -Verbose
Stop-Transcript