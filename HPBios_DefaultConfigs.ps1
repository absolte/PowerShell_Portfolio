#Variables
$ModelTest = (Get-WmiObject -Class:Win32_ComputerSystem).Model -replace " ", "_"
#$BiosPath = "\\PATH\" + $ModelTest + ".txt"
$DefaultConfigsPath = "\\PATH\" + $ModelTest + "_Default.txt"
$SourceExecutable = "\\PATH\BiosConfigUtility64.exe"
$ExecutableDestination = "C:\Installs\Programs\HPBios"
$Executable = "BiosConfigUtility64.exe"

Function InstallEXE 
{
  param(
    [Parameter(Mandatory=$True)][String]$ExecutableDestination,
    [Parameter(Mandatory=$True)][String]$SourceExecutable,
    [Parameter(Mandatory=$True)][String]$Executable
  )
  #Checking for Executable, Ignoring if it exists.
  If(Test-Path "$ExecutableDestination\$Executable")
  {
    return $True
  }
  #If Executable doesn't exist, checking for the HPBios Directory and Creates it without shell output.
  If (-Not (Test-Path $ExecutableDestination))
  {
    Write-Output "Creating HPBios Directory and Moving Executable"
    New-Item -Path $ExecutableDestination -ItemType Directory -Force | Out-Null
  }

  #Checking that the Executable doesn't exist but that the HPBios Directory does, if true, Copying Executable to it.
  If (-Not(Test-Path "$ExecutableDestination\$Executable") -And (Test-Path $ExecutableDestination)) 
  {
    Copy-Item -Path $SourceExecutable -Destination $ExecutableDestination
  }
  return (Test-Path "$ExecutableDestination\$Executable")
}

Function ConfigureBIOS
{
  param(
    [Parameter(Mandatory=$True)][String]$ExecutableDestination,
    [Parameter(Mandatory=$True)][String]$SourceExecutable,
    [Parameter(Mandatory=$True)][String]$Executable,
    [Parameter(Mandatory=$True)][String]$DefaultConfigsPath
  )
  #Runs the InstallExe Function and Checks for the Config file, If everything required exists, Applys the HP Config. Outputs Error otherwise.
  If ((InstallExe -ExecutableDestination $ExecutableDestination -Executable $Executable -SourceExecutable $SourceExecutable))
  {
    Invoke-Expression "$ExecutableDestination\$Executable /getconfig:$DefaultConfigsPath"
  }
  Else 
  {
    Write-Error "Either $ExecutableDestination\$Executable is Missing"
  }
}

ConfigureBIOS -ExecutableDestination $ExecutableDestination -Executable $Executable -SourceExecutable $SourceExecutable -DefaultConfigsPath $DefaultConfigsPath