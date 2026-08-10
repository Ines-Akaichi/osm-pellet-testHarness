package wu.ac.at.owl.evaluation;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.slf4j.bridge.SLF4JBridgeHandler;

/**
 * Single-JVM-per-measurement harness (same CLI contract as before):
 * one call to main() does exactly one timed pass and prints one CSV line.
 * Each row still pays fresh JVM/class-loading/JIT-tier-0 cost,
 * since rows are produced by separate `java -jar ...` invocations from an
 * external driver script.
 */
public class TestHarness {

    public static void main(String[] args) throws Exception {

        SLF4JBridgeHandler.removeHandlersForRootLogger();
        SLF4JBridgeHandler.install();

        if (args.length < 3) {
            printUsage();
            System.exit(1);
        }

        String aboxPath;
        String elapseTime = null;
        String queryKeyword;
        int iterationNb;

        if (args.length == 4) {
            aboxPath     = args[0];
            elapseTime   = args[1];
            queryKeyword = args[2];
            iterationNb  = Integer.parseInt(args[3]);
        } else if (args.length == 3) {
            aboxPath     = args[0];
            queryKeyword = args[1];
            iterationNb  = Integer.parseInt(args[2]);
        } else {
            printUsage();
            return;
        }

        String aboxFileName = aboxPath.replace(".ttl", "");
        String aboxSizeOblig = aboxFileName.replaceAll("[^0-9]", "");

        /* ---- Measured run ---- */
        PipelineMetrics m = PipelineRunner.runOnce(aboxPath, elapseTime, queryKeyword);

        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // CSV: iteration,timestamp,aboxSizeOblig,queryKeyword,elapsedTimeInMillis,memoryUsedInKB,
        //      tboxLoadMs,aboxLoadMs,contextBuildMs,inferenceMs,queryMs,gcCount,gcTimeMs
        System.out.printf("%d,%s,%s,%s,%d,%d,%s%n",
                iterationNb, timestamp, aboxSizeOblig, queryKeyword,
                m.totalMs, m.memoryUsedKB, m.toCsvFragment());
    }

    private static void printUsage() {
        System.err.println(
            "Usage:\n" +
            "  java -jar testHarness.jar <abox.ttl> [elapseTime] <QUERY_KEYWORD> <ITERATION_NUMBER>\n\n" +
            "CSV columns:\n" +
            "  iteration,timestamp,aboxSizeOblig,queryKeyword,elapsedTimeInMillis,memoryUsedInKB,\n" +
            "  " + PipelineMetrics.csvHeaderFragment() + "\n\n" +
            "Keywords:\n" +
            "  OBLIGATION_STATE\n" +
            "  REGULATED_ACTION_STATE\n" +
            "  TEMPORAL_ACTION_STATE\n" +
            "  EVENT_STATE\n" +
            "  ENTITY\n" +
            "  ACTION\n" +
            "  RESOURCE\n"
        );
    }
}