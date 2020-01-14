$TargetConfiguration = "\\PATH\"
$ConfigurationFile = "ultravnc.ini"

Import-Module ActiveDirectory
$Computers = Get-ADComputer -Filter 'Name -like "HOSTN-AME"'


Foreach($Computer in $Computers.Name) {
    $ConfigurationAddress00 = "\\$Computer\C`$\Program Files\uvnc bvba\UltraVNC"
    $ConfigurationAddress01 = "\\$Computer\C`$\Program Files (x86)\uvnc bvba\UltraVNC"
    
    Write-Output "Replacing VNC Configuration on $Computer"
    if(Test-Path "$ConfigurationAddress00\$ConfigurationFile")
    {
        Copy-Item $TargetConfiguration -Destination "$ConfigurationAddress00\$ConfigurationFile" -Force
        Start-Sleep -Seconds 2
        #Invoke-Command -ComputerName $Computer {Restart-Service -Name uvnc_service}
    }
    else 
    {
        if(Test-Path "$ConfigurationAddress01\$ConfigurationFile")
        {
            Copy-Item $TargetConfiguration -Destination "$ConfigurationAddress01\$ConfigurationFile" -Force
            Start-Sleep -Seconds 2
            #Invoke-Command -ComputerName $Computer {Restart-Service -Name uvnc_service}
        }
        else 
        {
            Write-Error "Unable to locate VNC directories on $Computer"    
        }
    }
    Start-Sleep -Seconds 5
    Write-Output "Completed on $Computer"
}