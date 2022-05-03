
$tenantid = ""
$clientid = ""
$clientsecret = ""
$username = ""
$password = ""

$uri = "https://login.microsoftonline.com/{0}/oauth2/v2.0/token" -f $tenantid
$body = "client_id={0}&scope=https://graph.microsoft.com/.default&username={1}&password={2}&grant_type=password&client_secret={3}" -f $clientid, $username, [System.Net.WebUtility]::UrlEncode($password), [System.Net.WebUtility]::UrlEncode($clientsecret)
$graphtoken = Invoke-RestMethod $uri -Body $body -Method Post -ContentType "application/x-www-form-urlencoded" -ErrorAction SilentlyContinue | Select-object -ExpandProperty access_token

$uri = "https://login.microsoftonline.com/{0}/oauth2/v2.0/token" -f $tenantid
$body = "client_id={0}&scope=48ac35b8-9aa8-4d74-927d-1f4a14a0b239/.default&username={1}&password={2}&grant_type=password&client_secret={3}" -f $clientid, $username, [System.Net.WebUtility]::UrlEncode($password), [System.Net.WebUtility]::UrlEncode($clientsecret)
$teamstoken = Invoke-RestMethod $uri -Body $body -Method Post -ContentType "application/x-www-form-urlencoded" -ErrorAction SilentlyContinue | Select-object -ExpandProperty access_token

Connect-MicrosoftTeams -AccessTokens @($graphtoken, $teamstoken) -Verbose
