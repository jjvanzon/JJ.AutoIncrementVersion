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