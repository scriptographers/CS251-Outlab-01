#!/bin/bash

# Task 4

# Create required base directories
mkdir -p playlists albums

# Loop around all the songs
for songs in $(ls songs); do
    album=$(head -1 ./songs/${songs})
    mkdir -p ./albums/${album} # Make a directory if it doesn't exist
    ln -sf ../../songs/${songs} ./albums/${album}/${songs}

    playlist_count=$(head -2 ./songs/${songs} | tail -1)
    for playlist in $(tail -${playlist_count} ./songs/${songs}); do
        mkdir -p ./playlists/${playlist}
        ln -sf ../../songs/${songs} ./playlists/${playlist}/${songs}
    done
done
