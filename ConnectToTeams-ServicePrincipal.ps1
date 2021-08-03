# Connect to Teams using Service principal (App reg)
# This should be used in automation jobs related to Microsoft Teams administration
# Remember to add API permissions to the Service Principal

$AppID = ""
$TenantID = ""
$ClientSecret = ""
$CompanyName = ""

$TokenRequest = Invoke-RestMethod -Method POST `
           -Uri "https://login.microsoftonline.com/$TenantID/oauth2/token"`
           -Body @{ resource="https://database.windows.net/"; grant_type="client_credentials"; client_id=$AppID; client_secret=$ClientSecret }`
           -ContentType "application/x-www-form-urlencoded"
$AccessToken = $TokenRequest.access_token

Connect-MicrosoftTeams -TenantId $TenantID -AadAccessToken $AccessToken -AccountId $CompanyName
