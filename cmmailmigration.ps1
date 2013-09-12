$Remote = Get-Credential
$list = Import-csv C:\cmmigration.csv

Foreach	($user in $list)
	{
	New-MoveRequest -Identity $user.SamAccountName -Remote -RemoteCredential $Remote -RemoteGlobalCatalog 'cyrinfdc01p.cmgeneral.local' -RemoteHostName 'cyrprdexch01.cmgeneral.local' -TargetDeliveryDomain 'dealertrack.com' -TargetDatabase $user.Mailbox -ArchiveTargetDatabase $user.Archive -BadItemLimit 50
	}