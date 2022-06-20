param resPrefix string
param domainControllerName string
param domainControllerId string
param tags object

// Create RSV for backups
resource rsv 'Microsoft.RecoveryServices/vaults@2021-08-01' = {
  name: '${resPrefix}-rsv-${resourceGroup().location}-1'
  location: resourceGroup().location
  tags: tags
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource rsvBackupStorageConfig 'Microsoft.RecoveryServices/vaults/backupstorageconfig@2021-10-01' = {
  name: '${rsv.name}/VaultStorageConfig'
  location: resourceGroup().location
  properties: {
    storageType: 'LocallyRedundant'
  }

}

var backupFabric = 'Azure'
var protectionContainer = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${domainControllerName}'
var protectedItem = 'vm;iaasvmcontainerv2;${resourceGroup().name};${domainControllerName}'

// resource rsv_dc_backup 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2021-10-01' = {
//   name: '${rsv.name}/${backupFabric}/${protectionContainer}/${protectedItem}'
//   location: resourceGroup().location
//   properties: {
//     protectedItemType: 'Microsoft.Compute/virtualMachines'
//     policyId: '${rsv.id}/backupPolicies/DefaultPolicy'
//     sourceResourceId: domainControllerId
//   }
//   dependsOn: [
//     rsvBackupStorageConfig
//   ]
// } 
