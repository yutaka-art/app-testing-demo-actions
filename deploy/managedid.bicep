param envFullName string = ''

param managedIdName string = 'id-${envFullName}'
param location string = resourceGroup().location

// ManagedIdentity
resource managedId 'Microsoft.ManagedIdentity/userAssignedIdentities@2024-11-30' = {
  name: managedIdName
  location: location
}
