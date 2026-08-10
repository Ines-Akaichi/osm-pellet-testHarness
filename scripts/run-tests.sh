# Path to the jar
JAR1="owl-evaluation-pipeline-0.0.1-SNAPSHOT.jar"
JAR2="owl-evaluation-prototype-0.0.1-SNAPSHOT.jar"

# Paths to dataset folders
ABOX_DIR="data/abox"


# Path to output folder

OUTPUT_FILE1="data/results/results-pipeline.csv"
OUTPUT_FILE2="data/results/results-prototype.csv"



# Check if the CSV file exists
if [ ! -f "$OUTPUT_FILE1" ]; then
  # If not, create it and write the header line
  echo "iteration,timestamp,aboxSizeOblig,queryKeyword,elapsedTimeInMillis,memoryUsedInKB" > "$OUTPUT_FILE1"
fi



echo
echo "=========================================="
echo "=== Running all abox files==="
echo "=========================================="

for query in "OBLIGATION_STATE" "REGULATED_ACTION_STATE" "TEMPORAL_ACTION_STATE" "EVENT_STATE" "ENTITY" "ACTION" "RESOURCE"; do

  for nbOblig in 9 18 27 36 45 54 63; do

    for i in 1 2 3 4 5 6 7 8 9 10 ; do

      sleep 5

	# Clean cache (requires root)
	echo "Cleaning cache..."
	sync
	sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

	echo "Cache cleared."


      file_path="$ABOX_DIR/generated-obligations-$nbOblig.ttl"

      java --add-opens java.base/java.lang=ALL-UNNAMED -jar "$JAR1" "$file_path" "$query" "$i" >> "$OUTPUT_FILE1"

	# Clean cache (requires root)
	echo "Cleaning cache..."
	sync
	sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

	echo "Cache cleared."


    done

  done

done


# Check if the CSV file exists
if [ ! -f "$OUTPUT_FILE2" ]; then
  # If not, create it and write the header line
  echo "iteration,timestamp,aboxSizeOblig,queryKeyword,elapsedTimeInMillis,memoryUsedInKB" > "$OUTPUT_FILE2"
fi



echo
echo "=========================================="
echo "=== Running all abox files==="
echo "=========================================="


for query in "OBLIGATION_STATE" "REGULATED_ACTION_STATE" "TEMPORAL_ACTION_STATE" "EVENT_STATE" "ENTITY" "ACTION" "RESOURCE"; do

  for nbOblig in 9 18 27 36 45 54 63; do

    for i in 1 2 3 4 5 6 7 8 9 10 ; do

      sleep 5

	# Clean cache (requires root)
	echo "Cleaning cache..."
	sync
	sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

	echo "Cache cleared."


      file_path="$ABOX_DIR/generated-obligations-$nbOblig.ttl"

      java --add-opens java.base/java.lang=ALL-UNNAMED -jar "$JAR2" "$file_path" "$query" "$i" >> "$OUTPUT_FILE2"

	# Clean cache (requires root)
	echo "Cleaning cache..."
	sync
	sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

	echo "Cache cleared."


    done

  done

done





