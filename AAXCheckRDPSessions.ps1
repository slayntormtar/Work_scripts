# Enter the hostnames of the production web servers here
$names = @("briantest","hydrogen")

# This will get a list of any currently active RDP sessions on the production web servers
Write-Host "Sessions currently active."
foreach ($name in $names)
    {
    Get-TSSession -ComputerName $name | Where-Object {$_.State -eq "Active"}
    }

# This creates the interactive choice menu
$title = "Log off all users."
$message = "Do you want to log off all remote users to the servers?"
$choices = [System.Management.Automation.Host.ChoiceDescription[]]@("&Yes", "&No")
[int]$defaultChoice = 0
$choiceRTN = $host.ui.PromptForChoice($title,$message, $choices,$defaultChoice)

# Choice to log off users or not
switch($choiceRTN)
    {
    0{Write-Host "This will log everyone off."}
    1{Write-Host "This will NOT log everyone off."}
    }