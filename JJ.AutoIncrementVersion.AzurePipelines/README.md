# JJ.AutoIncrementVersion.AzurePipelines

Azure DevOps Marketplace extension that exposes the `BuildNum` value from `BuildNum.xml` as a pipeline variable.

## Folder structure

```
JJ.AutoIncrementVersion.AzurePipelines\
├── README.md                         ← this file
├── vss-extension.json                ← extension manifest (packaging entry point)
├── images\
│   └── extension-icon.png            ← ⚠ must be supplied manually (128×128 PNG)
└── ReadBuildNumTask\
    ├── task.json                     ← task definition (GUI inputs, execution, restrictions)
    ├── icon.png                      ← ⚠ must be supplied manually (32×32 PNG)
    └── BuildNum.ps1                  ← PowerShell script run by the agent
```

## What the task does

1. Reads the `BUILD_SOURCESDIRECTORY` environment variable (set by the agent from `Build.SourcesDirectory`).
2. Recursively searches for the first `BuildNum.xml` file under that directory.
3. Reads the `<BuildNum>` element value from that file.
4. Sets it as the pipeline variable `BuildNum` via `##vso[task.setvariable variable=BuildNum]`.

Downstream tasks and steps can then reference `$(BuildNum)` or `$(ReadBuildNum.BuildNum)`.

## Key design notes

| Topic | Detail |
|---|---|
| **Execution type** | `PowerShell3` — no Node.js or TypeScript needed for a pure PowerShell task |
| **`$env:BUILD_SOURCESDIRECTORY`** | The `$(Build.SourcesDirectory)` macro syntax is expanded by the agent only in task *inputs*, not inside `.ps1` file bodies. Environment variables must be used instead. |
| **`settableVariables`** | Restricted to `["BuildNum"]` only — limits what the task is allowed to set for security. |
| **`outputVariables`** | Declares `BuildNum` so downstream tasks can reference it as `$(ReadBuildNum.BuildNum)` when a step reference name is set. |
| **Task GUID** | `a8f5a385-72e1-43f7-bb03-4cc7892e3fd2` — must never change after publishing; changing it creates a new task. |

## One-time setup: icons

Two PNG icon files must be added manually before packaging:

- `images\extension-icon.png` — 128×128 px, shown in the Marketplace listing.
- `ReadBuildNumTask\icon.png` — 32×32 px, shown next to the task in the pipeline editor.

The existing `jj-icon-64x64-margin4.png` in the repo root can be resized for both.

## One-time setup: publisher

1. Sign in to the [Visual Studio Marketplace Publishing Portal](https://marketplace.visualstudio.com/manage).
2. Create a publisher if one does not exist yet.
3. Update `"publisher"` in `vss-extension.json` to match that publisher ID exactly (currently set to `"jjvanzon"`).

## Prerequisites (once per machine)

```powershell
npm install -g tfx-cli
```

## Package the extension

Run from inside this folder (`JJ.AutoIncrementVersion.AzurePipelines\`):

```powershell
tfx extension create --manifest-globs vss-extension.json
```

This produces a `.vsix` file. To auto-increment the patch version each time:

```powershell
tfx extension create --manifest-globs vss-extension.json --rev-version
```

## Publish to the Marketplace

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

## Versioning

Both files must be updated together before re-packaging:

| File | Field to increment |
|---|---|
| `ReadBuildNumTask\task.json` | `version.Major / Minor / Patch` |
| `vss-extension.json` | `version` |

Semantic versioning guidance:
- **Major** — breaking change to inputs or outputs.
- **Minor** — new feature, backward compatible.
- **Patch** — bug fix only.
