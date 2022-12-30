# AAD App Client Secret rotation ARM templates

This template creates below components to help demonstrate Identity Platform Client Secret rotation in Key Vault using Function and Event Grid notification.

### AAD App Client Secret rotation functions ARM template:

Components:

- App Service Plan
- Function App with access to Key Vault
- Functions to rotate AAD App Client Secret
- Event Subscription
- Secret deployment (optional)

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FKeyVault-Secrets-Rotation-AADApp-ClientSecret-PowerShell%2Fmain%2FARM-Templates%2FFunction%2Fazuredeploy.json" target="_blank">
    <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FKeyVault-Secrets-Rotation-AADApp-ClientSecret-PowerShell%2Fmain%2FARM-Templates%2FFunction%2Fazuredeploy.json" target="_blank">
    <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.png"/>
</a>

### Event subscription for existing AADApp-ClientSecret keys rotation function ARM template

Components:

- Event Subscription
- Secret deployment (optional)

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FKeyVault-Secrets-Rotation-AADApp-ClientSecret-PowerShell%2Fmain%2FARM-Templates%2FAdd-Event-Subscription%2Fazuredeploy.json" target="_blank">
    <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2KeyVault-Secrets-Rotation-AADApp-ClientSecret-PowerShell%2Fmain%2FARM-Templates%2FAdd-Event-Subscription%2Fazuredeploy.json" target="_blank">
    <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.png"/>
</a>

If you are new to the template development, see:

- [Azure Resource Manager documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/)
- [Use Azure Key Vault to pass secure parameter value during deployment](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-keyvault-parameter)
- [Tutorial: Integrate Azure Key Vault in Resource Manager Template deployment](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-tutorial-use-key-vault)

Tags: Azure Key Vault, Key Vault, Resource Manager, Resource Manager templates, ARM templates
