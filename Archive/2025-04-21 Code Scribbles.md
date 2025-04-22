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


<!--<Target Condition="$(DllAvailable) And '$(ItRanjj)'==''" 
        Name="JJ_AutoIncrementVersion_Target" 
        BeforeTargets="$(Targets)">-->
 
        <!--<PropertyGroup><DisableFastUpToDateCheck>True</DisableFastUpToDateCheck></PropertyGroup>-->
 
  <DllDevPreMSBuild15>$(MSBuildThisFileDirectory)../../JJ.AutoIncrementVersion.Tasks/bin/$(Configuration)/net48/JJ.AutoIncrementVersion.Tasks.dll</DllDevPreMSBuild15>
  <DllDevMono>$(MSBuildThisFileDirectory)../../JJ.AutoIncrementVersion.Tasks/bin/$(Configuration)/net462/JJ.AutoIncrementVersion.Tasks.dll</DllDevMono>
  <DllDevCore>$(MSBuildThisFileDirectory)../../JJ.AutoIncrementVersion.Tasks/bin/$(Configuration)/netstandard2.0/JJ.AutoIncrementVersion.Tasks.dll</DllDevCore>
  <DllDevFull>$(MSBuildThisFileDirectory)../../JJ.AutoIncrementVersion.Tasks/bin/$(Configuration)/net7.0/JJ.AutoIncrementVersion.Tasks.dll</DllDevFull>

  <DllDev>$(DllDevPreMSBuild15)</DllDev>
  <!--<DllDev>$(MSBuildThisFileDirectory)../../JJ.AutoIncrementVersion.Tasks/bin/$(Configuration)/$(TargetFramework)/JJ.AutoIncrementVersion.Tasks.dll</DllDev>-->
  <!--<DllDev>$(MSBuildThisFileDirectory)../../JJ.AutoIncrementVersion.Tasks/bin/$(Configuration)/net9.0/JJ.AutoIncrementVersion.Tasks.dll</DllDev>-->
  <!--<DllDev>$(MSBuildThisFileDirectory)../../JJ.AutoIncrementVersion.Tasks/bin/$(Configuration)/netstandard2.0/JJ.AutoIncrementVersion.Tasks.dll</DllDev>-->
  <!--<DllProd>$(MSBuildThisFileDirectory)../lib/netstandard2.0/JJ.AutoIncrementVersion.Tasks.dll</DllProd>-->

  <DllProdCore>$(MSBuildThisFileDirectory)../lib/$(TargetFramework)/JJ.AutoIncrementVersion.Tasks.dll</DllProdCore>


  
  DllDev = $(DllDev)
  DllProd = $(DllProd)
  Dll = $(Dll)
  DllAvailable = $(DllAvailable)

```