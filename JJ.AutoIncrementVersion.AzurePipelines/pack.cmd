@echo off

rem Usage: 
rem pack.cmd        = private
rem pack.cmd public = public (Marketplace-visible)

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
echo Create VSIX Package
echo -------------------
echo(
rem --rev-version : increments version automatically
if /I "%~1"=="public" (
  call tfx extension create --manifest-globs vss-extension.json --rev-version --overrides-file public.json
) else (
  call tfx extension create --manifest-globs vss-extension.json --rev-version
)
