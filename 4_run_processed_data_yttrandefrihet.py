#!/bin/env python3
import torch
from m3inference import M3Inference
import pprint
m3 = M3Inference()
pred = m3.infer('./intermediate/yttrandefrihet_resized.jsonl')
pprint.pprint(pred)

