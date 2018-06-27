<# 
    .SYNOPSIS
        Provides the necessary authorization token for interacting with
        the VMware Identity Manager REST API.
    .DESCRIPTION
        VMware Identity Manager provides a REST API but requires authentication
        first. This script is provided as an example on how to generate the 
        needed token for use in other methods or functions. 
        
#>

$Credentials = Get-Credential

$body = @{
    username = $Credentials.UserName
    password = $Credentials.GetNetworkCredential().Password
    issueToken = "true"
}

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", 'application/json')
$headers.Add("Content-Type", 'application/json')

# Replace <FQDN> with the FQDN of your vIDM instance
$url = "https://<FQDN>/SAAS/API/1.0/REST/auth/system/login/"

$RESTSession = Invoke-RestMethod -Method POST -Body $Body -Headers $headers

# Format the token properly for use in following methods
$token = "HZN " + $RESTSession.sessionToken
