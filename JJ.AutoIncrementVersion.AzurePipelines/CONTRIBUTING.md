JJ.AutoIncrementVersion.AzurePipelines
======================================

PowerShell script wrapped as an Azure DevOps / Visual Studio Marketplace extension that:  

- Finds `BuildNum.xml`
- Reads `BuildNum` element
- Stores in `BuildNum` variable

Folder structure
----------------

```
JJ.AutoIncrementVersion.AzurePipelines
|
|-- README.md                   : this file
|-- vss-extension.json          : extension manifest (packaging entry point)
|-- jj-icon-128x128-margin8.png
|
|-- BuildNumTask
    |-- task.json               : task definition (GUI inputs, execution, restrictions)
    |-- icon.png                : 32×32 PNG
    |-- BuildNum.ps1            : PowerShell script run by the agent
```

Prerequisites
-------------

`VstsTaskSdk` was installed under <.\BuildNumTask\ps_modules\VstsTaskSdk> with aid of the following command:

```powershell
Save-Module -Name VstsTaskSdk -Path .
```

If possible in the future this might be scripted in `pack.cmd` to update it every time you pack.

Package
-------

You might want to manually update the major version in and `task.json` first (e.g. `[ 1, 0, 0 ]` => `[2, 0, 0]`).  
Set major and minor version in `vss-extension.json` to something like `4.3`. 
The third element of the `vss-extension.json` version is incremented automatically by the packaging script.

To package it to a `.vsix` you can publish to the __Visual Studio Marketplace__, run:

```
.\pack.cmd
```

Which you can find in this folder. It will prepare output the `.vsix`, but not publish it automatically.


Publish to the Marketplace
--------------------------

New `.vsix` package versions can be uploaded manually via:

<https://marketplace.visualstudio.com/manage/publishers/janjoostvanzon>

There are options to script this, but that's not currently in use:

```powershell
tfx extension publish --manifest-globs vss-extension.json --share-with jjvanzon
```

Lateron might integrate into a deployment pipeline.

AI-generated tips to review:

- While the extension is in development, keep `"extensionVisibility": "private"` (not in the manifest by default - private is the default when unpublished).
- To make it public, add `"public"` to `"galleryFlags"` in `vss-extension.json`.

Variables
---------

| File                        | Field                         | Description |
|-----------------------------|-------------------------------|-------------|
| `vss-extension.json`        | `version`                     | Set major/minor version manually. 3rd number is updated automaticall in `pack.cmd`.
| `BuildNumTask\task.json`    | `execution\PowerShell3`       | No Node.js or TypeScript needed for a pure PowerShell task
| `BuildNumTask\task.json`    | `version.Major`               | Displayed in drop down in __Azure Pipelines__ classic GUI editor as `1.*`, `2.*`, `3.*` 
|                             |                               | Increment the `Major` version manually for a release version.
| `BuildNumTask\BuildNum.ps1` | `$env:BUILD_SOURCESDIRECTORY` | This is PowerShell syntax that accesses the `$(Build.SourcesDirectory)` __Azure Pipelines__ variable, inserted as an env var by the Pipeline agent.

References
----------

- __Add a custom pipelines task extension__ (how to author task.json, tests, package):  
  <https://learn.microsoft.com/azure/devops/extend/develop/add-build-task?view=azure-devops>
- __Extension manifest reference__ / vss-extension.json:  
  <https://learn.microsoft.com/azure/devops/extend/develop/manifest?view=azure-devops>
- __Package and publish extensions__ to the Visual Studio Marketplace (tfx usage, publishing steps):  
  <https://learn.microsoft.com/azure/devops/extend/publish/overview?view=azure-devops>