@description('Value for \'Customer\' tag.')
param custName string
@description('Resource prefix (do not add hyphen, will be converted to lowercase).')
param custPrefix string
@description('Local admin user - cannot be administrator')
param adminUsername string
@secure()
@description('Local admin password')
param adminPass string

targetScope = 'subscription'
var resPrefix = toLower(custPrefix)

param tags object = {
  Customer: custName
  'Production Resource': 'yes'
  Solution: 'AVD'
}

// Create resource group
resource newRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resPrefix}-rg-avd'
  location: deployment().location
  tags: tags
}

// Create the VNET
module newVnet 'module.network.bicep' = {
  name: 'networkModule'
  scope: newRG
  params: {
    resPrefix: resPrefix
    tags: tags
  }
}

// Create the Domain Controller VM
module newDc 'module.domaincontroller.bicep' = {
  name: 'domainControllerModule'
  scope: newRG
  params: {
    resPrefix: resPrefix
    adminUsername: adminUsername
    adminPass: adminPass
    subnetId: newVnet.outputs.subnetId
    tags: tags
  }
}

// Create AVD Host pool, Application Group and Workspace
module newAVDTenant 'module.avdcomponents.bicep' = {
  name: 'avdComponentsModule'
  scope: newRG
  params: {
    resPrefix: resPrefix
    tags: tags
  }
}

// Create the ASR vault
module newRsv 'module.rsv.bicep' = {
  name: 'rsvModule'
  scope: newRG
  params: {
    resPrefix: resPrefix
    domainControllerId: newDc.outputs.domainControllerId
    domainControllerName: newDc.outputs.domainControllerName
    tags: tags
  }
}
