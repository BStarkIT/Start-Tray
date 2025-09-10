<#
.SYNOPSIS
This PowerShell script creates a menu for commonly used commands & tools.

.NOTES
Script written by Brian Stark of BStarkIT 

.DESCRIPTION
written by BStark

.LINK
Scripts can be found at:
https://github.com/BStarkIT 
#>
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$MyIcon = [Drawing.Icon]::ExtractAssociatedIcon((Get-Command powershell).Path)
# Create a Primary form
$objForm = New-Object System.Windows.Forms.Form
$objForm.Visible = $false
$objForm.WindowState = "minimized"
$objForm.ShowInTaskbar = $false
$objForm.add_Closing({ $objForm.ShowInTaskBar = $False })
$objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon
$objNotifyIcon.Icon = $MyIcon
$objNotifyIcon.Text = "TrayUtility"
$objNotifyIcon.Visible = $true
$objContextMenu = New-Object System.Windows.Forms.ContextMenu
# Build the context menu
$Menu1 = New-Object System.Windows.Forms.MenuItem
$Menu1.Text = "AD"
$Menu2 = New-Object System.Windows.Forms.MenuItem
$Menu2.Text = "Tools"
$Menu3 = New-Object System.Windows.Forms.MenuItem
$Menu3.Text = "Personal"
$ToggleMenuItem1 = New-Object System.Windows.Forms.MenuItem
$ToggleMenuItem1.Index = 2
$ToggleMenuItem1.Text = ""
$ToggleMenuItem1.add_Click({
    Start-Process "C:\PS\PSModules\netx.jar"
})
$ToggleMenuItem2 = New-Object System.Windows.Forms.MenuItem
$ToggleMenuItem2.Index = 7
$ToggleMenuItem2.Text = "ISE"
$ToggleMenuItem2.add_Click({
    Start-Process "C:\Windows\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe"
})
# Sub Menu 1 - AD
$Menu1Item1 = New-Object System.Windows.Forms.MenuItem
$Menu1Item1.Index = 6
$Menu1Item1.Text = "AD"
$Menu1Item1.add_Click({
    Start-Process dsa.msc -Verb runAs
})
$Menu1Item2 = New-Object System.Windows.Forms.MenuItem
$Menu1Item2.Index = 6
$Menu1Item2.Text = "Add User"
$Menu1Item2.add_Click({
    Start-Process "C:\Program Files\PowerShell\7\pwsh.exe" -ExecutionPolicy Bypass -File \\scotcourts.local\data\CDiScripts\Scripts\NNewUser.ps1 -Verb runAs
})
$Menu1Item3 = New-Object System.Windows.Forms.MenuItem
$Menu1Item3.Index = 6
$Menu1Item3.Text = "Disable User"
$Menu1Item3.add_Click({
    Start-Process "C:\Program Files\PowerShell\7\pwsh.exe" -ExecutionPolicy Bypass -File \\scotcourts.local\data\CDiScripts\Scripts\Disableuser.ps1
})
$Menu1Item4 = New-Object System.Windows.Forms.MenuItem
$Menu1Item4.Index = 6
$Menu1Item4.Text = "Delete Users"
$Menu1Item4.add_Click({
    Start-Process "C:\Program Files\PowerShell\7\pwsh.exe" -ExecutionPolicy Bypass -File \\scotcourts.local\data\CDiScripts\Scripts\Autodelteleavers.ps1 -Verb runAs
})
$Menu1.MenuItems.Add($Menu1Item1) | Out-Null
$Menu1.MenuItems.Add($Menu1Item2) | Out-Null
$Menu1.MenuItems.Add($Menu1Item3) | Out-Null
# Sub Menu 2 - Tools
$Menu2Item1 = New-Object System.Windows.Forms.MenuItem
$Menu2Item1.Index = 1
$Menu2Item1.Text = "RDP"
$Menu2Item1.add_Click({
    Invoke-Expression -Command "C:\Windows\System32\mstsc.exe"
})
$Menu2Item2 = New-Object System.Windows.Forms.MenuItem
$Menu2Item2.Index = 3
$Menu2Item2.Text = "MMC"
$Menu2Item2.add_Click({
    Start-Process MMC.exe -Verb runAs
})
$Menu2Item3 = New-Object System.Windows.Forms.MenuItem
$Menu2Item3.Index = 5
$Menu2Item3.Text = "Remote"
$Menu2Item3.add_Click({
    Start-Process "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\i386\CmRcViewer.exe" -Verb runAs
})
$Menu2Item5 = New-Object System.Windows.Forms.MenuItem
$Menu2Item5.Index = 9
$Menu2Item5.Text = "SCCM"
$Menu2Item5.add_Click({
    Start-Process "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\Microsoft.ConfigurationManagement.exe" -Verb runAs
})
$Menu2.MenuItems.Add($Menu2Item1) | Out-Null
$Menu2.MenuItems.Add($Menu2Item2) | Out-Null
$Menu2.MenuItems.Add($Menu2Item3) | Out-Null
$Menu2.MenuItems.Add($Menu2Item4) | Out-Null
$Menu2.MenuItems.Add($Menu2Item5) | Out-Null

# Sub Menu 3 - Personal
$Menu3Item1 = New-Object System.Windows.Forms.MenuItem
$Menu3Item1.Index = 4
$Menu3Item1.Text = "Palo Alto"
$Menu3Item1.add_Click({
    Start-Process "cmd.exe"  "/c C:\PS\PSModules\BS-Tray\loop.bat"
})
$Menu3Item2 = New-Object System.Windows.Forms.MenuItem
$Menu3Item2.Index = 4
$Menu3Item2.Text = "F15"
$Menu3Item2.add_Click({
    Start-Process "C:\Program Files\PowerShell\7\pwsh.exe" -WindowStyle Minimized -ArgumentList ("-ExecutionPolicy Bypass -noninteractive -noprofile "), "-command C:\PS\PSModules\F15\F15.ps1"
})
$Menu3.MenuItems.Add($Menu3Item1) | Out-Null
$Menu3.MenuItems.Add($Menu3Item2) | Out-Null
# Create an Exit Menu Item
$ExitMenuItem = New-Object System.Windows.Forms.MenuItem
$ExitMenuItem.Index = 10
$ExitMenuItem.Text = "E&xit"
$ExitMenuItem.add_Click({
    $objForm.Close()
    $objNotifyIcon.visible = $false
})
# Add the Menu Items to the Context Menu
$objContextMenu.MenuItems.Add($Menu1) | Out-Null
$objContextMenu.MenuItems.Add($Menu2) | Out-Null
$objContextMenu.MenuItems.Add($Menu3) | Out-Null
$objContextMenu.MenuItems.Add($ToggleMenuItem1) | Out-Null
$objContextMenu.MenuItems.Add($ToggleMenuItem2) | Out-Null
$objContextMenu.MenuItems.Add("-");
$objContextMenu.MenuItems.Add($ExitMenuItem) | Out-Null
#
# Assign the Context Menu
$objNotifyIcon.ContextMenu = $objContextMenu
$objForm.ContextMenu = $objContextMenu

# Show the Form - Keep it open
$objForm.ShowDialog() | Out-Null
$objForm.Dispose()
