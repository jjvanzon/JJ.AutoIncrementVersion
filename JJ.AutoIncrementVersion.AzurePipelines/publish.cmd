rem [ PRELIMINARY SCRIPT ]

rem install node js

winget install OpenJS.NodeJS.LTS

rem -----

rem Install npm = node package manager
rem lts = long term support
rem nvm = node version manager
rem Turs out unnecessary.

rem nvm install lts
rem nvm use lts 

rem -----

rem Installs command line tooling for Azure DevOps, formerly VSTS, formerly TFS
rem Hopefully just skips if already installed
rem -g = global

npm install -g tfx-cli

rem Create package
rem --rev-version : increments version automatically
rem Iutputs a .visx file

tfx extension create --manifest-globs vss-extension.json --rev-version