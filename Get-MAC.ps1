Function Get-MAC
{
  param (
    [Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
		[String[]]$ComputerName = $env:COMPUTERNAME
  ) 

  Get-WmiObject -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled='True'" -ComputerName $ComputerName | Select-Object -Property MACAddress, Description

}

Get-MAC
