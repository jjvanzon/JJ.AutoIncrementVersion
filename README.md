What is JJ.AutoIncrementVersion ?!
==================================

We want our `*` back!

Those don't work anymore for version numbers. But we want auto-incremental numbers!

This package allows you to use `$(BuildNum)` instead.


How to Use?
===========
 
You can use `$(BuildNum)` inside your version number, like this:

```
1.0.$(BuildNum)
```

And the effective version becomes something like this:

```
1.0.123
```

Every time you build your project, the `$(BuildNum)` is simply incremented by `1`.


Setup
=====

- Install the package.
- Build twice for luck.
- Start using `$(BuildNum)`.


Advanced Use?
=============

Nothing:

- No config
- No command line
- No hidden options
 
Just:

- Install the package, 
- Add `$(BuildNum)` to your version.
- And build.

 
Bonus "Features" (Shush)
========================

- Logs could be "less screamy", but are perfect as is.
- You can edit BuildNum.xml manually, but you probably won't want to.
- Kills "up to date" build messages
- Increments multiple times per solution build
- Accidental scoping / multiple version number ranges
- Multi-user sequence contention. (My excuse: the asterisk * had the same problem.)
- Works solution-wide by referencing one project, or it doesn't.
- Typo fails with irrelevant error; not my fault!
- NCrunch will wake up at some point, eventually.
- BuildNum zombie resurrection: "You uninstalled the package, but $(BuildNum) is still there!"
- Custom build number: Pass /p:BuildNum=`<number>` to set the package version at build time.
- But don't expect your original version number back.


Azure Pipelines
===============

[Visual Studio Marketplace BuildNum](https://marketplace.visualstudio.com/items?itemName=janjoostvanzon.buildnum) is a zero-config task that reads the `$(BuildNum)` variable for you. It can be used at your whim, e.g. incorporate it into reference numbers or pass it along to tasks for a reliable snapshot of BuildNum.

Release Notes
=============

|       |                 |
|-------|-----------------|
| `1.8` | Initial release  
| `1.9` | Fix file in use error  
| `2.0` | Prevent IntelliSense rescan  
| `2.1` | Housekeeping  
| `2.2` | Reduce memory leak in "probably updated nugets" process  
| `2.3` | Total restructure, zero effect  
| `2.4` | BuildNum exists? Directory.Build.props = optional  
| `3.5` | BuildNum.xml inclusion = optional (for customization for performance)  
| `3.6` | Avoid modifying BuildNum prop mid-build, using temp prop to write BuildNum.xml  
| `4.2` | Fix race-condition causing duplicating content in auto-created Directory.Build.props
|       | Add variable BuildNumWasFromXmljj for future use
| `4.3` | Azure Pipelines task for reading out BuildNum
| `4.7` | Leave out Task DLL (more secure)


💬 Feedback 
============

Found an issue? [Let me know.](https://jjvanzon.github.io/#-how-to-reach-me)