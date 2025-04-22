# Path to the CSV file
$csvFilePath = ".\PhoneNumberImportTemplate.csv"

#Auth. using Service Principle with Secret against the SQL DB in Azure
$ClientID = "" # "enter application id that corresponds to the Service Principal" # Do not confuse with its display name
$TenantID = "" # "enter the tenant ID of the Service Principal"
$ClientSecret = "" # "enter the secret associated with the Service Principal"

$RequestToken = Invoke-RestMethod -Method POST `
           -Uri "https://login.microsoftonline.com/$TenantID/oauth2/token"`
           -Body @{ resource="https://database.windows.net/"; grant_type="client_credentials"; client_id=$ClientID; client_secret=$ClientSecret }`
           -ContentType "application/x-www-form-urlencoded"
$AccessToken = $RequestToken.access_token

# SQL Server and database information
$sqlServer = "" 
$database = "" 
$tableName = ""

# Import csv file
$csvData = Import-Csv -Path $csvFilePath

# Generate SQL INSERT statements
$sqlInsertStatements = $csvData | ForEach-Object {
    $pstnNumber = $_.PSTNnumber
    $usedBy = if ($_.UsedBy -eq '') { 'NULL' } else { "'$($_.UsedBy)'" }
    $reservedFor = if ($_.ReservedFor -eq '') { 'NULL' } else { "'$($_.ReservedFor)'" }
    $countryCode = $_.CountryCode

    "INSERT INTO $tableName (PSTNnumber, UsedBy, ReservedFor, CountryCode) VALUES ('$pstnNumber', $usedBy, $reservedFor, '$countryCode');"
}

# Combine all INSERT statements into a single batch
$sqlBatch = $sqlInsertStatements -join " "

# Execute the SQL batch
Invoke-Sqlcmd -ServerInstance $sqlServer -Database $database -Query $sqlBatch -AccessToken $AccessToken
