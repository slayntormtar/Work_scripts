$items = Get-ChildItem C:\bclogs
foreach ($item in $items)
    {
    $age = ((Get-Date) - $item.CreationTime).Days
    if ($age -gt 365 -and $item.IsContainter -ne $true)
        {$item.Delete()}
    }