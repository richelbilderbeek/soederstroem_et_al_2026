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

[Using this GitHub repository](https://github.com/sinugrepo/x_profile_downloader)
is easy. 50 at a time though ...

## Running

```
./run.py
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
