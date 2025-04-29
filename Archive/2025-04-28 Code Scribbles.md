.targets file:

```xml

;DllDevCore

  <!--<DllTfmOlder>net48</DllTfmOlder>
  <DllTfmMono>net462</DllTfmMono>
  <DllTfmCore>net7.0</DllTfmCore>
  <DllTfmFull>netstandard2.0</DllTfmFull> --><!-- In Visual Studio --><!--
  <DllTfm>$(DllTfmOlder)</DllTfm>
  <DllTfm Condition="'$(MSBuildRuntimeType)'=='Mono'">$(DllTfmMono)</DllTfm>
  <DllTfm Condition="'$(MSBuildRuntimeType)'=='Core'">$(DllTfmCore)</DllTfm>
  <DllTfm Condition="'$(MSBuildRuntimeType)'=='Full'">$(DllTfmFull)</DllTfm>-->
  <!--<DllTfm Condition=" '$(MSBuildRuntimeType)' != 'Core' ">netstandard2.0</DllTfm>
  <DllTfm Condition=" '$(MSBuildRuntimeType)' == 'Core' ">net6.0</DllTfm>-->
  <!--<DllProd>$(MSBuildThisFileDirectory)../lib/$(DllTfm)/JJ.AutoIncrementVersion.Tasks.dll</DllProd>-->
  <DllTfm>netstandard2.0</DllTfm>

  DllTfmOlder = $(DllTfmOlder)
  DllTfmMono = $(DllTfmMono)
  DllTfmCore = $(DllTfmCore)
  DllTfmFull = $(DllTfmFull)
  DllTfm = $(DllTfm)

  ToolTitle = $(ToolTitle)
  Init = $(Init)
  Content = $(Content)
  Load = $(Load)
  Save = $(Save)
  Stage = $(Stage)


Condition="'$(ItRanjj)'==''"

  <PropertyGroup><ItRanjj>True</ItRanjj></PropertyGroup>

```

Main csproj:

```
    <!--<TargetFrameworks>net8.0</TargetFrameworks>-->
    <!--<TargetFrameworks>net9.0;net8.0</TargetFrameworks>-->
    <!--<TargetFrameworks>net9.0;net8.0;net7.0;net6.0;net5.0;net461</TargetFrameworks>-->

    <!--<CopyLocalLockFileAssemblies>True</CopyLocalLockFileAssemblies>-->
        
    <!--
    <Content Include="build\JJ.AutoIncrementVersion.props">
      <Pack>False</Pack>
      <CopyToOutputDirectory>Never</CopyToOutputDirectory>
    </Content>
    -->
```

Tasks csproj:

```
    <!--<TargetFrameworks>
      net9.0;net8.0;netstandard2.1;netstandard2.0
    </TargetFrameworks>-->
    <!--<TargetFrameworks>
      net9.0;net8.0;net7.0;
      net481;net48;net472;net471;net47;net462;net461;
      netstandard2.1;netstandard2.0
    </TargetFrameworks>-->
    <!--<TargetFrameworks>
      net9.0;net8.0;net7.0;
      net481;net48;net472;net471;net47;net462;
      netstandard2.1;netstandard2.0
    </TargetFrameworks>-->

    <!--<Nullable>enable</Nullable>-->
    <!--<CopyLocalLockFileAssemblies>True</CopyLocalLockFileAssemblies>
    <DevelopmentAssembly>True</DevelopmentAssembly>-->
```

Removing redundant .props logic:

```
  
    ;PropsContent

    <PropsContent>
      <Project>
        <PropertyGroup Condition="'%24(BuildNum)'==''"><BuildNum>$(BuildNum)</BuildNum></PropertyGroup>
      </Project>
    </PropsContent>
    
    <!-- Overwrite with new variant of PropsContent -->
    <!--<PropsContent>$(DirPropsContent)</PropsContent>-->
    <PropsContent>
      <Project>
        <Import Project="../$(XmlName)" Condition="'%24(XmlImportedjj)'=='' And Exists('../$(XmlName)')"/>
      </Project>
    </PropsContent>
  
  <!-- Stage package bound .props location, to import BuildNum early enough for use in csproj. --> 
  <!--
  <Message Text="$(Stage) $(BuildNum) => .props &quot;$(Props)&quot;" Importance="High"  />
  <WriteLinesToFile 
    Condition="!$(DllAvailable)" 
    File="$(Props)" Lines="$(PropsContent)" Overwrite="True" ContinueOnError="True" WriteOnlyWhenDifferent="True" />
  <WriteLinesNoTimestamp 
    Condition="$(DllAvailable)" 
    File="$(Props)" Lines="$(PropsContent)" Overwrite="True" ContinueOnError="True" WriteOnlyWhenDifferent="True"/>
  -->
```

Trying to display a message from a .props file (didn't work):

```
  <Target Name="JJ_Auto_Inc_Props" BeforeTargets="BeforeBuild;JJ_AutoInc_BuildSteps">
    <Message Text="JJ-AUTO-INC RUN JJ.AutoIncrementVersion.props" Importance="High" />
    <Message Text="JJ-AUTO-INC IMPORT BuildNum.xml ?" Importance="High" />
    <Message Text="JJ-AUTO-INC IMPORT XmlImportedjj = $(XmlImportedjj)" Importance="High" />
    <Message Text="JJ-AUTO-INC IMPORT Exists('../BuildNum.xml') = $(Exists('../BuildNum.xml'))" Importance="High" />
  </Target>
```

Sticking to single variable Props_Loadedjj for now:

```
    <!--<Props_Condition_Expressionjj>'%24(XmlImportedjj)'=='' And Exists('../BuildNum.xml')</Props_Condition_Expressionjj>
    <Props_Condition_Valuejj>'$(XmlImportedjj)'=='' And Exists('../BuildNum.xml')</Props_Condition_Valuejj>
    <Props_XmlImportedjj>$(XmlImportedjj)</Props_XmlImportedjj>
    <Props_BuildNum_Xml_Existsjj>$(Exists('../BuildNum.xml')</Props_BuildNum_Xml_Existsjj>-->

  Props_Condition_Expressionjj = $(Props_Condition_Expressionjj)
  Props_Condition_Valuejj = $(Props_Condition_Valuejj)
  Props_XmlImportedjj = $(Props_XmlImportedjj)
  Props_BuildNum_Xml_Existsjj = $(Props_BuildNum_Xml_Existsjj)

```

Old writing to package folder:

```
  <!-- STAGE -->
  
  <!-- Stage XML to package folder, where it's referenced by the .props file for early availability in a csproj. -->
  <!--
  <Message Text="$(Stage) $(BuildNum) => .xml &quot;$(PackXml)&quot;" Importance="High" />
  <WriteLinesToFile 
    Condition="!$(DllAvailable)" 
    File="$(PackXml)" Lines="$(XmlContent)" Overwrite="True" ContinueOnError="True" WriteOnlyWhenDifferent="True" />
  <WriteLinesNoTimestamp 
    Condition="$(DllAvailable)" 
    File="$(PackXml)" Lines="$(XmlContent)" Overwrite="True" ContinueOnError="True" WriteOnlyWhenDifferent="True" />
  -->
```

Extended dir props content:

```xml
        <PropertyGroup>
          <DirProps_Loadedjj>True</DirProps_Loadedjj>
          <DirProps_LoadTimejj>%24([System.DateTime]::Now.ToString("yyyy-MM-dd HH:mm:ss.ffffff"))</DirProps_LoadTimejj>
          <DirProps_XmlRefjj>$(XmlName)</DirProps_XmlRefjj>
          <DirProps_XmlImportedjj_Pre>%24(XmlImportedjj)</DirProps_XmlImportedjj_Pre>
        </PropertyGroup>
        ...
        <PropertyGroup>
          <DirProps_XmlImportedjj_Post>%24(XmlImportedjj)</DirProps_XmlImportedjj_Post>
        </PropertyGroup>

    DirProps_Loadedjj = $(DirProps_Loadedjj)
    DirProps_LoadTimejj = $(DirProps_LoadTimejj)
    DirProps_XmlRefjj = $(DirProps_XmlRefjj)
    DirProps_XmlImportedjj_Pre = $(DirProps_XmlImportedjj_Pre)
    DirProps_XmlImportedjj_Post = $(DirProps_XmlImportedjj_Post)

```

```xml
  <Target Condition="'$(Dll)'==''" Name="JJ_AutoInc_DllMissing" BeforeTargets="$(BeforeTargets)">
    <Message Text="JJ-AUTO-INC ⚠️ WARNING ⚠️ DLL not found." Importance="High" />
  </Target>
```