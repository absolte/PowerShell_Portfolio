function Get-ComputerDescription {
    $Object = (Get-CimInstance -ClassName Win32_OperatingSystem)
    $Object.Description
}

Get-ComputerDescription