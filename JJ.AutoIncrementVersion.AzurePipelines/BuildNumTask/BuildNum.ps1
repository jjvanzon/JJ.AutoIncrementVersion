$root = $env:BUILD_SOURCESDIRECTORY

$file = Get-ChildItem -Path $root -Recurse -Filter "BuildNum.xml" -File |
        Select-Object -First 1

if (-not $file) { throw "No BuildNum.xml found under $root." }

[xml]$xml = Get-Content -Path $file.FullName -Raw
$buildNumNode = $xml.SelectSingleNode("//BuildNum")

if (-not $buildNumNode -or [string]::IsNullOrWhiteSpace($buildNumNode.InnerText)) {
    throw "BuildNum element not found or empty in $($file.FullName)."   
}

$buildNum = $buildNumNode.InnerText.Trim()

Write-Host "Found BuildNum.xml: $($file.FullName)"
Write-Host "BuildNum = $buildNum"
Write-Host "##vso[task.setvariable variable=BuildNum]$buildNum"
