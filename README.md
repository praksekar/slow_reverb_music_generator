# slow_reverb_music_generator
Program that returns slowed and reverbed album based on search query. Utilizes Spotify API to fetch album info, YouTube API to search for song files, youtube-dl to retrieve audio files, and FFMpeg to apply audio effects. 

I decided to make this program because I realized how easy it would be to automate the process of generating the "slow and reverb" genre of music on YouTube with open source command line tools.

Dependencies: curl, youtube-dl, ffmpeg, jq, python3, requests and json pip packages.

To start: enter your Spotify API key, YouTube API key, music destination folder path and Python script folder path where specified in program. Run slowed_reverb_music_generator.sh with your desired album search query as the first argument.

