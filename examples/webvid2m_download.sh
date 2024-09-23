#!/bin/bash
echo $CUDA_VISIBLE_DEVICES
echo $SLURM_NODELIST
echo $SLURM_NODEID

video2dataset --url_list={input_url_path} \
        --input_format="csv" \
        --output_format="webdataset" \
	--output_folder={output_path} \
        --url_col="contentUrl" \
        --caption_col="name" \
        --save_additional_columns='[videoid,page_idx,page_dir,duration]' \
        --enable_wandb=True \
	--config='{home_dir}/webvid2m_download/examples/webvid2m_slurm.yaml' \
        --incremental_mode="incremental" \
        --tmp_dir={tmp_dir}

# video2dataset --url_list="/scratch2/jisoo6687/video_distill/datasets/webvid-2m/webvid-2m/results_2M_train_4/3.csv" \
#         --input_format="csv" \
#         --output_format="webdataset" \
# 	--output_folder="/MIR_NAS/video_dataset/webvid-2m_new/shard3" \
#         --url_col="contentUrl" \
#         --caption_col="name" \
#         --save_additional_columns='[videoid,page_idx,page_dir,duration]' \
#         --enable_wandb=True \
# 	--config='/home/jisoo6687/video2dataset/examples/default_slurm.yaml' \
#         --incremental_mode incremental \
#         --tmp_dir /MIR_NAS/video_dataset/webvid-2m/shard0/_tmp

# sbatch --qos=cpu_qos --partition=dell_cpu --job-name=web3 --cpus-per-task=8 download_webvid.sh