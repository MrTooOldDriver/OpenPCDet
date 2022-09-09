# sbatch -N 1 -n 1 --mem=16000 --nodelist=damnii07 \
sbatch -N 1 -n 1 --mem=16000 \
--time 12:00:00 \
--cpus-per-task=8 \
--gres=gpu:4 \
--partition=PGR-Standard \
--output=/home/%u/slurm_logs/slurm-%A_%a.out \
--error=/home/%u/slurm_logs/slurm-%A_%a.out \
cluster_job_submit.sh