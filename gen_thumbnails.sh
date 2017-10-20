#!/bin/bash

# Given a video file, extract its I-frames to thmbs/*.jpeg

video="$1"
[[ $# -ne 1 ]] && echo "Usage: $0  ‹Path to a video file›" && exit 1

function gen_thumbnails() {
    #TODO: try passthrough, instead of vfr
    ## Should be guessed from ".jpeg", at image2
    ffmpeg -i "$1" \
           -filter:v select='eq(pict_type\,I)' \
           -vsync vfr \
           -f image2 \
           %06d.jpeg
}

function get_frames_info() {
    ffprobe -select_streams v \
            -show_frames \
            "$1" \
            > _
}


mkdir -p "$dir"
pushd "$dir"

set -e
gen_thumbnails "$video"
get_frames_info "$video"
./chaptrs.py _ > __

popd
