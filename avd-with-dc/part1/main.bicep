param custName string
param custPrefix string
param adminUsername string
@secure()
param adminPass string

targetScope = 'subscription'

param tags object = {
  Customer: custName
  'Production Resource': 'yes'
  Solution: 'AVD'
}

// Create resource group
resource newRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${custPrefix}-rg-avd'
  location: deployment().location
  tags: tags
}

// Create the VNET
module newVnet 'module.network.bicep' = {
  name: 'networkModule'
  scope: newRG
  params: {
    custPrefix: custPrefix
    tags: tags
  }
}

// Create the Domain Controller VM
module newDc 'module.domaincontroller.bicep' = {
  name: 'domainControllerModule'
  scope: newRG
  params: {
    custPrefix: custPrefix
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
    custPrefix: custPrefix
    tags: tags
  }
}

// Create the ASR vault
module newRsv 'module.rsv.bicep' = {
  name: 'rsvModule'
  scope: newRG
  params: {
    custPrefix: custPrefix
    domainControllerId: newDc.outputs.domainControllerId
    domainControllerName: newDc.outputs.domainControllerName
    tags: tags
  }
}

// TODO: VmStartStop Script
// TODO: Run PS script to add RMM to domain controller
