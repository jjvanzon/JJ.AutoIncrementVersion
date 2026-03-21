$buildNum = & "$PSScriptRoot\Get-BuildNum.ps1" -Root $env:BUILD_SOURCESDIRECTORY

Write-Host "##vso[task.setvariable variable=BuildNum]$buildNum"
