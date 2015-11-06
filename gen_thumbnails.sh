#!/bin/bash

# Given a video file, extract its I-frames to thmbs/*.jpeg

$video="$1"
[[ $# -ne 1 ]] && echo "Usage: $0  ‹Path to a video file›" && exit 1

function gen_thumbnails() {
    local dir="$1"
    local video="$2"

    mkdir -p "$dir"
    pushd "$dir"

    ffmpeg -i "$video" \
           -filter:v select='eq(pict_type\,I)' \
           -vsync vfr \ #TODO: try passthrough
           -f image2 \ ## Should be guessed from ".jpeg"
           %06d.jpeg
    ret=$?

    popd
    return $ret
}

gen_thumbnails thmbs "$1"
