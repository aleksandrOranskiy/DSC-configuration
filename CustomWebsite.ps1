Configuration CustomWebsite
{
    Import-DscResource -Module xWebAdministration    

    param ($MachineName)

    Node $MachineName
    {
        File DemoFile
        {
            DestinationPath        = 'C:\CustomWebsite\index.html'
	    Ensure                 = 'Present'
	    Type                   = 'File'
	    Contents               = "<h2 style='color:$Node.TextColor;'>The page from $($MachineName)</h2>"
	    Force                  = $true
	}

        WindowsFeature IIS
        {
            Ensure                 = 'Present'
            Name                   = 'Web-Server'
        {

	WindowsFeature IISManagement
	{
	    Ensure                 = 'Present'
	    Name                   = 'Web-Mgmt-Tools'
	}

	WindowsFeature AspNet45
	{
	    Ensure                 = 'Present'
	    Name                   = 'Web-Asp-Net45'
	}

	xWebsite DefaultSite
	{
	    Ensure                 = 'Present'
	    Name                   = 'Default Web Site'
	    State                  = 'Stopped'
	    PhysicalPath           = $Node.DefaultWebSitePath
	    DependsOn              = "[WindowsFeature]IIS"
	}

	File WebContent
	{
	    Ensure                 = 'Present'
	    SourcePath             = $Node.SourcePath
	    DestinationPath        = $Node.DestinationPath
	    Recurse                = $true
            Type                   = "Directory"
	    DependsOn              = "[WindowsFeature]AspNet45"
	}

	xWebsite CustomWebSite
	{
	    Ensure                 = 'Present'
	    Name                   = $Node.WebsiteName
	    State                  = 'Started'
	    PhysicalPath           = $Node.DestinationPath
	    DependsOn              = "[File]WebContent"
	}
    }
}

$ConfigurationData = @{
	AllNodes = @(
	    @{
	        NodeName           = "*"
		WebsiteName        = "AzureTest"
		SourcePath         = "C:\CustomWebsite\"
		DestinationPath    = "C:\inetpub\AzureTest"
		DefaultWebsitePath = "C:\inetpub\wwwroot"
	    },
	    @{
		NodeName           = "server1.azuretest.com"
		Role               = "Web"
		TextColor          = "green"
	    },
	    @{
		NodeName           = "server2.azuretest.com"
		Role               = "Web"
		TextColor          = "red"
	    }
	)
}

Install-Module -Name xWebAdministration
