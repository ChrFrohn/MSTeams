Connect-MicrosoftTeams
#You might need to connect to your SFB on-prem env. in order to correct users if they cannot be moved


$UserName = "" #SamaccountName
$TeamsRoutingPolicy = "" #Teams DIRECT ROUTING policy



$User = Get-ADUser $UserName | Select sAMAccountName
$SFBUser = Get-CsOnlineUser $User.sAMAccountName
   

    if ($SFBUser.EnterpriseVoiceEnabled -eq $True)
    {
        Write-Host -ForegroundColor Green "Moving user" $User.sAMAccountName
        #Make a user “Teams Only”
        Grant-CsTeamsUpgradePolicy -Identity $SFBUser.WindowsEmailAddress -PolicyName UpgradeToTeams -Verbose -WhatIf

        #Grant Direct Voice Routing Policy
        Grant-CsOnlineVoiceRoutingPolicy -Identity $SFBUser.WindowsEmailAddress -PolicyName $TeamsRoutingPolicy -Verbose -WhatIf

    }
    else
    {
        Write-Host -ForegroundColor Cyan $User.sAMAccountName "is not ready for Teams migration... Trying to fix, hang on - Trying to use SFB on-prem Powershell"

        Write-Host -ForegroundColor Magenta "Setting EnterpriseVoiceEnabled & HostedVoiceMail attributtes.."
        #Enable EnterpriseVoice and HostedVoice mail

        Try
        {
            Set-CsUser -Identity $SFBUser.WindowsEmailAddress -EnterpriseVoiceEnabled $true -HostedVoiceMail $true -Verbose -WhatIf
            Set-CsUser -Identity $SFBUser.WindowsEmailAddress -HostedVoiceMail $true -Verbose -WhatIf
            
            Start-Sleep 20
            
            Write-Host -ForegroundColor Yellow "Trying to move user again" $User.sAMAccountName
            #Make a user “Teams Only”
            Grant-CsTeamsUpgradePolicy -Identity $SFBUser.WindowsEmailAddress -PolicyName UpgradeToTeams -Verbose -WhatIf

            #Grant Direct Voice Routing Policy
            Grant-CsOnlineVoiceRoutingPolicy -Identity $SFBUser.WindowsEmailAddress -PolicyName $TeamsRoutingPolicy -Verbose -WhatIf
        }
        Catch
        {
            Write-Host -ForegroundColor Red "Error setting EnterpriseVoceEnabled and HosteVoiceMail for" $User.SamAccountName 
            Write-Host -ForegroundColor Red "Check for licensing isseus or user attributes in AD"

        }   
    

    }
