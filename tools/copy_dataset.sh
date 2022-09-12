#!/bin/bash

PORT=$1
PY_ARGS=${@:2}

echo "Job running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo "Setting up bash enviroment"
source ~/.bashrc
set -e
SCRATCH_DISK=/disk/scratch_big
SCRATCH_HOME=${SCRATCH_DISK}/${USER}
mkdir -p ${SCRATCH_HOME}
CONDA_ENV_NAME=openpcdet
echo "Activating conda environment: ${CONDA_ENV_NAME}"
conda activate ${CONDA_ENV_NAME}
echo "Moving input data to the compute node's scratch space: $SCRATCH_DISK"
repo_home=/home/${USER}/OpenPCDet
src_path=/home/${USER}/dataset/view_of_delft_PUBLIC
dest_path=${SCRATCH_HOME}/view_of_delft_PUBLIC
mkdir -p ${dest_path}
rsync --archive --update --compress --progress ${src_path}/ ${dest_path}
echo "Start train"
python -u train.py --launcher slurm --tcp_port $PORT ${PY_ARGS}