#!/bin/bash
#
# From the m3inference doc
#
#
# Creates files:
# - test/data_resized.jsonl
# - test/pic_resized/

python scripts/preprocess.py --source_dir intermediate --output_dir intermediate --jsonl_path intermediate/data.jsonl --jsonl_outpath intermediate/data_resized.jsonl --verbose
