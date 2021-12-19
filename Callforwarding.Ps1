Set-CsUserCallingSettings -Identity UserName@domain.com -IsForwardingEnabled $true -ForwardingType Immediate -ForwardingTarget +4512345678 -ForwardingTargetType SingleTarget

Get-CsUserCallingSettings -Identity UserName@domain.com

New-CsUserCallingDelegate -Identity UserName@domain.com -Delegate CorporateOfficer@domain.com -MakeCalls $true -ManageSettings $true -ReceiveCalls $true

Set-CsUserCallingDelegate -Identity UserName@domain.com -Delegate CorporateOfficer@domain.com -MakeCalls $true

Remove-CsUserCallingDelegate -Identity UserName@domain.com -Delegate CorporateOfficer@domain.com
