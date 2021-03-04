#!/bin/bash

SPOTIFY_ACCESS_TOKEN=$(curl -s -S -X "POST" -H "Authorization: Basic {YOUR SPOTIFY API KEY HERE}" -d grant_type=client_credentials https://accounts.spotify.com/api/token | jq -r '.access_token')

SEARCH_QUERY=$(echo "$1" | sed -e 's/ /%20/g')

FIND_ALBUM_JSON=$(curl -s -S -X GET "https://api.spotify.com/v1/search?q=$SEARCH_QUERY&type=album" -H "Authorization: Bearer $SPOTIFY_ACCESS_TOKEN" | jq -r '.albums | .items | .[0]')

ALBUM_ID=$(echo $FIND_ALBUM_JSON | jq -r '.id')

ALBUM_NAME=$(echo $FIND_ALBUM_JSON | jq -r '.name')

SPOTIFY_JSON=$(curl -s -S -H "Authorization: Bearer $SPOTIFY_ACCESS_TOKEN" https://api.spotify.com/v1/albums/$ALBUM_ID/tracks) 

cd {DIRECTORY TO PUT MUSIC FOLDERS}
mkdir "$(echo $ALBUM_NAME | sed -e 's/ //g')"
cd "$(echo $ALBUM_NAME | sed -e 's/ //g')"

{PATH TO PYTHON SCRIPT} "$SPOTIFY_JSON" | while read line;
do
    youtube-dl --min-views 5000 --max-filesize 50m --extract-audio --audio-format mp3 "$line"
done

ls | while read line; do
    ffmpeg -i $line -filter:a "atempo=2.0" -vn "slowed_$line"
done



