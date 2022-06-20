# Deploy AVD with DomainController to Azure

## Part 1
The following will be deployed:
* Resource Group
* VNet + subnet
* Domain Controller VM  in 'Servers' subnet
* AVD - Workspace
* AVD - Host pool (empty)
* AVD - Application group (w/ default desktop)
* Recovery Service Vault - with the DomainController included in the backup policy

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcompunutter%2Fazure-templates%2Fmain%2Favd-with-dc%2Fpart1%2Fmain.json)

## Part 2 - TODO
The following will be deployed:
* SH - joined to the Windows AD domain
* AppServer - also AD joined

## Part 3 - TODO
The following will be deployed test restore backups to for testing - this is optional:
* Backup-restore Resource Group
* Backup-restore Storage account
* Backup-restore VNet