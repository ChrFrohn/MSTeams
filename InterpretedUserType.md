# InterpretedUserType


### Hybrid* 
- Typical for users that was homed in SFB on-prem, then SFB online and now in Teams 


| InterpretedUserType | Description | Solution / What you should/can do | 
| ------------------- | ----------- | --------------------------------- | 
| HybridOnlineTeamsOnlyUserNeedsProvisioningToAD	| Changes are made and needs to be synced	| You should wait for the AAD sync, and then do at Get-CsOnlineUser to check the UserType again to see if anything needs to be done | 
| HybridOnlineTeamsOnlyUserNeedsPublishingToAAD | Changes are made and needs to be synced | You should wait for the AAD sync, and then do at Get-CsOnlineUser to check the UserType again to see if anything needs to be done | 
| HybridOnlineTeamsOnlyUserNotLicensedForServicePendingAttributeRemovalFromAD | The user don’t have a licens for MS Teams and there might be some old SFB attributes in on-prem AD that’s needs to be cleared	 | First step would be to assign a licens to the user (E3 & E5 fx.) and then wait for licens to check effect, check back on the user a little latter (10 min.'ish) The user status should change to "HybridOnlineTeamsOnlyUser" if not then do a Get-CsOnlineUser and check UserType for a new status - As mentioned you might need to remove old SFB attributes. Look for attributes with msRTCSIP-* |
| HybridOnlineActiveDirectoryDisabledUser	| The user is disable in on-prem AD | Enable the user in on-prem AD and then do a sync to AAD	 |
| HybridOnlineActiveDirectoryDisabledUserPendingAttributeRemovalFromAD | The user is disable in on-prem AD and there is a issue with the old SFB attributes | Assign a licens (E3 & E5 fx), but only if the user has OnPremLineURI and RegistrarPool is set and OnPremLineURIMauallySet to false. Otherwise to might need to enable the user first, then remove all old SFB attributes and let the user get "AADConnectEnabledOnlineTeamsOnlyUser" status and then assign a phone number |
| HybridOnlineTeamsOnlyUser | User comes from SFB online and is in Hybridmode beacause of that | You don’t need to to anything - Only if you wish to change the user to "AADConnectEnabledOnlineTeamsOnlyUser" then you need to clean up the old SFB attributtes in on-prem AAD |
| HybridOnlineTeamsOnlyUserNotLicensedForService | User does not have a vaild licens to use Teams | Assign a licens (E3 & E5 fx), but only if the user has OnPremLineURI and RegistrarPool is set and OnPremLineURIMauallySet to false. Otherwise to might need to enable the user first, then remove all old SFB attributes and let the user get "AADConnectEnabled" status |
| HybridOnpremActiveDirectoryDisabledUser | User is disable in on-prem AD | Enable the user in on-prem AD and then do a sync to AAD |
| HybridOnpremTeamsOnlyUserNotLicensedForService | User is disable in on-prem AD and does not have a licens | Enable the user in on-prem AD and then do a sync to AAD and Assign a licens (E3 & E5 fx) |
| HybridOnpremTeamsOnlyUserWithMCOValidationError | User has an error realted to MCOValidation attribute | "Run Get-CsOnlineUser "Username" | select-object MCOValidationError | Format-List" to determined what is wrong |
