Function Get-LastBoot
{
  param (
    [Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
		[String[]]$ComputerName = $env:COMPUTERNAME
  ) 
  Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName | Select-Object -Property CSName,@{n="Last Booted";e={[Management.ManagementDateTimeConverter]::ToDateTime($_.LastBootUpTime)}}
}
