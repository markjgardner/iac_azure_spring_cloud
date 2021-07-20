targetScope='subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'spring-rg'
  location: 'EastUs'  
}

module spring 'spring.bicep' = {
  name: 'mjgspring'
  scope: rg
  params: {
    location: rg.location
  }
}
