##########################
#Alternatives for tasks (filenmes of subscripts with out .sh)
#########################
# test_transfer
# copy_fastq
# setq_downsample_fastq
# unzip_fastq_gz

##########################
# Mounted discs
#########################
# arkiv1
# arkiv2
# instrtmp

##########################
#Alternatives for server_calling_script_from
#########################
# server_calling_script_from="d-ngsmgm2"
#server_calling_script_fromr="plato"

mounted_disc="arkiv1"
task="setq_downsample_fastq"
task_and_disc="${task}_${mounted_disc}"
server_calling_script_from="d-ngsmgm2"
input_file_local_path="/Execute_write_test_hal/fastq/12877_1_S3_R1_001.fastq.gz"


# task="test_transfer"
#fe=".sh"
#fn="${task}${fe}"

# echo "sudo bash measure_discspeed.sh $task_and_disc $server_calling_script_from"
# echo "task is : ${task}"

sudo bash measure_discspeed.sh $task_and_disc $server_calling_script_from $mounted_disc $input_file_local_path

# sudo bash measure_discspeed.sh $task $fn  | tee "./logs/$(date +"%Y_%m_%d_%H_%M")_measure_discspeed_${task}.log" # "%Y_%m_%d_%I_%M_%p

