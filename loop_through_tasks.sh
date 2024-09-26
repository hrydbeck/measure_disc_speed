#!/bin/bash

server_calling_script_from="plato"
# server_calling_script_from="d-ngsmgm2"
input_file_local_path="/Execute_write_test_hal/fastq/12877_1_S3_R1_001.fastq.gz"

# Tasks to perform
tasks="copy_fastq setq_downsample_fastq" # unzip_fastq_gz 

# Discs to compare
mounted_discs="arkiv1 arkiv2 instrtmp"

for task in $tasks; do
    for mounted_disc in $mounted_discs; do
        task_and_disc="${task}_${mounted_disc}"
        echo sudo bash measure_discspeed.sh $task_and_disc $server_calling_script_from $mounted_disc $input_file_local_path
        sudo bash measure_discspeed.sh $task_and_disc $server_calling_script_from $mounted_disc $input_file_local_path
    done
done