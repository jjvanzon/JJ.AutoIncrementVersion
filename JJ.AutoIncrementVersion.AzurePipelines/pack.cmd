@echo off

echo(
echo Install Node.js
echo ---------------
echo(
winget install OpenJS.NodeJS.LTS

echo(
echo Install Azure DevOps CLI
echo ------------------------
echo(
rem -g = global
call npm install -g tfx-cli

echo(
echo Read BuildNum.xml
echo -----------------
echo(
for /f %%i in ('powershell -NoProfile -ExecutionPolicy Bypass -File "BuildNumTask\Get-BuildNum.ps1" -Root ".."') do set BUILDNUM=%%i
for /f %%i in ('powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-Content 'vss-extension.json' -Raw | ConvertFrom-Json).version"') do set CURRENT_VERSION=%%i
for /f "tokens=1,2 delims=." %%a in ("%CURRENT_VERSION%") do (
  set MAJOR=%%a
  set MINOR=%%b
)
set EXT_VERSION=%MAJOR%.%MINOR%.%BUILDNUM%

echo Using extension version: %EXT_VERSION%

echo { "version": "%EXT_VERSION%" } > _tfx-overrides.json

echo(
echo Create VSIX Package
echo -------------------
echo(
call tfx.cmd extension create --manifest-globs vss-extension.json --overrides-file _tfx-overrides.json

del /q _tfx-overrides.json
