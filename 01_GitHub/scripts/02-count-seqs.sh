#!/bin/bash
set -euo pipefail

RESULTS_DIR=$1
RESULT=$RESULTS_DIR/seq_counts.tsv
N_FILES=12

echo "Summarizing FastQ files"

mkdir -p $RESULTS_DIR
echo -e "Sample\tFormat\tType\tNum_Seqs\tTotal_Length\tMin_Length\tAvg_Length\tMax_Length" > $RESULT

for FILE in 01_GitHub/data/*.fastq.gz
do
    SAMPLE=$(basename "$FILE" .fastq.gz)

    seqkit stats -T "$FILE" \
    | tail -n +2 \
    | awk -v sample="$SAMPLE" -v OFS='\t' '
        {
            gsub(",", "", $4)
            gsub(",", "", $5)

            print sample, $2, $3, $4, $5, $6, $7, $8
        }
    ' >> "$RESULT"
done

# Check if the summary file was generated and contains 12 lines of data (excluding header), and exit code 1 if not
if [ $(wc -l < $RESULT) -ne $((N_FILES + 1)) ]; then
    echo "Error: The summary file does not contain the expected number of lines. Expected $((N_FILES + 1)), but found $(wc -l < $RESULT)."
    exit 1
fi

echo "SeqKit summary complete"