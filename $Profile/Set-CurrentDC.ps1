function Set-ComputerDescription {
  param (
    [Parameter(Mandatory=$True)]
    [string]$Description
  )
  Get-CimInstance -ClassName Win32_OperatingSystem | Set-CimInstance -Property @{description = $Description}
}

Set-ComputerDescription