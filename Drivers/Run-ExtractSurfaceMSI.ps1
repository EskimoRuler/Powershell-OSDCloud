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
	[System.IO.FileInfo]$Path
)

# Resolve Path
$Path_Resolved = Resolve-Path $Path

# Get all files in directory that are MSI's
Write-Host "Getting all [*.msi] Files in Directory: [$($Path_Resolved)]"
$Files_MSI = Get-ChildItem -Path $Path_Resolved -Filter *.msi -ErrorAction Stop

# Check if any files were found
if ($Files_MSI)
{
	# Loop through files
	foreach ($File in $Files_MSI)
	{
		Write-Host "######## File: [$($File.Name)]"
		try
		{
			# Check if Extraction Folder Exists
			$Path_Extraction = "$($Path_Resolved)\$($File.BaseName)"
			Write-Host "   Extraction Path: [$($Path_Extraction)]"
			if ((Test-Path $Path_Extraction))
			{
				Write-Host "     Extraction Path already existis, deleting" -ForegroundColor Yellow
				try
				{
					Remove-Item -Path $Path_Extraction -Recurse -Force
				}
				catch
				{
					Write-Host "$_" -ForegroundColor Red
				}
			}
			
			# Extract MSI
			Write-Host "   Extracting file: [$($File.Name)]"
			Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList "/a $($File.FullName) targetdir=`"$($Path_Extraction)`" /qn" -ErrorAction Stop
			Write-Host "     Successfully Extracted" -ForegroundColor Green
		}
		catch
		{
			Write-Host "$_"
		}
	}
}
else
{
	throw "ERROR: No MSI files Found"
}