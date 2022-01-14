param custPrefix string
param tags object

//Create AVD Hostpool
resource hp 'Microsoft.DesktopVirtualization/hostpools@2019-12-10-preview' = {
  name: '${custPrefix}-hpl-${resourceGroup().location}-1'
  location: resourceGroup().location
  tags: tags
  properties: {
    friendlyName: '${custPrefix} AVD Host Pool'
    hostPoolType: 'Pooled'
    loadBalancerType: 'BreadthFirst'
    preferredAppGroupType: 'Desktop'
    maxSessionLimit: 45
    validationEnvironment: false
  }
}

//Create AVD AppGroup
resource ag 'Microsoft.DesktopVirtualization/applicationgroups@2019-12-10-preview' = {
  name: '${custPrefix}-dag-${resourceGroup().location}-desktop'
  location: resourceGroup().location
  tags: tags
  properties: {
    friendlyName: '${custPrefix} Desktop Application Group'
    applicationGroupType: 'Desktop'
    hostPoolArmPath: hp.id
  }
}

//Create AVD Workspace
resource ws 'Microsoft.DesktopVirtualization/workspaces@2019-12-10-preview' = {
  name: '${custPrefix}-${resourceGroup().location}-ws'
  location: resourceGroup().location
  tags: tags
  properties: {
    friendlyName: '${custPrefix} Workspace'
    applicationGroupReferences: [
      ag.id
    ]
  }
}
