package wu.ac.at.owl.evaluation;


/**
 * Per-phase timing/memory/GC breakdown for a single run of the pipeline.
 * All *Ms fields are milliseconds.
 */
public class PipelineMetrics {

    public long tboxLoadMs;
    public long aboxLoadMs;
    public long contextBuildMs;
    public long inferenceMs;
    public long queryMs;
    public long totalMs;
    public long memoryUsedKB;

    // Deltas across the whole measured run (sum across all GC beans)
    public long gcCountDelta;
    public long gcTimeMsDelta;

    public String toCsvFragment() {
        return tboxLoadMs + "," + aboxLoadMs + "," + contextBuildMs + "," + inferenceMs + ","
                + queryMs + "," + gcCountDelta + "," + gcTimeMsDelta;
    }

    public static String csvHeaderFragment() {
        return "tboxLoadMs,aboxLoadMs,contextBuildMs,inferenceMs,queryMs,gcCount,gcTimeMs";
    }
}