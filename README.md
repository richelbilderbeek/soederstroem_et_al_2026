# twitter_inference

## Installation

Installing the Python package `m3inference` from the Fork by `jieliliu`
at [`https://github.com/jieliliu/m3inference`](https://github.com/jieliliu/m3inference)
can be done as such:

```bash
pip install git+https://github.com/jieliliu/m3inference.git --break-system-packages
```

## Download test data

The testdata can be downloaded from 
[`https://github.com/euagendas/m3inference`](https://github.com/euagendas/m3inference).
The file can be viewed [here](https://github.com/euagendas/m3inference/blob/master/test/data.jsonl).

```
wget https://raw.githubusercontent.com/euagendas/m3inference/refs/heads/master/test/data.jsonl
```

## Download Twitter profiles

For less than 50 profile images per 4 hours,
[using this GitHub repository](https://github.com/sinugrepo/x_profile_downloader)
is easy.

Using [Twitter Media Downloader](https://github.com/mmpx12/twitter-media-downloader.git)
does allow to download all images, but not the profile pictures:

```
git clone https://github.com/mmpx12/twitter-media-downloader.git
cd twitter-media-downloader/
make
twmd --user aborgljung --img
```


## Running

```
./run.sh
```

## Error

```
richel@richel-latitude-7430:~/GitHubs/twitter_inference$ ./3_run_processed_data.py 
03/23/2026 21:17:08 - INFO - m3inference.m3inference -   Version 1.1.5
03/23/2026 21:17:08 - INFO - m3inference.m3inference -   Running on cpu.
03/23/2026 21:17:08 - INFO - m3inference.m3inference -   Will use full M3 model.
03/23/2026 21:17:08 - INFO - m3inference.m3inference -   Model full_model exists at /home/richel/m3/models/full_model.mdl.
03/23/2026 21:17:08 - INFO - m3inference.utils -   Checking MD5 for model full_model at /home/richel/m3/models/full_model.mdl
03/23/2026 21:17:08 - INFO - m3inference.utils -   MD5s match.
03/23/2026 21:17:08 - INFO - m3inference.m3inference -   Loaded pretrained weight at /home/richel/m3/models/full_model.mdl
03/23/2026 21:17:08 - INFO - m3inference.dataset -   50 data entries loaded.
Predicting...:   0%|                                                  | 0/4 [00:00<?, ?it/s]/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/dataloader.py:1118: UserWarning: 'pin_memory' argument is set as true but no accelerator is found, then device pinned memory won't be used.
  super().__init__(loader)
Predicting...:  25%|██████████▌                               | 1/4 [00:01<00:03,  1.33s/it]
Traceback (most recent call last):
  File "/home/richel/GitHubs/twitter_inference/./3_run_processed_data.py", line 6, in <module>
    pred = m3.infer('./intermediate/data_resized.jsonl')
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/richel/.local/lib/python3.12/site-packages/m3inference/m3inference.py", line 130, in infer
    for batch in tqdm(dataloader, desc='Predicting...', disable=logging.root.level>=logging.WARN):
  File "/home/richel/.local/lib/python3.12/site-packages/tqdm/std.py", line 1181, in __iter__
    for obj in iterable:
  File "/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/dataloader.py", line 741, in __next__
    data = self._next_data()
           ^^^^^^^^^^^^^^^^^
  File "/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/dataloader.py", line 1518, in _next_data
    return self._process_data(data, worker_id)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/dataloader.py", line 1586, in _process_data
    data.reraise()
  File "/home/richel/.local/lib/python3.12/site-packages/torch/_utils.py", line 775, in reraise
    raise exception
RuntimeError: Caught RuntimeError in DataLoader worker process 1.
Original Traceback (most recent call last):
  File "/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/_utils/worker.py", line 358, in _worker_loop
    data = fetcher.fetch(index)  # type: ignore[possibly-undefined]
           ^^^^^^^^^^^^^^^^^^^^
  File "/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/_utils/fetch.py", line 57, in fetch
    return self.collate_fn(data)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/_utils/collate.py", line 401, in default_collate
    return collate(batch, collate_fn_map=default_collate_fn_map)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/_utils/collate.py", line 215, in collate
    collate(samples, collate_fn_map=collate_fn_map)
  File "/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/_utils/collate.py", line 155, in collate
    return collate_fn_map[elem_type](batch, collate_fn_map=collate_fn_map)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/_utils/collate.py", line 274, in collate_tensor_fn
    out = elem.new(storage).resize_(len(batch), *list(elem.size()))
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
RuntimeError: Trying to resize storage that is not resizable
```

## FAQ

### Why not use `pip` to install `m3inference`?

Because then you will get the error shown below:

```
Traceback (most recent call last):
  File "/home/richel/GitHubs/twitter_inference/./run.py", line 15, in <module>
    from m3inference import M3Inference
  File "/home/richel/.local/lib/python3.12/site-packages/m3inference/__init__.py", line 1, in <module>
    from .m3inference import M3Inference
  File "/home/richel/.local/lib/python3.12/site-packages/m3inference/m3inference.py", line 14, in <module>
    from .full_model import M3InferenceModel
  File "/home/richel/.local/lib/python3.12/site-packages/m3inference/full_model.py", line 11, in <module>
    class M3InferenceModel(nn.Module):
  File "/home/richel/.local/lib/python3.12/site-packages/m3inference/full_model.py", line 12, in M3InferenceModel
    def __init__(self, device='cuda' if torch.cuda.is_available() else 'cpu'):
                                        ^^^^^
NameError: name 'torch' is not defined
```

Hence, do **not** use the command below to install `m3inference`.

```
pip install m3inference --break-system-packages
```

## Why not install from `https://github.com/euagendas/m3inference`?

Because this gives the following error:

```
richel@richel-latitude-7430:~/GitHubs/twitter_inference$ python3 run.py 
Traceback (most recent call last):
  File "/home/richel/GitHubs/twitter_inference/run.py", line 5, in <module>
    m3 = M3Inference()
         ^^^^^^^^^^^^^
  File "/home/richel/.local/lib/python3.12/site-packages/m3inference/m3inference.py", line 43, in __init__
    set_seed(seed)
  File "/home/richel/.local/lib/python3.12/site-packages/m3inference/utils.py", line 39, in set_seed
    torch.manual_seed(seed)
    ^^^^^
NameError: name 'torch' is not defined
```

Installing the Python package `m3inference` from its homepage at
[`https://github.com/euagendas/m3inference`](https://github.com/euagendas/m3inference)
can be done as such:

```bash
# Fails
pip install git+https://github.com/euagendas/m3inference.git --break-system-packages
```

The install gives the correct last commit hash:

```
richel@richel-latitude-7430:~/GitHubs/twitter_inference$ pip install git+https://github.com/euagendas/m3inference.git --break-system-packages
Defaulting to user installation because normal site-packages is not writeable
WARNING: Skipping /usr/lib/python3.12/dist-packages/protontricks-1.10.5.dist-info due to invalid metadata entry 'name'
Collecting git+https://github.com/euagendas/m3inference.git
  Cloning https://github.com/euagendas/m3inference.git to /tmp/pip-req-build-irzwz5eb
  Running command git clone --filter=blob:none --quiet https://github.com/euagendas/m3inference.git /tmp/pip-req-build-irzwz5eb
  Resolved https://github.com/euagendas/m3inference.git to commit 57953b4bb0bed34ce184253e25b327287b43d5e5
  Preparing metadata (setup.py) ... done
```

However, the code `run.py` will not work.




## Scribbles

## Selecting

### `1_create_pre_data.R `

Filename                                          |Lines|Profiles|Profiles/line
--------------------------------------------------|-----|--------|-------------
[data/yttrandefrihet.csv](data/yttrandefrihet.csv)|453  |69      |15%
[data/swexit.csv](data/swexit.csv)                |1005 |88      |9%
[data/stop_the_steal.csv](data/stop_the_steal.csv)|22003|3664    |?

richel@richel-latitude-7430:~/GitHubs/twitter_inference$ ./1_create_pre_data.R 
csv_file_name: data/yttrandefrihet.csv (453 lines)
jsonl_file_name: intermediate/yttrandefrihet.jsonl (69 lines)
csv_file_name: data/yttrandefrihet.csv (453 lines)
jsonl_file_name: intermediate/yttrandefrihet_text_based.jsonl (311 lines)
csv_file_name: data/swexit.csv (1005 lines)
jsonl_file_name: intermediate/swexit.jsonl (88 lines)
csv_file_name: data/swexit.csv (1005 lines)
jsonl_file_name: intermediate/swexit_text_based.jsonl (644 lines)
csv_file_name: data/stop_the_steal.csv (22003 lines)
jsonl_file_name: intermediate/stop_the_steal.jsonl (3664 lines)
csv_file_name: data/stop_the_steal.csv (22003 lines)
jsonl_file_name: intermediate/stop_the_steal_text_based.jsonl (14560 lines)


### `3_only_keep_existing_images.R `

Filename                                          |Profiles|Full profiles|Full profile/profile
--------------------------------------------------|--------|-------------|-------------
[data/yttrandefrihet.csv](data/yttrandefrihet.csv)|69      |16           |23%
[data/swexit.csv](data/swexit.csv)                |88      |16           |18%
[data/stop_the_steal.csv](data/stop_the_steal.csv)|3664    |22           |0.6%

## Timings

### `1_create_pre_data.R `

Filename                                          |Lines|User time|Time per line
--------------------------------------------------|-----|---------|-------------
[data/yttrandefrihet.csv](data/yttrandefrihet.csv)|453  |17.879s  |0.04 s/line
[data/swexit.csv](data/swexit.csv)                |1005 |29.724s  |0.03 s/line
[data/stop_the_steal.csv](data/stop_the_steal.csv)|22003|7m12.203s|0.02 s/line

### 4

``` 
richel@richel-latitude-7430:~/GitHubs/twitter_inference$ time ./4_run_processed_data_yttrandefrihet_text_based.sh
...
xt_model.mdl
03/30/2026 21:21:41 - INFO - m3inference.dataset -   311 data entries loaded.
Predicting...:   0%|                                                 | 0/20 [00:00<?, ?it/s]/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/dataloader.py:1118: UserWarning: 'pin_memory' argument is set as true but no accelerator is found, then device pinned memory won't be used.
  super().__init__(loader)
Predicting...: 100%|████████████████████████████████████████| 20/20 [00:01<00:00, 13.00it/s]
03/30/2026 21:21:42 - WARNING - m3inference.m3inference -   ID 1158478976 already exists. Please double-check the input data. Skipping for now...

real	1m59.452s
user	0m21.547s
sys	0m2.279s
```

```
richel@richel-latitude-7430:~/GitHubs/twitter_inference$ time ./4_run_processed_data_swexit_text_based.sh 
03/30/2026 21:25:38 - INFO - m3inference.m3inference -   Version 1.1.5
03/30/2026 21:25:38 - INFO - m3inference.m3inference -   Running on cpu.
03/30/2026 21:25:38 - INFO - m3inference.m3inference -   Will use text model. Note that as M3 was optimized to work well with both image and text data,                                     it is not recommended to use text only model unless you do not have the profile image.
03/30/2026 21:25:38 - INFO - m3inference.m3inference -   Model text_model exists at /home/richel/m3/models/text_model.mdl.
03/30/2026 21:25:38 - INFO - m3inference.utils -   Checking MD5 for model text_model at /home/richel/m3/models/text_model.mdl
03/30/2026 21:25:38 - INFO - m3inference.utils -   MD5s match.
03/30/2026 21:25:38 - INFO - m3inference.m3inference -   Loaded pretrained weight at /home/richel/m3/models/text_model.mdl
03/30/2026 21:25:38 - INFO - m3inference.dataset -   644 data entries loaded.
Predicting...:   0%|                                                 | 0/41 [00:00<?, ?it/s]/home/richel/.local/lib/python3.12/site-packages/torch/utils/data/dataloader.py:1118: UserWarning: 'pin_memory' argument is set as true but no accelerator is found, then device pinned memory won't be used.
  super().__init__(loader)
Predicting...: 100%|████████████████████████████████████████| 41/41 [00:04<00:00,  9.24it/s]
03/30/2026 21:25:43 - WARNING - m3inference.m3inference -   ID 939763274823987200 already exists. Please double-check the input data. Skipping for now...
03/30/2026 21:25:43 - WARNING - m3inference.m3inference -   ID 939763274823987200 already exists. Please double-check the input data. Skipping for now...
03/30/2026 21:25:43 - WARNING - m3inference.m3inference -   ID 190195939 already exists. Please double-check the input data. Skipping for now...
03/30/2026 21:25:43 - WARNING - m3inference.m3inference -   ID 190195939 already exists. Please double-check the input data. Skipping for now...
03/30/2026 21:25:43 - WARNING - m3inference.m3inference -   ID 49568716 already exists. Please double-check the input data. Skipping for now...

real	0m6.713s
user	0m55.083s
sys	0m1.932s
```


## Scribbles

```
json.decoder.JSONDecodeError: Expecting ',' delimiter: line 1 column 40 (char 39)

real	0m2.206s
user	0m2.489s
sys	0m1.617s
richel@richel-latitude-7430:~/GitHubs/twitter_inference$ cat temp_stop_the_steal.jsonl | head -n 2179 | tail -n 1 > intermediate/stop_the_steal.jsonl
```

```
richel@richel-latitude-7430:~/GitHubs/twitter_inference$ cat temp_stop_the_steal.jsonl | head -n 2179 | tail -n 1 
{"id": "237829375", "name": "Pasquale "Pat" Scopelliti", "screen_name": "ThyConsigliori", "description": "At CloutHub, Gab, Parler, and Telegram I am @ThyConsigliori, same as here. A new plan of #MAGAaction is needed. Together, let's write and execute that new plan!", "lang": "en", "img_path": "data/ThyConsigliori.jpg"}
```

Aha:

```
"name": "Pasquale "Pat" Scopelliti"
```

Need to remove quotes from names!
