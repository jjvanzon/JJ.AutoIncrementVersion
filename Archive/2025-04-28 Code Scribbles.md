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