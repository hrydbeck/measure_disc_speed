#!/bin/bash
start_time=$SECONDS
# sleep 3
#sudo sh 'gzip < "/mnt/Arkiv02/Execute_write_test_hal/Test4_unzip" > "/mnt/Arkiv02/Execute_write_test_hal/fastq/12877_1_S3_R1_001.fastq.gz"'
sudo zcat x.txt.gz > x.txt
#sudo sh -c 'gzip -c < /dev/sdb > /mnt/usbdrive/domoticz.img.gz'
sudo sh 'zcat "/mnt/Arkiv02/Execute_write_test_hal/fastq/12877_1_S3_R1_001.fastq.gz" > "/mnt/Arkiv02/Execute_write_test_hal/Test4_unzip/12877_1_S3_R1_001.fastq"'
# time_in_seconds=$(($SECONDS - $start_time))

#echo "$time_in_seconds"

function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds\n' $S
}

duration=$(displaytime $time_in_seconds)

echo "$duration"
