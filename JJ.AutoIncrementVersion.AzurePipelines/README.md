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
|-- README.md               : this file
|-- vss-extension.json      : extension manifest (packaging entry point)
|
|-- images         
|   |-- extension-icon.png  : 128×128 PNG
|
|-- BuildNumTask
    |-- task.json           : task definition (GUI inputs, execution, restrictions)
    |-- icon.png            : 32×32 PNG
    |-- BuildNum.ps1        : PowerShell script run by the agent
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

## Use in a classic GUI pipeline

1. Edit a pipeline and click **Add task**.
2. Search for **Read Build Number**.
3. Add it to the job — no inputs to configure.
4. Reference the result in later steps as `$(BuildNum)`.

References
----------

- [x] Add a custom pipelines task extension (how to author task.json, tests, package):  
      <https://learn.microsoft.com/azure/devops/extend/develop/add-build-task?view=azure-devops>
- [ ] Extension manifest / vss-extension.json (manifest details):  
      <https://learn.microsoft.com/azure/devops/extend/develop/manifest?view=azure-devops>
- [ ] Package and publish extensions to the Visual Studio Marketplace (tfx usage, publishing steps):  
      <https://learn.microsoft.com/azure/devops/extend/publish/overview?view=azure-devops>