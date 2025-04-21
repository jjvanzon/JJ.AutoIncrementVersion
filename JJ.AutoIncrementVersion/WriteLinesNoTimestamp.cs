
namespace JJ.AutoIncrementVersion;

public class WriteLinesNoTimestamp : Task
{
    private const string TaskTitle = $"{ToolTitle} {nameof(WriteLinesNoTimestamp)}";

    /// <inheritdoc cref="WriteLinesToFile.File" />
    [Required]
    public ITaskItem File { get; set; }

    /// <inheritdoc cref="WriteLinesToFile.Lines" />
    [Required]
    public ITaskItem[] Lines { get; set; }

    /// <inheritdoc cref="WriteLinesToFile.Overwrite" />
    public bool Overwrite { get; set; }
    
    /// <inheritdoc cref="WriteLinesToFile.Encoding" />
    public string Encoding { get; set; }
    
    /// <inheritdoc cref="WriteLinesToFile.WriteOnlyWhenDifferent" />
    public bool WriteOnlyWhenDifferent { get; set; }

    /// <inheritdoc cref="WriteLinesToFile.FailIfNotIncremental" />
    public bool FailIfNotIncremental { get; set; }
    
    /// <inheritdoc cref="WriteLinesToFile.CanBeIncremental" />
    [Obsolete]
    public bool CanBeIncremental => WriteOnlyWhenDifferent;

    public override bool Execute()
    {
        try
        {
            Log.LogMessage(High, $"{TaskTitle} START");
            
            string path = File?.ItemSpec;
            DateTime timeStamp = default;

            if (Exists(path))
            {
                timeStamp = GetLastWriteTimeUtc(path);
                Log.LogMessage(High, $"{TaskTitle} GET {timeStamp} <= {path}");
            }

            var innerTask = new WriteLinesToFile
            {
                BuildEngine = BuildEngine,
                File = File,
                Lines = Lines,
                Overwrite = Overwrite,
                Encoding = Encoding,
                WriteOnlyWhenDifferent = WriteOnlyWhenDifferent,
                FailIfNotIncremental = FailIfNotIncremental
            };
           if (!innerTask.Execute())
            {
                return false;
            }

            if (timeStamp != default)
            {
                SetLastWriteTimeUtc(path, timeStamp);
                Log.LogMessage(High, $"{TaskTitle} SET {timeStamp} => {path}");
            }

            return true;
        }
        catch (Exception ex)
        {
           Log.LogErrorFromException(ex);
           return false;
        }
    }
}
