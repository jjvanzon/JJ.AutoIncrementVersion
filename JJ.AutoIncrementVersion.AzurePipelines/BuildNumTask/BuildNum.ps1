$root = $env:BUILD_SOURCESDIRECTORY
$file = Get-ChildItem -Path $root -Recurse -Filter "BuildNum.xml" -File |
        Select-Object -First 1
if (-not $file) { 
    throw "No BuildNum.xml found under root $root or its sub-folders." 
}
Write-Host "Found BuildNum.xml = $($file.FullName)"

[xml]$xml = Get-Content -Path $file.FullName -Raw
$buildNumNode = $xml.SelectSingleNode("//BuildNum")
if (-not $buildNumNode) {
    throw "BuildNum element not found in $($file.FullName)."   
}

$buildNum = $buildNumNode.InnerText.Trim()
if ([string]::IsNullOrWhiteSpace($buildNum)) {
    throw "BuildNum element empty in $($file.FullName)."   
}
Write-Host "BuildNum = $buildNum"

Write-Host "##vso[task.setvariable variable=BuildNum;isOutput=true]$buildNum"
