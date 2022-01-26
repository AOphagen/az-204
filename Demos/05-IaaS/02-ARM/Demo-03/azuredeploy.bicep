param storageAcctName string = 'demostorageap234'

resource storageAcctName_resource 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAcctName
  location: 'westeurope'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAcctName_default 'Microsoft.Storage/storageAccounts/blobServices@2019-06-01' = {
  parent: storageAcctName_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAcctName_default 'Microsoft.Storage/storageAccounts/fileServices@2019-06-01' = {
  parent: storageAcctName_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
  }
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource storageAcctName_default_websitezipfileoutput 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  parent: storageAcctName_default
  name: 'websitezipfileoutput'
  properties: {
    IsManualIntegration: true
  }
  dependsOn: [
    storageAcctName_resource
  ]
}