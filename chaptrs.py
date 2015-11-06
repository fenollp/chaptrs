#!/usr/bin/env python2

import re


def get_timestamps (fn):
    with open(fn, 'r') as fd:
        txt = fd.read()
    newlines = 0
    for i in range(len(txt)):
        if txt[i] is '\n':
            i += 1
    # avg_iframe_count_per_lines_of_ffprobe = 3542
    avg_frame_nls = 25
    all_frames = [] * (newlines / avg_frame_nls)
    curr = []
    for line in txt.split('\n'):
        if   line == '[/FRAME]':
            all_frames.append(curr)
            curr = []
        elif line == '[FRAME]':
            continue
        else:
            curr.append(line)
    avg_iframes_ratio = 142
    i_frames = [] * (len(all_frames) * avg_iframes_ratio)
    for i in range(len(all_frames)):
        frame = all_frames[i]
        if 'pict_type=I' in frame:
            i_frames.append(frame)
    PROP_TS = 'coded_picture_number'
    choosen_iframes = [] * len(i_frames)
    for i in range(len(i_frames)):
        iframe = i_frames[i]
        for j in range(len(iframe)):
            prop = iframe[j]
            if prop.startswith(PROP_TS):
                _, timestamp = prop.split('=')
                print timestamp
                choosen_iframes.append(timestamp)
    return choosen_iframes
