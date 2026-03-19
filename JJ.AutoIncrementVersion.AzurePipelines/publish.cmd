rem [ PRELIMINARY SCRIPT ]

rem install node js

winget install OpenJS.NodeJS.LTS

rem Install npm = node package manager
rem lts = long term support
rem nvm = node version manager

nvm install lts
nvm use lts 

rem Installs command line tooling for Azure DevOps, formerly VSTS, formerly TFS
rem Hopefully just skips if already installed

npm install -g tfx-cli

rem Create package
rem --rev-version : increments version automatically
rem Iutputs a .visx file

tfx extension create --manifest-globs vss-extension.json --rev-version