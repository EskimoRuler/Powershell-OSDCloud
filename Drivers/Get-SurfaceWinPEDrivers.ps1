param
(
	[Parameter(Mandatory = $true)]
	[ValidateSet('SurfacePro9', 'SurfacePro8', 'SurfaceLaptopStudio', 'SurfaceLaptop5', 'SurfaceLaptop4Intel', 'SurfaceLaptop4AMD', 'SurfaceLaptop3Intel')]
	$Device,
	[Parameter(Mandatory = $true)]
	[ValidateScript({
			if (-Not ((Resolve-Path $_) | Test-Path))
			{
				throw "Folder does not exist"
			}
			if (-Not ((Resolve-Path $_) | Test-Path -PathType Container))
			{
				throw "Must specify a Folder location and not a File."
			}
			return $true
		})]
	[System.IO.FileInfo]$SearchPath,
	[Parameter(Mandatory = $true)]
	[ValidateScript({
			if (-Not ((Resolve-Path $_) | Test-Path))
			{
				throw "Folder does not exist"
			}
			if (-Not ((Resolve-Path $_) | Test-Path -PathType Container))
			{
				throw "Must specify a Folder location and not a File."
			}
			return $true
		})]
	[System.IO.FileInfo]$CopyPath,
	[Parameter(Mandatory = $true)]
	[ValidateSet('Win10', 'Win11')]
	$OSName
)

# Driver Folder Names
[System.Collections.ArrayList]$SurfacePro9 = @('adlserial', 'alderlakepchpsystem', 'alderlakesystem', 'gna', 'intelprecisetouch', 'managementengine', 'msump64x64sta', 'surfaceacpiplatformextension', 'surfacebattery', 'surfacedockintegration', 'surfacehidmini', 'surfacehotplug', 'surfaceintegrationdriver', 'surfacesarmanager', 'surfaceserialhubdriver', 'surfaceservicenulldriver', 'surfacetimealarmacpifilter', 'surfaceucmucsihidclient', 'tbtslimhostcontroller')
[System.Collections.ArrayList]$SurfacePro8 = @('intelthcbase', 'ManagementEngine', 'surfaceacpiplatformextension', 'SurfaceBattery', 'SurfaceCoverClick', 'SurfaceEthernetAdapter', 'SurfaceHidMini', 'SurfaceHotPlug', 'surfaceintegrationdriver', 'SurfaceSar', 'SurfaceSerialHub', 'surfacetimealarmacpifilter', 'surfacetypecoverv7fprude', 'SurfaceUcmUcsiHidClient', 'surfacevirtualfunctionenum', 'tbtslimhostcontroller', 'TglChipset', 'TglSerial')
[System.Collections.ArrayList]$SurfaceLaptopStudio = @('heci', 'ialpss2_gpio2_tgl', 'ialpss2_uart2_tgl', 'intelthcbase', 'surfacehidminidriver', 'surfacehotplug', 'surfaceintegrationdriver', 'surfacepenwirelesschargerhotkey', 'surfacesarmanager', 'surfaceserialhubdriver', 'surfacestoragefwupdateenum', 'surfacestoragefwupdatekbg40zns256gpackage', 'surfacewakeontouchcontrol')
[System.Collections.ArrayList]$SurfaceLaptop5 = @('adlserial', 'alderlakepchpsystem', 'gna', 'heci', 'intelprecisetouch', 'msump64x64sta', 'surfaceacpiplatformextensiondriver', 'surfacebattery', 'surfacebutton', 'surfacedockintegration', 'surfacehidminidriver', 'surfacehotplug', 'surfaceintegration', 'surfaceserialhubdriver', 'surfacetimealarmacpifilter', 'tbtslimhostcontroller')
[System.Collections.ArrayList]$SurfaceLaptop4Intel = @('TglSerial', 'IntelPreciseTouch', 'SurfaceEthernetAdapter', 'SurfaceBattery', 'SurfaceHidMini', 'SurfaceHotPlug', 'SurfaceSerialHub', 'SurfaceTconDriver', 'surfacetimealarmacpifilter', 'surfacevirtualfunctionenum', 'TglChipset', 'ManagementEngine')
[System.Collections.ArrayList]$SurfaceLaptop4AMD = @('U0361415', 'AMDfendr', 'AMDGpio2', 'AMDI2c', 'AMDLpcFilterDriverAMDMicroPEP', 'AMDPsp', 'AMDSmf', 'AMDSpi', 'AMDUart', 'SurfaceEthernetAdapter', 'SMBUS', 'SurfaceBattery', 'SurfaceButton', 'SurfaceDigitizerHidSpiExtnPackage', 'SurfaceHIDFriendlyNames', 'SurfaceHidMini', 'SurfaceHotPlug', 'SurfaceOemPanel', 'SurfacePowerMeter', 'SurfacePowerTrackerCore', 'SurfaceSerialHub', 'SurfaceSMFClient', 'SurfaceSmfDisplayClient', 'SurfaceSystemManagementFramework', 'SurfaceTconDriver', 'SurfaceThermalPolicy', 'Surfacetimealarmacpifilter', 'SurfaceUcmUcsiHidClient')
[System.Collections.ArrayList]$SurfaceLaptop3Intel = @('IclSerialIOGPIO', 'IclSerialIOI2C', 'IclSerialIOSPI', 'IclSerialIOUART', 'itouch', 'IclChipset', 'IclChipsetLPSS', 'IclChipsetNorthpeak', 'ManagementEngine', 'SurfaceAcpiNotify', 'SurfaceBattery', 'SurfaceDockIntegration', 'SurfaceHidMini', 'SurfaceHotPlug', 'SurfaceIntegration', 'SurfaceSerialHub', 'SurfaceService', 'SurfaceStorageFwUpdate')

switch ($Device) {
	SurfacePro9 {
		$DeviceFolderSearch = $SurfacePro9
	}
	SurfacePro8 {
		$DeviceFolderSearch = $SurfacePro8
	}
	SurfaceLaptopStudio {
		$DeviceFolderSearch = $SurfaceLaptopStudio
	}
	SurfaceLaptop5 {
		$DeviceFolderSearch = $SurfaceLaptop5
	}
	SurfaceLaptop4Intel {
		$DeviceFolderSearch = $SurfaceLaptop4Intel
	}
	SurfaceLaptop4AMD {
		$DeviceFolderSearch = $SurfaceLaptop4AMD
	}
	SurfaceLaptop3Intel {
		$DeviceFolderSearch = $SurfaceLaptop3Intel
	}
}

# Resolve Search Path
$Path_Search_Resolved = Resolve-Path $SearchPath
# Resolve Copy Path
$Path_Copy_Resolved = Resolve-Path $CopyPath

# Check if Copy Folder Exists
$Path_Copy = "$($Path_Copy_Resolved)\$($Device)\$($OSName)"
Write-Host "   Copy Path: [$($Path_Copy)]"
if ((Test-Path $Path_Copy))
{
	Write-Host "     Copy Path already existis, Deleting" -ForegroundColor Yellow
	try
	{
		Remove-Item -Path $Path_Copy -Recurse
	}
	catch
	{
		Write-Host "$_" -ForegroundColor Red
	}
}

# Get All Folder Names in Search Path
$SearchFolders = Get-ChildItem -Path $Path_Search_Resolved -Directory -Recurse -Depth 1

foreach ($Folder in $DeviceFolderSearch)
{
	Write-Host "SurfaceFolder: [$($Folder)]"
	if ($SearchFolders.Name -match $Folder)
	{
		$Patch_MatchFolder = $SearchFolders | where { $_.Name -eq $Folder }
		Write-Host "   Match Path: [$($Patch_MatchFolder.FullName)]" -ForegroundColor Green
		Write-Host "   Copying Folder"
		
		if (!(Test-Path -Path $Path_Copy))
		{
			#New-Item -Path $Path_Copy_Resolved -Name $Device -ItemType 'Directory'
			New-Item -Path $Path_Copy -Name $Device -ItemType 'Directory' | Out-Null
		}
		Copy-Item -Path $($Patch_MatchFolder.FullName) -Destination "$($Path_Copy)" -Recurse -Force
	}
	else
	{
		Write-Host "   Could Not Find Matching Folder" -ForegroundColor Yellow
	}
}