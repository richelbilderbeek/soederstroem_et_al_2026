#!/bin/env python3
#
# From https://github.com/euagendas/m3inference
#
# Uses m3inference, install with:
#
# pip install m3inference --break-system-packages
#
# Data from m3inference test suite:
#
# - GitHub view: https://github.com/euagendas/m3inference/blob/master/test/data.jsonl
# - Raw data: https://raw.githubusercontent.com/euagendas/m3inference/refs/heads/master/test/data.jsonl
#
from m3inference import M3Inference
import pprint
m3 = M3Inference()
pred = m3.infer('data.jsonl')
pprint.pprint(pred)
