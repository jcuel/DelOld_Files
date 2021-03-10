$limit = (Get-Date).AddDays(-15)
$path = "C:\WindowsAzure\Resources"
$today = Get-Date
$logPath = "C:\WindowsAzure"
$logFile = "Resources_Clean.log"

#Obtain files older than the $limit
$Files = Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit }

#Delete Files older than limit

$files | Remove-Item -Force

#Obtain empty folders left behind after deleting the old files.

$folders = Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force)} | Where-Object {(!$_.PSIsContainer) -eq $null}

#Remove Empty Folders left behind after deleting old files

$folders | Remove-Item -Force -Recurse

#Write Log of actions taken

$LogL1 = "The Cleanup Script was run on $today, and removed older files than $limit."
$LogL2 = "The Removed Files Where"
$LogL3 = "The Removed Folders Where"
$LogL4 = "-------------------------"

$LogL1 >> $logPath\$logFile
$LogL2 >> $logPath\$logFile
$files >> $logPath\$logFile
$LogL3 >> $logPath\$logFile
$folders >> $logPath\$logFile
$LogL4 >> $logPath\$logFile

#End Of Script
