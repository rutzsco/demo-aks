
Function GetStatus {
    Param(
        [string]$endpoint ='http://13.90.75.121/status',
        [string]$method ='GET',
        [int]$Retries = 1,
        [int]$SecondsDelay = 2
    )

    $retryCount = 0
    $completed = $false
    $response = $null

    while (-not $completed) {
        try {
            Write-Host "$method $endpoint..." -NoNewline;
            $response = Invoke-WebRequest $endpoint -Method $method
            if ($response.StatusCode -ne 200) {
                throw "Expecting reponse code 200, was: $($response.StatusCode)"
            }
            $completed = $true
        } catch {
            Write-Output "$(Get-Date -Format G): Request to $url failed. $_"
            if ($retrycount -ge $Retries) {
                Write-Error "Request to $url failed the maximum number of $retryCount times."
                throw
            } else {
                Write-Warning "Request to $url failed. Retrying in $SecondsDelay seconds."
                Start-Sleep $SecondsDelay
                $retrycount++
            }
        }
    }

    Write-Host "OK ($($response.StatusCode))"
    return $response
}

$statusResponse = GetStatus -Retries $Retries -SecondsDelay $SecondsDelay -Params @{ 'Method'=$Method;'Uri'=$URI;'TimeoutSec'=$TimeoutSec;'UseBasicParsing'=$true }
$resultObj = ConvertFrom-Json $([String]::new($statusResponse.Content))
Write-Host $resultObj.version
Write-Host $resultObj.deploymentSlot

$currentDeploymentSlot = $resultObj.deploymentSlot
$nextDeploymentSlot = "blue"
if($currentDeploymentSlot -eq 'blue')  {
    $nextDeploymentSlot = "green"
}

Write-Host "##vso[task.setvariable variable=DEPLOY_CURRENT_SLOT]$currentDeploymentSlot"
Write-Host "##vso[task.setvariable variable=DEPLOY_NEXT_SLOT]$nextDeploymentSlot"