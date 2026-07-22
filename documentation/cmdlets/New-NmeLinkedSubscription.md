# New-NmeLinkedSubscription

**Endpoint:** `POST /api/v1/subscriptions`

## Description

Link Azure subscription

**Output Type:** `ILinkedSubscription`

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| AvdEnabled | SwitchParameter | Yes |  |
| CostManagementEnabled | SwitchParameter | Yes |  |
| SubscriptionId | String | Yes |  |
| TenantId | String | Yes |  |
| ServicePrincipalAppId | String | No |  |
| ServicePrincipalAppName | String | No |  |
| ServicePrincipalAppSecret | String | No |  |
| ServicePrincipalAzureType | String | No | Values: `AzureCloud`, `AzureUSGovernment`, `AzureChina` |
| ServicePrincipalCertificateName | String | No |  |

## Examples

### Example 1: Link subscription which has configured RBAC roles for NME app

```powershell
New-NmeLinkedSubscription `
    -SubscriptionId "e0b52e85-7caf-4260-a772-c0d82e56d407" `
    -TenantId "dc241a32-1d84-464c-a4eb-5b88a071ff3e"
```

### Example 2: Link subscription using app credentials

```powershell
New-NmeLinkedSubscription `
    -SubscriptionId "e0b52e85-7caf-4260-a772-c0d82e56d407" `
    -TenantId "dc241a32-1d84-464c-a4eb-5b88a071ff3e" `
    -ServicePrincipalAppId "49969ccb-3430-4957-94db-3594c60c60c4" `
    -ServicePrincipalAppSecret "_ASFsaf97asf9a7sfoa_~~2143" `
    -ServicePrincipalAzureType "AzureCloud"
```

