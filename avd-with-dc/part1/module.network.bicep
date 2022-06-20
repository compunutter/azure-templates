param resPrefix string
param tags object

// Create VNET
resource vn 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: '${resPrefix}-vnet-${resourceGroup().location}-corp'
  location: resourceGroup().location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: [
        '10.0.0.4'
        '1.1.1.1'
      ]
    }
  }
}

// Create subnet
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  parent: vn
  name: 'Servers'
  properties: {
    addressPrefix: '10.0.0.0/24'
  }
}

output subnetId string = subnet.id
