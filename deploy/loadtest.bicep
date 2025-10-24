param envFullName string = ''

param loadTestServiceName string = 'lt-${envFullName}'
param location string = resourceGroup().location

// Load Test Service
resource loadTestService 'Microsoft.LoadTestService/loadTests@2024-12-01-preview' = {
  name: loadTestServiceName
  location: location
  properties: {
    description: 'Load Test Service for ${envFullName}'
  }
}
