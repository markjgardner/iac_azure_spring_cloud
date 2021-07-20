param location string

resource law 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'mjgspring-law'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

resource ai 'Microsoft.Insights/components@2020-02-02' = {
  name: 'mjgspring-ai'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: 'mjgspring-vn'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/8'
      ]
    }
  }

  resource serviceSubnet 'subnets' = {
    name: 'spring-services'
    properties: {
      addressPrefix: '10.0.1.0/24'
    }
  }

  resource appSubnet 'subnets' = {
    name: 'spring-apps'
    properties: {
      addressPrefix: '10.0.2.0/24'
    }
  }
}

resource mjgspring 'Microsoft.AppPlatform/Spring@2021-06-01-preview' = {
  name: 'mjgspring'
  location: location
  properties: {
    networkProfile: {
      serviceRuntimeSubnetId: virtualNetwork::serviceSubnet.id
      appSubnetId: virtualNetwork::appSubnet.id
    }
  }
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
}
