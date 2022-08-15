#todo:
#- PS for NIC config: (may not be necessary)
#-- Get-NetAdapter | Select-Object InterfaceAlias , InterfaceIndex
#-- Get-DnsClientServerAddress -InterfaceIndex 6
#-- Set-DnsClientServerAddress -ServerAddresses ("127.0.0.1","1.1.1.1") -InterfaceIndex (Get-NetAdapter).InterfaceIndex

#New-NetIPAddress -IPAddress 10.0.0.4 -DefaultGateway 10.0.0.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex
#New-NetIPAddress –IPAddress 192.168.1.13 -DefaultGateway 192.168.1.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex
# ^^ Not working - giving a 'Instance MSFT_NetIPAddress already exists' error

Rename-Computer -NewName "<hostname>"

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "<domain>.local" -DomainNetBiosName "<domain>" -InstallDns

# Add domain as a UPN suffix

# Create AD OUs:
## Synced with AAD
### Users
### Devices
### Groups

# Create 'AVD Users' group

# Instal AAD Connect
