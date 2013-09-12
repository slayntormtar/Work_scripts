
$list = Import-csv C:\cmmigration.csv

Foreach	($user in $list)
	{
	Enable-Mailbox -Identity $user.SamAccountName -Archive -ArchiveDatabase $user.Archive
	Set-Mailbox -Identity $user.SamAccountName -RetentionPolicy '2c67ab85-0165-4b90-9d91-26dd901844c0'
	Add-ADGroupMember "DAL Email Delivery" -Members (Get-ADUser $user.SamAccountName)
	}