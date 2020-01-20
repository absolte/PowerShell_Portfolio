Function Get-OEMProductKey
{
  param (
    [Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
		[String[]]$ComputerName = $env:COMPUTERNAME
  )  

  (Get-WmiObject -query 'select * from SoftwareLicensingService' -ComputerName $ComputerName).OA3xOriginalProductKey
}

Get-OEMProductKey