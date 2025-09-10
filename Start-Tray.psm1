function Start-Tray {
  <#
 .SYNOPSIS
  This PowerShell module will open a new minimized window & run a script to press F15 key every minute to prevent sleep.

 .NOTES
  Script written by Brian Stark of BStarkIT 

  .DESCRIPTION
  written by BStark

 .LINK
  Scripts can be found at:
  https://github.com/BStarkIT

#>
    Start-Process powershell -WindowStyle Hidden -ArgumentList ("-ExecutionPolicy Bypass -noninteractive -noprofile "), "-command C:\PS\PSModules\BS-Tray\tray.ps1"
}
