#!/bin/bash
set -euo pipefail

RESULTS_DIR=$1
DB=$2
THREADS=$3
MAX_TARGET_SEQS=1
N_FILES=12

mkdir -p $RESULTS_DIR

echo "Running annotation against database of glucocorticoid-responsive genes"

for FILE in $(ls 01_GitHub/data/*.fastq.gz); 
    do echo "Annotating file: $FILE"; diamond blastx -d $DB -q $FILE -o $RESULTS_DIR/$(basename $FILE .fastq.gz)_matches.tab --threads $THREADS --max-target-seqs $MAX_TARGET_SEQS --outfmt 6; 
done

# check if 12 annotation results were generated, and exit code 1 if not
if [ $(ls $RESULTS_DIR/*_matches.tab | wc -l) -ne $N_FILES ]; then
    echo "Error: Not all annotation results were generated. Expected $N_FILES, but found $(ls $RESULTS_DIR/*_matches.tab | wc -l)."
    exit 1
fi

echo "Annotation complete"