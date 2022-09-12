#!/bin/bash

set -x

PARTITION=PGR-Standard
JOB_NAME=pvrcnn
GPUS=1
CONFIG_FILE=./cfgs/kitti_models/pv_rcnn_vod.yaml

GPUS_PER_NODE=${GPUS_PER_NODE:-1}
CPUS_PER_TASK=${CPUS_PER_TASK:-5}
SRUN_ARGS=${SRUN_ARGS:-""}

while true
do
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $PORT < /dev/null &>/dev/null; echo $?)"
    if [ "${status}" != "0" ]; then
        break;
    fi
done
echo $PORT

srun -p ${PARTITION} \
    --time 08:00:00 \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    --ntasks=${GPUS} \
    --ntasks-per-node=${GPUS_PER_NODE} \
    --cpus-per-task=${CPUS_PER_TASK} \
    --kill-on-bad-exit=1 \
    --output=/home/%u/slurm_logs/slurm-%A_%a.out \
    --error=/home/%u/slurm_logs/slurm-%A_%a.out \
    ${SRUN_ARGS} \
    ./copy_dataset_single.sh $PORT --cfg_file ${CONFIG_FILE}
