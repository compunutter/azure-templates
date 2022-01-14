# Deploy AVD with DomainController to Azure

Use the following command:

``` New-AzDeployment -DeploymentName "AvdDeploymentPart1" -Location uksouth -TemplateFile main.bicep ```

## Part 1
The following will be deployed:
* Resource Group
* VNet + subnet
* Domain Controller VM  in 'Servers' subnet
* AVD - Workspace
* AVD - Host pool (empty)
* AVD - Application group (w/ default desktop)
* Recovery Service Vault - with the DomainController included in the backup policy

## Part 2
tbc