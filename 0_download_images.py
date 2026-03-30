#!/bin/env python
import requests
import urllib.request
import urllib.parse
import os
import random
import shutil

bearer_token = open('bearer_token', 'r').read().strip()

print("bearer_token: ", bearer_token)

usernames_file = 'missing_profile_pictures.txt'

with open(usernames_file, 'r') as f:
    usernames = [line.strip() for line in f if line.strip()]

random.shuffle(usernames) 

for username in usernames:
    #print("username: ", username)
    jpg_file_name = f'data/{username}.jpg'
    #print("jpg_file_name: ", jpg_file_name)
    if not os.path.exists(jpg_file_name):
        url = f'https://api.x.com/2/users/by?usernames={urllib.parse.quote(username)}&user.fields=profile_image_url'
        headers = {'Authorization': f'Bearer {bearer_token}'}
        resp = requests.get(url, headers=headers).json()
        if 'data' in resp and resp['data']:
            img_url = resp['data'][0]['profile_image_url']
            urllib.request.urlretrieve(img_url, jpg_file_name)
        if not os.path.exists(jpg_file_name):
            with open(jpg_file_name, 'w') as fp:
                pass
            print(f"Created an empty file for {username}")
            if not os.path.exists(jpg_file_name):
                print("Huh? I created an empty file!")
        else:
            print(f"Download a profile picture from {username}")
    #else:
    #    print(f"file {username} does already exist, skipping it ...")


