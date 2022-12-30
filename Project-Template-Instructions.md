# KeyVault-Secrets-Rotation-Template-PowerShell Instructions

[Template Github project](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell)

This template can be used to create project repository for secrets rotation functions for services credentials.

## Project template structure

* **AKV[ServiceType]Rotation** - folder with rotation function code template with event trigger
    * **-function.json**
    * **-run.ps1**
* **AKV[ServiceType]RotationHttp** - folder rotation function code template with http trigger
    * **-function.json**
    * **-run.ps1**
* **ARM-Templates**
    * **Add-Event-Subscription** - event subscription deployment for existing function
        * **-azuredeploy.json**
    * **Function** - Azure function and configuration deployment
        * **-azuredeploy.json**
* **-host.json**
* **-profile.ps1**
* **-requirements.psd1**

## Setup rotation function project repository steps

1. Create new repository using [this project](https://github.com/Azure/KeyVault-Secrets-Rotation-Template-PowerShell/) as template. 
    1. Click **Use this template** on github page
        1. Type repository name using format "KeyVault-Secrets-Rotation-[ServiceType]-PowerShell" i.e. "KeyVault-Secrets-Rotation-StorageAccount-PowerShell"
        1. Select **Public**
        1. Click **Create repository from template**
1. Download repository code to local machine and use Visual Studio Code to edit files
1. Rename Azure function folders by replacing **ServiceType** with resource provider/service name i.e. 'AKVStorageAccountRotation' and 'AKVStorageAccountRotationHttp'. Folder names will be used names of deployed Azure functions.
1.  Update **run.ps1** files under Azure function folders (event trigger and http)
    1.  Update **RegenerateCredential** to regenerate password/key for your service following provided example.
    1. Update **GetAlternateCredentialId** to return alternate username/key id.
1. Update ARM templates
    1. Update 'azuredeploy.json' under Function and Add-Event-Subscription folders
        1. Replace "[ServiceType]" with your service/resource provider type name i.e. "StorageAccountRG","StorageAccountName", "StorageKey" in parameters and resources. Notice that 'Microsoft.KeyVault/vaults/providers/eventSubscriptions' need function name to match folder updated in previous step.
        1. Update "repoURL" default value in Function ARM template to your github url.
        1. Add script to deploy secret - update listkey function based on your resource provider/service	    
        1. Add script for adding access to service/resource provider for your function on the bottom of the template file. Example for assigning role for Storage Account is provided as an example.
        
1. Update 'README', 'CHANGELOG' and 'CONTRIBUTING' files. You can use Visual Studio Code replace in files functionality to replace [ServiceType] with service/resource provider type name.
1. Update links for **Deploy to Azure** buttons in [README](./ARM-Templates/README.md) to point to new ARM templates in your github repository. You can find more information about deployment buttons [here](https://docs.microsoft.com/azure/azure-resource-manager/templates/deploy-to-azure-button)

    


