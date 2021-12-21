Set-CsUserCallingSettings -Identity UserName@domain.com -IsForwardingEnabled $true -ForwardingType Immediate -ForwardingTarget +4512345678 -ForwardingTargetType SingleTarget

Get-CsUserCallingSettings -Identity UserName@domain.com

New-CsUserCallingDelegate -Identity UserName@domain.com -Delegate CorporateOfficer@domain.com -MakeCalls $true -ManageSettings $true -ReceiveCalls $true

Set-CsUserCallingDelegate -Identity UserName@domain.com -Delegate CorporateOfficer@domain.com -MakeCalls $true

Remove-CsUserCallingDelegate -Identity UserName@domain.com -Delegate CorporateOfficer@domain.com

Set-CsUserCallingSettings -Identity UserName@domain.com -IsUnansweredEnabled $true -UnansweredTargetType Voicemail -UnansweredDelay 00:00:20

Set-CsUserCallingSettings -Identity UserName@domain.com -IsUnansweredEnabled $false

Set-CsUserCallingSettings -Identity UserName@domain.com -IsForwardingEnabled $true -ForwardingType Immediate -ForwardingTargetType Voicemail
