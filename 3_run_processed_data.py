#!/bin/env python3
import torch
from m3inference import M3Inference
import pprint
m3 = M3Inference()
pred = m3.infer('./intermediate/yttrandefrihet_resized.jsonl')
pprint.pprint(pred)

#python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/stop_the_steal.jsonl --jsonl_outpath intermediate/stop_the_steal_resized.jsonl --verbose
#python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/swexit.jsonl         --jsonl_outpath intermediate/swexit_resized.jsonl         --verbose
#python scripts/preprocess.py --source_dir data --output_dir intermediate --jsonl_path intermediate/yttrandefrihet.jsonl --jsonl_outpath intermediate/yttrandefrihet_resized.jsonl --verbose
