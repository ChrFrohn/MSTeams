#This well set callforwarding to an external phone number (PSTN)
Set-CsUserCallingSettings -Identity UserName@domain.com -IsForwardingEnabled $true -ForwardingType Immediate -ForwardingTarget +4512345678 -ForwardingTargetType SingleTarget

#This will get the current call forwarding settings
Get-CsUserCallingSettings -Identity UserName@domain.com

#This will add user as delegate for another user and be able to make and recivecalls
New-CsUserCallingDelegate -Identity UserName@domain.com -Delegate CorporateOfficer@domain.com -MakeCalls $true -ManageSettings $true -ReceiveCalls $true

#This will change a delegatede persons delegations settings
Set-CsUserCallingDelegate -Identity UserName@domain.com -Delegate CorporateOfficer@domain.com -MakeCalls $true

#This will remove a person as a delegatede person for a user
Remove-CsUserCallingDelegate -Identity UserName@domain.com -Delegate CorporateOfficer@domain.com

#This will change a users call forwarding settings to voice mail after 20 sec.
Set-CsUserCallingSettings -Identity UserName@domain.com -IsUnansweredEnabled $true -UnansweredTargetType Voicemail -UnansweredDelay 00:00:20

#This will set calling forwarding to send all call to the users voice mail
Set-CsUserCallingSettings -Identity UserName@domain.com -IsForwardingEnabled $true -ForwardingType Immediate -ForwardingTargetType Voicemail
