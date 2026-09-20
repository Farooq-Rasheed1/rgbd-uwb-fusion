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
  -vf "setpts=0.5*PTS,scale=960:-2" \
  -r 30 -c:v libx264 -crf 26 -preset medium -movflags +faststart \
  "$output_dir/continuous_trajectory_rgbd_with_gt_2x.mp4"

ffmpeg -hide_banner -loglevel error -y \
  -i "$input" -an \
  -vf "setpts=0.5*PTS,scale=480:-2,fps=10" \
  -t 25 -loop 0 \
  "$output_dir/continuous_trajectory_rgbd_with_gt_2x_preview.gif"
