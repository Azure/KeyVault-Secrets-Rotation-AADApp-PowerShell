# ###THIS IS TEMPLATE PROJECT FOR SECRET ROTATION FUNCTIONS. FOLLOW [THIS](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell/blob/main/Project-Template-Instructions.md) STEPS TO CREATE NEW SECRETS ROTATION FUNCTION PROJECT REPOSITORY###.

# KeyVault-Secrets-Rotation-[ServiceType]-PowerShell

Functions regenerate individual key (alternating between two keys) in [ServiceType] and add regenerated key to Key Vault as new version of the same secret.

## Features

This project framework provides the following features:

* Rotation function for [ServiceType] key triggered by Event Grid (AKV[ServiceType]Rotation)

* Rotation function for [ServiceType] key triggered by HTTP call (AKV[ServiceType]RotationHttp)

* ARM template for function deployment with secret deployment (optional)

* ARM template for adding [ServiceType] key to existing function with secret deployment (optional)

## Getting Started

Functions require following information stored in secret as tags:

* $secret.Tags["ValidityPeriodDays"] - number of days, it defines expiration date for new secret
* $secret.Tags["CredentialId"] - [ServiceType] credential id
* $secret.Tags["ProviderAddress"] - [ServiceType] Resource Id

You can create new secret with above tags and [ServiceType] key as value or add those tags to existing secret with [ServiceType] key. For automated rotation expiry date will also be required - key vault triggers 'SecretNearExpiry' event 30 days before expiry.

There are two available functions performing same rotation:

* AKV[ServiceType]Rotation - event triggered function, performs [ServiceType] key rotation triggered by Key Vault events. In this setup Near Expiry event is used which is published 30 days before expiration
* AKV[ServiceType]RotationHttp - on-demand function with KeyVaultName and Secret name as parameters

Functions are using Function App identity to access Key Vault and existing secret "CredentialId" tag with [ServiceType] key id (key1/key2) and "ProviderAddress" with [ServiceType] Resource Id.

### Installation

ARM templates available:

* [Secrets rotation Azure Function and configuration deployment template](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell/blob/main/ARM-Templates/Readme.md) - it creates and deploys function app and function code, creates necessary permissions, Key Vault event subscription for Near Expiry Event for individual secret (secret name can be provided as parameter), and deploys secret with Redis key (optional)
* [Add event subscription to existing Azure Function deployment template](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell/blob/main/ARM-Templates/Readme.md) - function can be used for multiple services for rotation. This template creates new event subscription for secret and necessary permissions to existing function, and deploys secret with Redis key (optional)

## Demo

You can find example for Storage Account rotation in tutorial below:
[Automate the rotation of a secret for resources that have two sets of authentication credentials](https://docs.microsoft.com/azure/key-vault/secrets/tutorial-rotation-dual)

Youtube:
https://youtu.be/qcdVbXJ7e-4

**Project template information**:

This project was generated using [this](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell) template. You can find instructions [here](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell/blob/main/Project-Template-Instructions.md)
