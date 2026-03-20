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
echo Create VSIX Package
echo -------------------
echo(
rem --rev-version : increments version automatically
call tfx extension create --manifest-globs vss-extension.json --rev-version
rem call tfx extension create --manifest-globs vss-extension.json
