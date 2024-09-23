# video2dataset

## Install

```bash
git clone https://github.com/jiiiisoo/webvid2m_download.git
cd webvid2m_download
pip install -e .
```

## Run

```bash
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
```
If you go into the output folder you should see a nice small video dataset stored with all relevant metadata.


## Output format

The tool will automatically download the urls and store them with the format:

```
output-folder
 ├── 00000{.ext if output_format != files, can be tar, parquet, tfrecord, etc.}
 |     ├── 00000.mp4
 |     ├── 00000.txt
 |     ├── 00000.json
 |     ├── 00001.mp4
 |     ├── 00001.txt
 |     ├── 00001.json
 |     └── ...
 |     ├── 10000.mp4
 |     ├── 10000.txt
 |     ├── 10000.json
 ├── 00001.ext
 |     ├── 10001.mp4
 |     ├── 10001.txt
 |     ├── 10001.json
 │     ...
 ...
```

with each number being the position in the input table or the input sample ID. The subfolders avoid having too many files in a single folder. If **captions** are provided, they will be saved as 0.txt, 1.txt, etc. (matching the ID of the sample they belong to). This can then easily be fed into machine learning training or any other use case.

Also .json files named 0.json, 1.json,... are saved with these keys:
* url
* caption
* key of the form 000010005: the first 5 digits are the shard id, the last 4 are the index in the shard
* additionally gathered metadata (either specified from input table or collected during downloading/processing)
* status: whether the download succeeded
* error_message

Also a .parquet file will be saved with the same name as the subfolder/tar files containing these same metadata.
It can be used to analyze the results efficiently.

.json files will also be saved with the same name suffixed by \_stats, they contain stats collected during downloading (download time, number of success, ...)
