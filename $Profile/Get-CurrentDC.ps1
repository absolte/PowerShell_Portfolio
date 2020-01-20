function Get-CurrentDC {
    $currentDC = $env:LOGONSERVER -replace "\\", ""
    $currentDC
}