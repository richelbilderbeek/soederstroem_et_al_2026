#!/bin/bash
#
# Run the whole pipeline
#
#
./1_create_pre_data.R
./2_pre_process.sh 
./3_run_processed_data.py > results.jsonl
