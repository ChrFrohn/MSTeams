#The Azure App reg. requries the following permissions:
#
# * Skype for Business administrator role
# 
# Graph API permissions
#
# * User.Read.All
# * Group.ReadWrite.All
# * AppCatalog.ReadWrite.All
# * TeamSettings.ReadWrite.All
# * Channel.Delete.All
# * ChannelSettings.ReadWrite.All
# * ChannelMember.ReadWrite.All
#

$ClientSecret   = ""
$ApplicationID = ""
$TenantID = ""

$graphtokenBody = @{   
   Grant_Type    = "client_credentials"   
   Scope         = "https://graph.microsoft.com/.default"   
   Client_Id     = $ApplicationID   
   Client_Secret = $ClientSecret   
}  

$graphToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantID/oauth2/v2.0/token" -Method POST -Body $graphtokenBody | Select-Object -ExpandProperty Access_Token 

$teamstokenBody = @{   
   Grant_Type    = "client_credentials"   
   Scope         = "48ac35b8-9aa8-4d74-927d-1f4a14a0b239/.default"   
   Client_Id     = $ApplicationID   
   Client_Secret = $ClientSecret 
} 

$teamsToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantID/oauth2/v2.0/token" -Method POST -Body $teamstokenBody | Select-Object -ExpandProperty Access_Token 

Connect-MicrosoftTeams -AccessTokens @("$graphToken", "$teamsToken")