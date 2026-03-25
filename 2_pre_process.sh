#!/bin/bash
#
# From the m3inference doc
#
#
# Creates files:
# - test/data_resized.jsonl
# - test/pic_resized/

# Does most of the images
python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/data.jsonl --jsonl_outpath intermediate/data_resized.jsonl --verbose

# However, some images fail
convert data/cyberugglan.jpg -resize 224x224 intermediate/cyberugglan.jpeg
convert data/trefnyivan.jpg -resize 224x224 intermediate/trefnyivan.jpeg


