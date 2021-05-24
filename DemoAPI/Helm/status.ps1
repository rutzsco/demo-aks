
Function Req {
    Param(
        [string]$endpoint ='http://52.224.123.87/status',
        [string]$method ='GET',
        [int]$Retries = 1,
        [int]$SecondsDelay = 2
    )

    $cmd = { Write-Host "$method $endpoint..." -NoNewline; Invoke-WebRequest $endpoint -Method $method}

    $retryCount = 0
    $completed = $false
    $response = $null

    while (-not $completed) {
        try {
            $response = Invoke-Command $cmd -ArgumentList $Params
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

$res = Req -Retries $Retries -SecondsDelay $SecondsDelay -Params @{ 'Method'=$Method;'Uri'=$URI;'TimeoutSec'=$TimeoutSec;'UseBasicParsing'=$true }

if($res.Content -ne "$SuccessTextContent")
{
    Write-Error $response.Content
}
else
{
    Write-Host "Helath check validation success."
}