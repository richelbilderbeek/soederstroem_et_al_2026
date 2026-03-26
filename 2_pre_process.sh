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

# However, some images fail
convert data/cyberugglan.jpg -resize 224x224 intermediate/cyberugglan.jpeg
convert data/trefnyivan.jpg -resize 224x224 intermediate/trefnyivan.jpeg


