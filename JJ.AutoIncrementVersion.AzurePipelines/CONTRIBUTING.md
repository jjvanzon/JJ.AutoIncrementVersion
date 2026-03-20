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

Variables
--------------------

| Variable                      | Description |
|-------------------------------|-------------|
| `execution\PowerShell3`       | No Node.js or TypeScript needed for a pure PowerShell task
| `$env:BUILD_SOURCESDIRECTORY` | This is PowerShell syntax that accesses the `$(Build.SourcesDirectory)` Azure Pipelines variable, inserted as an env var by the Pipeline agent.
| `settableVariables`           | Restricted to `["BuildNum"]` only — limits what the task is allowed to set for security.
| `outputVariables`             | Declares `BuildNum` so downstream tasks can reference it as `$(ReadBuildNum.BuildNum)` when a step reference name is set.

### Versioning

| File | Field to increment |
|------|--------------------|
| `BuildNumTask\task.json` | `version.Major / Minor / Patch`
| `vss-extension.json`     | `version`

### Package

You might want to update the minor version in `vss-extension.json` and `task.json` first.

To package it to a .vsix you can publish to the Visual Studio Marketplace, run:

```
.\pack.cmd
```

which you can find in this folder. It will prepare output the .vsix, but not publish it automatically.


Publish to the Marketplace
--------------------------

```powershell
tfx extension publish --manifest-globs vss-extension.json --share-with yourOrganization
```

- While the extension is in development, keep `"extensionVisibility": "private"` (not in the manifest by default — private is the default when unpublished).
- To make it public, add `"public"` to `"galleryFlags"` in `vss-extension.json`, or set visibility in the Publishing Portal.

## Install in an Azure DevOps organization

1. Go to **Organization Settings → Extensions**.
2. Find the extension under **Extensions Shared With Me** (private) or search the Marketplace (public).
3. Select **Get it free** / **Install**.

References
----------

- [x] Add a custom pipelines task extension (how to author task.json, tests, package):  
      <https://learn.microsoft.com/azure/devops/extend/develop/add-build-task?view=azure-devops>
- [x] Extension manifest reference / vss-extension.json:  
      <https://learn.microsoft.com/azure/devops/extend/develop/manifest?view=azure-devops>
- [ ] Package and publish extensions to the Visual Studio Marketplace (tfx usage, publishing steps):  
      <https://learn.microsoft.com/azure/devops/extend/publish/overview?view=azure-devops>