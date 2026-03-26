#!/bin/bash
#
# Run the whole pipeline
#
#
./1_create_pre_data.R
./2_pre_process.sh 
./3_run_processed_data_stop_the_steal.py > results_stop_the_steal.jsonl
./3_run_processed_data_swexit.py > results_swexit.jsonl
./3_run_processed_data_yttrandefrihet.py > results_yttrandefrihet.jsonl

echo " "
echo "DONE!"
echo " "
