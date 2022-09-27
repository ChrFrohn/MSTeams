#This is to be used if you want to create an Auto Attendant (AA)combined with Direct Routing numbers (On-prem phone numbers)

#Auth to Teams and M365
Connect-MicrosoftTeams
Connect-MsolService

$DisplayNameForAA = "" #What you want to be displayed to user
$Alias = $DisplayNameForAA.ToLower().Replace(" ","") #Alias on the user (lower case without spaces)
$Domain = "" #Your domain name (fx. contso)
$PhoneNumber = "" #The phone number to be used
$YourLicens = "" #You can use "Get-MsolAccontSku to get the name of the licens - It could look like this: "Contoso:PHONESYSTEM_VIRTUALUSER"
$YourUsageLocation = "" #This is the usage location of the AA (f.eks. US or DK)

# The displayname + domain + .onmicrosoft.com - The user can only exsist in the cloud.
$Combined = "$Alias@$domain.onmicrosoft.com"

#Create the account to be used with AUTO ATTENDANT 
New-CsOnlineApplicationInstance -UserPrincipalName $Combined -DisplayName $DisplayNameForAA -ApplicationId “ce933385-9390-45d1-9512-c8d228074e07” -Verbos

#Assign phone number and licens
# 
#How to buy: https://docs.microsoft.com/en-us/microsoftteams/teams-add-on-licensing/virtual-user#how-to-buy-microsoft-365-phone-system--virtual-user-licenses

Set-MsolUser -UserPrincipalName $Combined -UsageLocation $YourUsageLocation -Verbose
Set-MsolUserLicense -UserPrincipalName $Combined -AddLicenses $YourLicens -Verbose

#Waiting to let MS find out that the user has a licens - aprox. 5 min.
Write-Host -ForegroundColor Cyan "Waiting a cloud minut to let MS sync the licens"
Start-Sleep 300

#Assign the phone number
Set-CsPhoneNumberAssignment -Identity $Combined -PhoneNumber $PhoneNumber -PhoneNumberType "DirectRouting"

#Show finale
Get-CsOnlineApplicationInstance -Identity $Combined
