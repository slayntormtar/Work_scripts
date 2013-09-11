$dbs = Get-MailboxDatabase -status | where-object {$_.Mounted -eq $true}
$data = @()

foreach($db in $dbs)
	{
	$mailboxcount = (Get-Mailbox -database $db.name -resultsize unlimited).Count
	$freespace = $db.AvailableNewMailboxSpace.ToMB()
	$databasesize = $db.DatabaseSize.toMB()
	$databasename = $db.Name
	$data += New-Object PsObject -prop @{
		"Free Space in MB" = $freespace
		"Database Size in MB" = $databasesize
		"Number of Mailboxes" = $mailboxcount
		"Name" = $databasename
		}
	}

$data | Select-Object Name,"Number of Mailboxes","Database Size in MB","Free Space in MB" | Format-Table -auto