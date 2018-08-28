Install-Module -Name AzureRM -Force
$Trigger = New-ScheduledTaskTrigger -At 06:00am –Daily
$User= "NT AUTHORITY\SYSTEM"
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\inetpub\wwwroot\backup.ps1"
Register-ScheduledTask -TaskName "Web backup" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force
