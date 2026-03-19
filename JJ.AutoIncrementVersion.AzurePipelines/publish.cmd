@echo off

rem install node js

winget install OpenJS.NodeJS.LTS

rem Installs command line tooling for Azure DevOps, formerly VSTS, formerly TFS
rem Hopefully just skips if already installed
rem -g = global

npm install -g tfx-cli

rem Create package
rem --rev-version : increments version automatically
rem Outputs a .visx file

tfx extension create --manifest-globs vss-extension.json --rev-version
