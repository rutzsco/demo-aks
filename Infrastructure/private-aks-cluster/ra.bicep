
param miID string
param roleDefinitionResourceId string
param routeTableName string


resource udr 'Microsoft.Network/routeTables@2021-08-01' existing = {
   name: routeTableName
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  scope: udr
  name: guid(udr.id, miID, roleDefinitionResourceId)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: miID
    principalType: 'ServicePrincipal'
  }
}

output roleAssignmentId string = roleAssignment.id
