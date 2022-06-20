param resPrefix string
param tags object

//Create AVD Hostpool
resource hp 'Microsoft.DesktopVirtualization/hostpools@2019-12-10-preview' = {
  name: '${resPrefix}-hpl-${resourceGroup().location}-1'
  location: resourceGroup().location
  tags: tags
  properties: {
    friendlyName: '${resPrefix} AVD Host Pool'
    hostPoolType: 'Pooled'
    loadBalancerType: 'BreadthFirst'
    preferredAppGroupType: 'Desktop'
    maxSessionLimit: 45
    validationEnvironment: false
  }
}

//Create AVD AppGroup
resource ag 'Microsoft.DesktopVirtualization/applicationgroups@2019-12-10-preview' = {
  name: '${resPrefix}-dag-${resourceGroup().location}-desktop'
  location: resourceGroup().location
  tags: tags
  properties: {
    friendlyName: '${resPrefix} Desktop Application Group'
    applicationGroupType: 'Desktop'
    hostPoolArmPath: hp.id
  }
}

//Create AVD Workspace
resource ws 'Microsoft.DesktopVirtualization/workspaces@2019-12-10-preview' = {
  name: '${resPrefix}-${resourceGroup().location}-ws'
  location: resourceGroup().location
  tags: tags
  properties: {
    friendlyName: '${resPrefix} Workspace'
    applicationGroupReferences: [
      ag.id
    ]
  }
}
