Function Test
{
  #At the beginning of script:
  $ScriptStart = Get-Date


  #At the end of script:
  $ScriptEnd = Get-Date
  $TimeTaken = $ScriptEnd - $ScriptStart
  Write-Host "Script completed in $($TimeTaken.Minutes) minutes and $($TimeTaken.Seconds) seconds"
  
}

Test
