#!/bin/bash
#
# From the m3inference doc
#
#
# Creates files:
# - test/data_resized.jsonl
# - test/pic_resized/

python scripts/preprocess.py --source_dir test/pic/ --output_dir test/pic_resized/ --jsonl_path test/data.jsonl --jsonl_outpath test/data_resized.jsonl --verbose
