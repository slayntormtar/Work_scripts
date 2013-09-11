<#	Powershell script for linking mailboxes during AD migrations.
	written by brian.phillip@dealertrack.com.
	Please run script in the Exchange Managment Shell. #>


# Import the Active Directory module
Import-Module ActiveDirectory

# Get the admin credentials of the master domain.
$mastercred = Get-Credential

# Import a csv for the users to be migrated. 
$accountinfo = Import-Csv "click_migration.csv"

# main block
foreach ($account in $accountinfo)
    {
	Write-Host "Migrating" $account.username "now."
	Set-User -identity $account.username -LinkedMasterAccount $account.linked -LinkedDomainController planoads001.dt.inc -LinkedCredential $mastercred
	Enable-ADAccount -Identity $account.username
	Set-ADUser -Identity $account.username -PasswordNeverExpires $true
    $usercheckAD = Get-ADUser -identity $account.username -Properties *
	$userchecklinked = Get-user -identity $account.username
	Write-Host "Linked account is now: " $userchecklinked.LinkedMasterAccount
	Write-Host "Is account enabled?" $usercheckAD.enabled
	Write-Host 
	Start-Sleep -s 5
	}