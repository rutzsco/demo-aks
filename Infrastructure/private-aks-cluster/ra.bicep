
param miID string
param roleDefinitionResourceId string
param storageAccountName string


resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccountName
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  scope: storageAccount
  name: guid(storageAccount.id, miID, roleDefinitionResourceId)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: miID
    principalType: 'ServicePrincipal'
  }
}

output roleAssignmentId string = roleAssignment.id
