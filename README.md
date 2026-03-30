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

DEBUG: use only yttrandefrihet
csv_file_name: data/yttrandefrihet.csv (453 lines)
jsonl_file_name: intermediate/yttrandefrihet.jsonl (69 lines)

real	0m16.829s
user	0m17.879s
sys	0m1.845s


richel@richel-latitude-7430:~/GitHubs/twitter_inference$ time ./1_create_pre_data.R 
DEBUG: use only swexit
csv_file_name: data/swexit.csv (1005 lines)
jsonl_file_name: intermediate/swexit.jsonl (88 lines)

real	0m28.687s
user	0m29.724s
sys	0m1.910s


30 seconds for 1k accounts
Need 1M accounts.
This takes 30 secs/1k accounts * 1M = 500 min = 8.33 hours



richel@richel-latitude-7430:~/GitHubs/twitter_inference$ ./3_only_keep_existing_images.R 
jsonl_file: intermediate/swexit_resized.jsonl
Keeping: 16
Dropping: 72
jsonl_file: intermediate/yttrandefrihet_resized.jsonl
Keeping: 16
Dropping: 53
