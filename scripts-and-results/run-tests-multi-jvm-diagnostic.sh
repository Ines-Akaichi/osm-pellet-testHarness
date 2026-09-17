#!/bin/bash
# Path to the jar
JAR1="osm-owl-testHarness-0.0.1-SNAPSHOT.jar"
# Paths to dataset folders
ABOX_DIR="data/abox"
# Path to output folder
OUTPUT_FILE1="data/results/results-experiments-J-200.csv"
TOTAL_ITERATIONS=200
# Check if the CSV file exists
if [ ! -f "$OUTPUT_FILE1" ]; then
  # If not, create it and write the header line
  echo "iteration,timestamp,aboxSizeOblig,queryKeyword,elapsedTimeInMillis,memoryUsedInKB,tboxLoadMs,aboxLoadMs,contextBuildMs,inferenceMs,queryMs,gcCount,gcTimeMs" > "$OUTPUT_FILE1"
fi
echo
echo "=========================================="
echo "=== Running all abox files==="
echo "=========================================="
for query in "OBLIGATION_STATE" "REGULATED_ACTION_STATE" "TEMPORAL_ACTION_STATE" "EVENT_STATE" "ENTITY" "ACTION" "RESOURCE"; do
  for nbOblig in 9 18 27 36 45 54 63 72 81; do
    file_path="$ABOX_DIR/generated-obligations-$nbOblig.ttl"
    # clear cash 

  	sync
	  sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
            
    for i in  $(seq 1 "$TOTAL_ITERATIONS");  do
      /usr/lib/jvm/java-8-temurin-jdk/bin/java -Xms1g -Xmx1g   -jar "$JAR1" "$file_path" "$query" "$i" >> "$OUTPUT_FILE1"
    done
  done
done