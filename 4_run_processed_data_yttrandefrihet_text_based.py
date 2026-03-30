#!/bin/env python3
import torch
from m3inference import M3Inference
import pprint
m3 = M3Inference(use_full_model=False)
pred = m3.infer('./intermediate/yttrandefrihet_text_based.jsonl')
pprint.pprint(pred)

