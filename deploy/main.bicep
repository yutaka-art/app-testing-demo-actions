param envFullName string
//param envShortName string
param location string = resourceGroup().location

// Managed Identity
module managedId 'managedid.bicep' = {
  params: {
    envFullName: envFullName
    location: location
  }
}

// Load Test Service
module loadtestService 'loadtest.bicep' = {
  params: {
    envFullName: envFullName
    location: location
  }
}

// App Service
module appService 'appservice.bicep' = {
  params: {
    envFullName: envFullName
    location: location
  }
}

