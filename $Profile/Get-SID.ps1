Function Get-SID
{
  param (
    [Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
		[String[]]$ComputerName = $env:COMPUTERNAME
  ) 

  foreach($ComputerName2 in $ComputerName)
  {
    Get-ADComputer -Filter {Name -eq $ComputerName2} -Properties sid | Select-Object name, sid
  }
}

Get-SID