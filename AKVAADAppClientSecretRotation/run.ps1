param($eventGridEvent, $TriggerMetadata)

function RegenerateCredential($credentialId, $providerAddress, $vaultName, $validityPeriodDays){
    Write-Host "Regenerating client secret for App Id: $providerAddress"
    
    $endDate =(Get-Date).AddDays([int]$validityPeriodDays)
    $passwordCredentials = @{
        StartDateTime = Get-Date
        EndDateTime = $endDate
        DisplayName = "Managed by Key Vault $vaultName"
    }
    $clientSecret = New-AzADAppCredential  -PasswordCredentials $passwordCredentials -ObjectId $providerAddress
    
    return $clientSecret
}

function AddSecretToKeyVault($keyVAultName,$secretName,$secretvalue,$exprityDate,$tags){
    
     Set-AzKeyVaultSecret -VaultName $keyVAultName -Name $secretName -SecretValue $secretvalue -Tag $tags -Expires $expiryDate
}

function RoatateSecret($keyVaultName,$secretName,$secretVersion){
    #Retrieve Secret
    $secret = (Get-AzKeyVaultSecret -VaultName $keyVAultName -Name $secretName)
    Write-Host "Secret Retrieved"
    
    If($secret.Version -ne $secretVersion){
        #if current version is different than one retrived in event
        Write-Host "Secret version is already rotated"
        return 
    }

    #Retrieve Secret Info
    $validityPeriodDays = $secret.Tags["ValidityPeriodDays"]
    $credentialId=  $secret.Tags["CredentialId"]
    $providerAddress = $secret.Tags["ProviderAddress"]
    
    Write-Host "Secret Info Retrieved"
    Write-Host "Validity Period: $validityPeriodDays"
    Write-Host "Credential Id: $credentialId"
    Write-Host "Provider Address: $providerAddress"

    #Regenerate Credential
    $newCredentialValue = (RegenerateCredential "" $providerAddress $keyVAultName $validityPeriodDays)
    Write-Host "Credential regenerated. Credential Id: $($newCredentialValue.KeyId) Resource Id: $providerAddress"

    #Add new credential to Key Vault
    $newSecretVersionTags = @{}
    $newSecretVersionTags.ValidityPeriodDays = $validityPeriodDays
    $newSecretVersionTags.CredentialId = $newCredentialValue.KeyId
    $newSecretVersionTags.ProviderAddress = $providerAddress

    $expiryDate = (Get-Date).AddDays([int]$validityPeriodDays).ToUniversalTime()
    $secretvalue = ConvertTo-SecureString "$($newCredentialValue.SecretText)" -AsPlainText -Force
    AddSecretToKeyVault $keyVAultName $secretName $secretvalue $expiryDate $newSecretVersionTags

    Write-Host "New credential added to Key Vault. Secret Name: $secretName"
}
$ErrorActionPreference = "Stop"
# Make sure to pass hashtables to Out-String so they're logged correctly
$eventGridEvent | ConvertTo-Json | Write-Host

$secretName = $eventGridEvent.subject
$secretVersion = $eventGridEvent.data.Version
$keyVaultName = $eventGridEvent.data.VaultName

Write-Host "Key Vault Name: $keyVAultName"
Write-Host "Secret Name: $secretName"
Write-Host "Secret Version: $secretVersion"

#Rotate secret
Write-Host "Rotation started."
RoatateSecret $keyVAultName $secretName $secretVersion
Write-Host "Secret Rotated Successfully"