#Clears StartMenu for Windows 10

class RemoveStartTiles {

    
    SetLayoutXML(){

        #Creates the layout file and imports it into the system

        #initiates the layout path in Temp folder, the root of the system and the layout XML string
        $LayoutPath = $env:TEMP + "\layout.xml"
        $MountPath = $env:SYSTEMDRIVE +"\"
        $LayoutXML = [xml]@"
    <LayoutModificationTemplate 
    xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" 
    xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1"
    xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" 
    xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
    <LayoutOptions StartTileGroupCellWidth="6" />
    <DefaultLayoutOverride>
        <StartLayoutCollection>
            <defaultlayout:StartLayout GroupCellWidth="6" />
        </StartLayoutCollection>
    </DefaultLayoutOverride>
    <CustomTaskbarLayoutCollection PinListPlacement="Replace">
    <defaultlayout:TaskbarLayout>
        <taskbar:TaskbarPinList>
        <taskbar:DesktopApp DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk" />
        </taskbar:TaskbarPinList>
    </defaultlayout:TaskbarLayout>
    </CustomTaskbarLayoutCollection>
</LayoutModificationTemplate>
"@
        
        #puts layout xml into the temp file
        Write-Host "Putting the Layout in a file"
        $LayoutXML.save($LayoutPath)
        #imports the start layout
        Write-Host "Importing the start layout"
        Import-StartLayout -MountPath $MountPath -LayoutPath $LayoutPath
        #removes the temp file
        Write-Host "Clearing the temp file"
        Remove-Item -path $LayoutPath -Force

    }

    RemoveLayoutXML(){
        
        #Removing of registry keys and default layouts to reset start menu

        #Creates the key path and removes it
        Write-Host "Removing the relevant registry key"
        $KeysPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount"
        Remove-Item -path $KeysPath -Recurse -Force
        
        #Finds the file path and moves it to .old to remove it but keep it backed up
        Write-Host "Removing the user DefaultsLayout.xml and LayoutModifications.xml"
        $DefaultsPath = $env:LOCALAPPDATA+"\Microsoft\Windows\Shell\"
        
        if (Test-Path "$($DefaultsPath)LayoutModification.xml")
        {
            Move-Item -Path "$($DefaultsPath)LayoutModification.xml" -Destination "$($DefaultsPath)LayoutModification.xml.old"
        }
        else 
        {
            Write-Host "$($DefaultsPath)LayoutModification.xml doesn't exist" -BackgroundColor black -ForegroundColor red
        }

        if (Test-Path "$($DefaultsPath)DefaultLayouts.xml")
        {
            Move-Item -Path "$($DefaultsPath)DefaultLayouts.xml" -Destination "$($DefaultsPath)DefaultLayouts.xml.old"
        }
        else 
        {
            Write-Host "$($DefaultsPath)DefaultLayouts.xml doesn't exist" -BackgroundColor black -ForegroundColor red
        }
    
    }
    
}

$rmv = [RemoveStartTiles]::new()


$rmv.SetLayoutXML()

$rmv.RemoveLayoutXML()
