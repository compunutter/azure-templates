param custPrefix string
param adminUsername string
param adminPass string
param subnetId string
param tags object

var vmName = '${custPrefix}-vm-ad01'
var dcNic = '${vmName}-nic'

// Create NIC for DC
resource dcNetworkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: dcNic
  location: resourceGroup().location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: '10.0.0.4'
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}

// Create Domain Controller (VM)
resource dcVirtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: resourceGroup().location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B4ms'
    }
    osProfile: {
      computerName: '${custPrefix}-ad01'
      adminUsername: adminUsername
      adminPassword: adminPass
      windowsConfiguration: {
        timeZone: 'GMT Standard Time'
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter'
        version: 'latest'
      }
      osDisk: {
        name: '${vmName}-osdisk'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
      dataDisks:[
        {
          name: '${vmName}-datadisk0'
          diskSizeGB: 60
          createOption: 'Empty'
          lun: 0
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: dcNetworkInterface.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
  }
}

output domainControllerId string = dcVirtualMachine.id
output domainControllerName string = dcVirtualMachine.name
