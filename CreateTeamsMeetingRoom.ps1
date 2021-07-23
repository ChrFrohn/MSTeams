#Modules to be used
Connect-ExchangeOnline
Connect-MicrosoftTeams
Connect-MsolService

# References
# https://docs.microsoft.com/en-us/powershell/module/exchange/mailboxes/set-calendarprocessing?view=exchange-ps
# https://docs.microsoft.com/en-us/microsoftteams/rooms/with-office-365


#Used in Teams
$PhoneNumber = "" #The number to be used in the conference room (remember country code fx. +45)
$TeamsIpPhonePolicy = "" #The policy to be used in the conference room (Get-CsTeamsIPPhonePolicy)


#Used in Exchange / Msol
$RoomMail = "" #RoomName@yourdomain.it
$RoomName = "" #The rooms name
$RoomPassword = "The password for the room mailbox"
$TeamsRoomLicense = "YourCOMPANY:MEETING_ROOM" #If in doubt, run Get-MsolAccountSku and look for "MEETING_ROOM"
$UsageLocation = "" #US or DK fx.

##########################################################################################################################################################################################################
#Createting the room mailbox
New-Mailbox -MicrosoftOnlineServicesID $RoomMail -Name $RoomName -Room -RoomMailboxPassword (ConvertTo-SecureString -String $RoomPassword  -AsPlainText -Force) -EnableRoomMailboxAccount $true -Verbose

#Set password to never expire and setting the usage location of the room mailbox
Set-MsolUser -UserPrincipalName $RoomMail -PasswordNeverExpires $true -UsageLocation $UsageLocation -Verbose

#Add license to the room mailbox to use Team features
Set-MsolUserLicense -UserPrincipalName $RoomMail -AddLicenses $TeamsRoomLicense -Verbose


##########################################################################################################################################################################################################
#Change settings on the newly created room mailbox

#Set booking Windows to 365 days
Set-CalendarProcessing -Identity $RoomMail -BookingWindowInDays 365 -Verbose

#Allow external
Set-CalendarProcessing -Identity $RoomMail -ProcessExternalMeetingMessages $true -Verbose

#Theese are 'default' settings
Set-CalendarProcessing -Identity $RoomMail -AutomateProcessing AutoAccept -DeleteComments $false -AddOrganizerToSubject $true -AllowConflicts $false -DeleteSubject $true -RemovePrivateProperty $false -Verbose

#Permissions sæt to allow users to view bookings
Set-MailboxFolderPermission -Identity $RoomMail -User default -AccessRights PublishingAuthor -Verbose

##########################################################################################################################################################################################################

#Need to wait for the cloud to find the new room mailbox
Start-Sleep 5000

##########################################################################################################################################################################################################
#
#Teams configuration

#Enable the room mailbox to function as a teams device
Enable-CsMeetingRoom -Identity $RoomMail -SipAddressType “EmailAddress” -RegistrarPool “sippoolAM30E26.infra.lync.com“ -Verbose 

#Enable EnterpriseVoice
Set-CsMeetingRoom -Identity $RoomMail -EnterpriseVoiceEnabled $true -Verbose 

#Enable VoiceMail
Set-CsMeetingRoom -Identity $RoomMail -HostedVoiceMail $true -Verbose 

#Set phone number
Set-CsMeetingRoom -Identity $RoomMail -LineURI "tel:$PhoneNumber" -Verbose

#Set the Teams device policy 
Grant-CsTeamsIPPhonePolicy -Identity $RoomMail -PolicyName $TeamsIpPhonePolicy -Verbose

