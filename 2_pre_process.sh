#!/bin/bash
#
# From the m3inference doc
#
#
# Creates files:
# - test/data_resized.jsonl
# - test/pic_resized/


# Does most of the images
python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/stop_the_steal.jsonl --jsonl_outpath intermediate/stop_the_steal_resized.jsonl --verbose
python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/swexit.jsonl         --jsonl_outpath intermediate/swexit_resized.jsonl         --verbose
python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/yttrandefrihet.jsonl --jsonl_outpath intermediate/yttrandefrihet_resized.jsonl --verbose

for data_file_name in $(ls data/*.jpg)
do
  # echo ${data_file_name}
  intermediate_file_name=$(echo ${data_file_name} | sed 's/^data/intermediate/g' | sed 's/jpg$/jpeg/g')
  # echo ${intermediate_file_name}
  if [ ! -f ${intermediate_file_name} ]
  then
    echo "Creating ${intermediate_file_name}, as it was not created by m3inference"
    convert ${data_file_name} -resize 224x224 ${intermediate_file_name}
  fi
done

# Does most of the images
python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/stop_the_steal.jsonl --jsonl_outpath intermediate/stop_the_steal_resized.jsonl --verbose
python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/swexit.jsonl         --jsonl_outpath intermediate/swexit_resized.jsonl         --verbose
python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/yttrandefrihet.jsonl --jsonl_outpath intermediate/yttrandefrihet_resized.jsonl --verbose
