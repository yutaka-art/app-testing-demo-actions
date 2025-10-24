param envFullName string = ''

param location string = resourceGroup().location
param appServiceName string = 'asp-${envFullName}'
param hostingPlanNameApp string = 'ase-${envFullName}'

// App Service Plan
resource hostingPlanApp  'Microsoft.Web/serverfarms@2024-11-01' = {
  name: hostingPlanNameApp
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
    family: 'F'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    reserved: true // for Linux
  }
}

// App Service
resource appService 'Microsoft.Web/sites@2024-11-01' = {
  name: appServiceName
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: hostingPlanApp.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOCKER|bkimminich/juice-shop:latest'
      http20Enabled: true
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      appSettings: [
        {
          name: 'TZ'
          value: 'Asia/Tokyo'
        }
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Production'
        }
        {
          name: 'WEBSITES_PORT'
          value: '3000'
        }
      ]
    }
  }
}

output siteUrl string = 'https://${appService.properties.defaultHostName}'
