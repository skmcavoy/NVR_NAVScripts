﻿param (
    #Object files from which to update. Should be complete set of objects
    [Parameter(Mandatory=$true,ValueFromPipelinebyPropertyName=$True)]
    [String]$Files,
    #SQL Server address
    [Parameter(Mandatory=$true,ValueFromPipelinebyPropertyName=$True)]
    [String]$Server,
    #SQL Database to update
    [Parameter(Mandatory=$true,ValueFromPipelinebyPropertyName=$True)]
    [String]$Database
)

Import-Module CommonPSFunctions

$ProgressPreference="SilentlyContinue"
. 'c:\Program Files\WindowsPowerShell\Modules\Update-NAVApplicationFromTxt.ps1' -Files $Files -Server $Server -Database $Database -WarningVariable warnings -ErrorVariable errors -OutVariable outputs
$ProgressPreference="Continue"

foreach ($line in $outputs) {
    Write-TfsMessage -message $line
}

foreach ($line in $warnings) {
    Write-TfsWarning -message $line
}

foreach ($line in $errors) {
    Write-TfsError -message $line
}