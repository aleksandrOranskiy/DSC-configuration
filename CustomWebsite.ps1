Configuration CustomWebsite
{
param ($MachineName)
Import-DscResource -ModuleName PSDesiredStateConfiguration    

Node $MachineName
{

File DemoFile
{
DestinationPath = 'C:\CustomWebsite\index.html'
Ensure = 'Present'
Type = 'File'
Contents = "<h2 style='color:$Node.TextColor;'>The page from $($MachineName)</h2>"
Force = $true
}

WindowsFeature IIS
{
Ensure = 'Present'
Name = 'Web-Server'
}

WindowsFeature IISManagement
{
Ensure = 'Present'
Name = 'Web-Mgmt-Tools'
}

WindowsFeature AspNet45
{
Ensure = 'Present'
Name = 'Web-Asp-Net45'
}

File WebContent
{
Ensure = 'Present'
SourcePath = $Node.SourcePath
DestinationPath = $Node.DefaultWebsitePath
DependsOn = "[WindowsFeature]AspNet45"
}

}
}

$ConfigurationData = @{
AllNodes = @(
@{
NodeName = "*"
WebsiteName = "AzureTest"
SourcePath = "C:\CustomWebsite\index.html"
DestinationPath = "C:\inetpub\AzureTest"
DefaultWebsitePath = "C:\inetpub\wwwroot"
},
@{
NodeName = "server1.azuretest.com"
Role = "Web"
TextColor = "green"
},
@{
NodeName = "server2.azuretest.com"
Role = "Web"
TextColor = "red"
}
)
}
