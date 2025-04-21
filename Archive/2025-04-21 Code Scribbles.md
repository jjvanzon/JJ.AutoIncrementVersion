```xml
  <Message Text="$(ToolTitle) ⚠️ WARNING ⚠️ DLL NOT FOUND!" Importance="High" />
  <Message Text="$(ToolTitle) DllDirProd = $(DllDirProd)" Importance="High" />
  <Message Text="$(ToolTitle) DllDirDev = $(DllDirDev)" Importance="High" />
  <Message Text="$(ToolTitle) DllDir = $(DllDir)" Importance="High" />
    
    DllDirProd = $(DllDirProd)
    DllDirDev = $(DllDirDev)
    DllDir = $(DllDir)
    DllAvailable = $(DllAvailable)

<Target Name="JJ_AutoInc_LogDllVars" BeforeTargets="$(Targets)">
  <PropertyGroup>
    <DllVariables>$(ToolTitle) VARS
    </DllVariables>
  </PropertyGroup>
  
  <Message Text="$(DllVariables)" Importance="High" />
</Target>
```