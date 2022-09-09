PARTITION=PGR-Standard
JOB_NAME=pvrcnn
NUM_GPUS=2
CONFIG_FILE=./cfgs/kitti_models/pv_rcnn_vod.yaml
sh scripts/slurm_train.sh ${PARTITION} ${JOB_NAME} ${NUM_GPUS} --cfg_file ${CONFIG_FILE}