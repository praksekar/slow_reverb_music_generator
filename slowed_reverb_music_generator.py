#!/usr/bin/env python3

import sys
import json
import requests

spotify_json = json.loads(sys.argv[1])
youtube_urls = []
track_info = {}


# Gets track_info, dictionary with track keys and artist values
for track in spotify_json["items"]:
    artists_per_track = ""
    for artist in track["artists"]:
        artists_per_track += str(artist["name"]) + " "
    track_info.update({track["name"].replace('%', '').replace('/', '').replace(
        '&', ''): artists_per_track.replace('%', '').replace('/', '').replace('&', '')})


# Gets youtube URLs for first result found on youtube with search query of track and artist names
for key in track_info:
    try:
        youtube_link = 'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=1&q=' + str(key) + ' ' + str(track_info[key]) + '&key={YOUTUBE API KEY HERE}'
        youtube_json = json.loads((requests.get(youtube_link)).content)
        youtube_urls.append('https://www.youtube.com/watch?v=' + str(youtube_json["items"][0]["id"]["videoId"]))
    except:
        pass


# print each URL on new line
for link in youtube_urls:
    print(link)
