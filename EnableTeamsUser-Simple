## This is a "One liner" to enable a user to use PSTN with Direct Routing ##
#
# Type in the users email in the varible "$UserEmail" and Type in the users Phone number with contry code in varible "$UserPhoneNr"
# You can add "ext=9999" after the phone number if the user needs and extension phonenumber
#
# ! THIS WILL ONLY WORK WITH A NEWLY CREATED USER IN ON-PREM AD !

$UserEmail = ""
$UserPhoneNr = ""

Set-CsUser -Identity $UserEmail -OnPremLineURI $UserPhoneNr -EnterpriseVoiceEnabled $true -HostedVoiceMail $true -Verbose
