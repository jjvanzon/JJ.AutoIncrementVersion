BuildNum
========

__Azure Pipelines__ task that:

- Finds `BuildNum.xml`
- Reads `BuildNum` element
- Stores it in the `$(BuildNum)` variable

It has no parameters, only the output `$(BuildNum)` variable, so you can just drop it in and use it.

Intended for use with the [`JJ.AutoIncrementVersion`](https://www.nuget.org/packages/JJ.AutoIncrementVersion) nuget package for auto-incremental version numbers in __.NET__.

`$(BuildNum)` can be used at your whim in your pipeline. You could use it as part of the build/version/release numbers __Azure DevOps__ displays.

But the main thing it solves is for [`JJ.AutoIncrementVersion`](https://www.nuget.org/packages/JJ.AutoIncrementVersion). It keeps `$(BuildNum)` constant during the solution build. See, `MSBuild` has a way of deciding for us whether it'll use the initial build number or an incremented one, as multiple projects build one by one or even in parallel. 


By passing it to the `MSBuild Task` you can mitigate the problem. Fill this under `MSBuild Arguments:`

```
/p:BuildNum=$(BuildNum)
```

This prevents the build from incrementing the `BuildNum` variable multiple times for each individual project in your solution. 

If you need something more specific, I can recommend the [Set variable with value from XML](https://marketplace.visualstudio.com/items?itemName=YodLabs.VariableTasks) task by [Yod Labs](https://marketplace.visualstudio.com/publishers/YodLabs). Using these parameters accomplishes something similar:


```
Variable Name    : BuildNum
XPath expression : //BuildNum
XML file path    : BuildNum.xml
```

`Set variable with value from XML` might not recursively search for the `BuildNum.xml` but uses a literal path. `BuildNum` searches recursively and has no parameterization burden, working out of the box with the [`JJ.AutoIncrementVersion`](https://www.nuget.org/packages/JJ.AutoIncrementVersion) nuget package.