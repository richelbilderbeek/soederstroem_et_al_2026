#!/bin/bash
#
# Run the whole pipeline
#
#
./1_create_pre_data.R
./2_pre_process.sh 
./3_only_keep_existing_images.R
./4_run_processed_data_stop_the_steal.sh
./4_run_processed_data_stop_the_steal_text_based.sh
./4_run_processed_data_swexit.sh
./4_run_processed_data_swexit_text_based.sh
./4_run_processed_data_yttrandefrihet.sh
./4_run_processed_data_yttrandefrihet_text_based.sh
./5_jsons_to_csv.R
echo " "
echo "DONE!"
echo " "
