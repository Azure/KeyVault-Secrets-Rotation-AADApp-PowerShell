# ###THIS IS TEMPLATE PROJECT FOR SECRET ROTATION FUNCTIONS. FOLLOW [THIS](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell/blob/main/Project-Template-Instructions.md) STEPS TO CREATE NEW SECRETS ROTATION FUNCTION PROJECT REPOSITORY###.

# KeyVault-Secrets-Rotation-AADApp-PowerShell

Functions regenerate individual key (alternating between two keys) in AAD App client secret and add regenerated client secret to Key Vault as new version of the same secret.

## Features

This project framework provides the following features:

* Rotation function for AAD App client secret triggered by Event Grid (AKVAADAppClientSecretRotation)

* Rotation function for AAD App client secret key triggered by HTTP call (AKVAADAppClientSecretRotationHttp)

* ARM template for function deployment with secret deployment (optional)

* ARM template for adding AAD App client secret to existing function with secret deployment (optional)

## Overview

Functions using following information stored in secret as tags:

* $secret.Tags["ValidityPeriodDays"] - number of days, it defines expiration date for new secret
* $secret.Tags["CredentialId"] - AAD App Client Secret credential id
* $secret.Tags["ProviderAddress"] - AAD App App Resource Id

You can deploy vault secret with above tags and AAD App client secret as value or add those tags to existing secret with Indentity Platform client secret value. For automated rotation expiry date will also be required - key vault triggers 'SecretNearExpiry' event 30 days before expiry.
[ServiceType]
There are two available functions performing same rotation:

* AKVAADAppClientSecretRotation - event triggered function, performs AAD App client secret rotation triggered by Key Vault events. In this setup Near Expiry event is used which is published 30 days before expiration
* AKVAADAppClientSecretRotationHttp - on-demand function with KeyVaultName and Secret name as parameters

Functions are using Function App identity to access Key Vault and existing secret "CredentialId" tag with AAD App client secret name and "ProviderAddress" with AAD App app Resource Id.

### Installation

1. Install function with template for AAD App client secret
1. Add permissions using Graph API to Azure Function to generate client secrets in AAD App

ARM templates available:

* [Secrets rotation Azure Function and configuration deployment template](https://github.com/Azure/KeyVault-Secrets-Rotation-AADApp-PowerShell/blob/main/ARM-Templates/Readme.md) - it creates and deploys function app and function code, creates necessary permissions, Key Vault event subscription for Near Expiry Event for individual secret (secret name can be provided as parameter)
* [Add event subscription to existing Azure Function deployment template](https://github.com/Azure/KeyVault-Secrets-Rotation-AADApp-PowerShell/blob/main/ARM-Templates/Readme.md) - function can be used for multiple services for rotation. This template creates new event subscription for secret and necessary permissions to existing function

Steps to add Graph API permissions to Azure Function:

> [!IMPORTANT]
> To provide Graph API Permission you need to be Global Administrator in Azure Active Directory

```powershell
$TenantID = '7010fa05-d961-4e3e-b8d7-8f37bf5ecfe0'
Connect-AzureAD -TenantId $TenantID
$functionIdentityObjectId ='9043487a-cf99-430d-a845-aa7b8af345e0'
$graphAppId = '00000003-0000-0000-c000-000000000000' # This is a well-known Microsoft Graph application ID.
$graphApiAppRoleName = 'Application.ReadWrite.All'
$graphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$graphAppId'"
$graphApiAppRole = $graphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $graphApiAppRoleName -and $_.AllowedMemberTypes -contains "Application"}

# Assign the role to the managed identity.
New-AzureADServiceAppRoleAssignment -ObjectId $functionIdentityObjectId -PrincipalId $functionIdentityObjectId -ResourceId $graphServicePrincipal.ObjectId -Id $graphApiAppRole.Id


New-AzureADServiceAppRoleAssignment `
    -ObjectId $managedIdentityObjectId `
    -Id $appRoleId `
    -PrincipalId $managedIdentityObjectId `
    -ResourceId $serverServicePrincipalObjectId
```

## Demo

You can find example for Storage Account rotation in tutorial below:
[Automate the rotation of a secret for resources that have two sets of authentication credentials](https://docs.microsoft.com/azure/key-vault/secrets/tutorial-rotation-dual)

Youtube:
https://youtu.be/qcdVbXJ7e-4

**Project template information**:

This project was generated using [this](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell) template. You can find instructions [here](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell/blob/main/Project-Template-Instructions.md)
