#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "usage: $0 /path/to/continuous_trajectory_rgbd_with_gt.mp4" >&2
  exit 2
fi

input="$1"
output_dir="docs/media"
mkdir -p "$output_dir"

ffmpeg -hide_banner -loglevel error -y \
  -i "$input" -an \
  -vf "setpts=PTS/3,scale=1280:-2" \
  -r 30 -c:v libx264 -crf 25 -preset medium -movflags +faststart \
  "$output_dir/continuous_trajectory_rgbd_with_gt_3x.mp4"

ffmpeg -hide_banner -loglevel error -y \
  -ss 55 -i "$input" -an \
  -vf "setpts=PTS/3,scale=960:-2,fps=8" \
  -t 18 -loop 0 \
  "$output_dir/continuous_trajectory_rgbd_with_gt_3x_preview.gif"
