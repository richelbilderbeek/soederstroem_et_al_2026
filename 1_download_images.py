#!/bin/env python
import requests
import urllib.request
import urllib.parse

bearer_token = open('bearer_token', 'r').read().strip()

print("bearer_token: ", bearer_token)
usernames_file = 'missing_profile_pictures.txt'

with open(usernames_file, 'r') as f:
    usernames = [line.strip() for line in f if line.strip()]

for username in usernames:
    print("username: ", username)
    url = f'https://api.x.com/2/users/by?usernames={urllib.parse.quote(username)}&user.fields=profile_image_url'
    headers = {'Authorization': f'Bearer {bearer_token}'}
    resp = requests.get(url, headers=headers).json()
    if 'data' in resp and resp['data']:
        img_url = resp['data'][0]['profile_image_url']
        urllib.request.urlretrieve(img_url, f'{username}.jpg')
