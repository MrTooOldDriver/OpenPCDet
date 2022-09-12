#!/bin/bash

set -x

PARTITION=PGR-Standard
JOB_NAME=pvrcnn
GPUS=2
CONFIG_FILE=./cfgs/kitti_models/pv_rcnn_vod.yaml

while true
do
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $PORT < /dev/null &>/dev/null; echo $?)"
    if [ "${status}" != "0" ]; then
        break;
    fi
done
echo $PORT

sbatch -p ${PARTITION} \
    --job-name=${JOB_NAME} \
    --time 08:00:00 \
    -N 1 \
    -n 4 \
    --gres=gpu:4 \
    --cpus-per-task=5 \
    --output=/home/%u/slurm_logs/slurm-%A_%a.out \
    --error=/home/%u/slurm_logs/slurm-%A_%a.out \
    ./copy_dataset_sbatch.sh $PORT --cfg_file ${CONFIG_FILE}
