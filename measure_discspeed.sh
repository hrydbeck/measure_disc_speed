#!/bin/bash

# https://unix.stackexchange.com/questions/27013/displaying-seconds-as-days-hours-mins-seconds
# https://stackoverflow.com/questions/5152858/how-do-i-measure-duration-in-seconds-in-a-shell-script


task=$1
script_top_be_called=${task}.sh
echo_script_to_be_called="echo_"${script_top_be_called}


computer=$2
mounted_disc=$3
input_file_local_path=$4

echo ""
echo ""
echo "task is: $task"
echo "computer is: $computer"
echo "mounted disc is: $mounted_disc"
echo "input file is: $input_file_local_path"
echo ""
echo ""

# Decide spelling of networkdiskname (differs depenging on how they where named when mounted)
# if d-ngsmgm2
if [ $computer == "d-ngsmgm2" ]
then
  arkiv1_inputdir="/mnt/Arkiv01"
  arkiv2_inputdir="/mnt/Arkiv02"
  inst_temp_inputdir="/mnt/InstrTemp/8_Bioinf/Halfdan_instTemp/Laboratoriemedicin/Precisions_medicinskt_laboratorium/Computational_resources/compare_disc_speeds"
  # print input file name
  if [ $mounted_disc == "arkiv1" ]
  then
    inp_fn=${arkiv1_inputdir}${input_file_local_path}
    work_dir=${arkiv1_inputdir}

    # Make sure outputfolders are empty (in case it affects copy speed?)
    # at arkiv2
    # https://superuser.com/questions/392872/delete-files-with-regular-expression
    echo "removing previos output if existing"
    sudo rm "${arkiv1_inputdir}/Execute_write_test_hal/Test1_downsampling"/* 
    sudo rm "${arkiv1_inputdir}/Execute_write_test_hal/Test2_for_loop"/* 
    sudo rm "${arkiv1_inputdir}/Execute_write_test_hal/Test3_copy"/*
  elif [ $mounted_disc == "arkiv2" ]
  then
    inp_fn=${arkiv2_inputdir}${input_file_local_path}
    work_dir=${arkiv2_inputdir}

    # Make sure outputfolders are empty (in case it affects copy speed?)
    # at arkiv2
    # https://superuser.com/questions/392872/delete-files-with-regular-expression
    echo "removing previos output if existing"
    sudo rm "${arkiv2_inputdir}/Execute_write_test_hal/Test1_downsampling"/* 
    sudo rm "${arkiv2_inputdir}/Execute_write_test_hal/Test2_for_loop"/* 
    sudo rm "${arkiv2_inputdir}/Execute_write_test_hal/Test3_copy"/*

  elif [ $mounted_disc == "instrtmp" ]
  then
    inp_fn=${inst_temp_inputdir}${input_file_local_path}
    work_dir=${inst_temp_inputdir}
    # Make sure outputfolders are empty (in case it affects copy speed?)
    # at insttmp
    echo "removing previos output if existing"
    sudo rm "${inst_temp_inputdir}/Execute_write_test/Test1_downsampling"/*
    sudo rm "${inst_temp_inputdir}/Execute_write_test/Test2_for_loop"/*
    sudo rm "${inst_temp_inputdir}/Execute_write_test/Test3_copy"/*
  else 
    echo "did not give valid name of the mounted_disc d-ngsmgm2" 
  fi
# else if plato
elif [ $computer == "plato" ]
then
  arkiv1_inputdir="/mnt/arkiv01"
  arkiv2_inputdir="/mnt/arkiv02"
  inst_temp_inputdir="/mnt/ngsInstr/8_Bioinf/Halfdan_instTemp/Laboratoriemedicin/Precisions_medicinskt_laboratorium/Computational_resources/compare_disc_speeds"
  
  # print input file name
  if [ $mounted_disc == "arkiv1" ]
  then
    inp_fn=${arkiv1_inputdir}/${input_file_local_path}
    work_dir=${arkiv1_inputdir}

    # Make sure outputfolders are empty (in case it affects copy speed?)
    # at arkiv1
    echo "removing previos output if existing"
    sudo rm "${arkiv1_inputdir}/Execute_write_test_hal/Test1_downsampling"/*
    sudo rm "${arkiv1_inputdir}/Execute_write_test_hal/Test2_for_loop"/*
    sudo rm "${arkiv1_inputdir}/Execute_write_test_hal/Test3_copy"/*
  elif [ $mounted_disc == "arkiv2" ]
  then
    inp_fn=${arkiv2_inputdir}/${input_file_local_path}
    work_dir=${arkiv2_inputdir}

    # Make sure outputfolders are empty (in case it affects copy speed?)
    # at arkiv2
    echo "removing previos output if existing"
    sudo rm "${arkiv2_inputdir}/Execute_write_test_hal/Test1_downsampling"/*
    sudo rm "${arkiv2_inputdir}/Execute_write_test_hal/Test2_for_loop"/*
    sudo rm "${arkiv2_inputdir}/Execute_write_test_hal/Test3_copy"/*
  elif [ $mounted_disc == "instrtmp" ]
  then
    inp_fn=${inst_temp_inputdir}/${input_file_local_path}
    work_dir=${inst_temp_inputdir}
    # Make sure outputfolders are empty (in case it affects copy speed?)
    # at insttmp
    echo "removing previos output if existing"
    sudo rm "${inst_temp_inputdir}/Execute_write_test_hal/Test1_downsampling"/*
    sudo rm "${inst_temp_inputdir}/Execute_write_test_hal/Test2_for_loop"/*
    sudo rm "${inst_temp_inputdir}/Execute_write_test_hal/Test3_copy"/*

  else 
    echo "did not give valid name of the mounted_disc" 
  fi
else 
  echo "did not give valid computer name" 
fi



echo "Path to working directory is ${work_dir}"

# Echo the script that will be run



echo ""
echo ""
# echo "The working directory is:"
# echo ${arkiv2_inputdir}
echo "The script that is called is: "
source "subscripts/echo/${echo_script_to_be_called}"
echo ""
echo ""

# Capturing start time in seconds

start_time=$SECONDS

# Performing a task

echo source "subscripts/${script_top_be_called}"

source "subscripts/${script_top_be_called}"
echo "$arkiv2_inputdir"

echo "Script to be called is: ${script_top_be_called}"

# Calculating elapsed time in seconds
time_in_seconds=$(($SECONDS - $start_time))

# Displaying elapsed time in seconds
echo "Elapsed time (seconds) running ${script_top_be_called}: ${time_in_seconds} s" # 

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

timepoint_for_measuremnt=$(date +"%Y_%m_%d_%H_%M")


filesize=$(stat -c%s "$inp_fn" | numfmt --to=iec)

# Write to log file

echo "# $task" > "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
echo "Size of input:" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
echo "$inp_fn = $filesize bytes." >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
echo "" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"

echo "At $timepoint_for_measuremnt" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
echo "it took:" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
displaytime $time_in_seconds >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
echo "" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"

echo "To run:" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
sh "subscripts/echo/echo_${script_top_be_called}" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
echo "" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
echo "The working directory is ${work_dir}" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
echo "" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"
echo "" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"

echo "" >> "./logs/${timepoint_for_measuremnt}_measure_discspeed_${task}.log"


# Storing data in table cumulatively
duration=$(displaytime $time_in_seconds)

if [ ! -f ./logs/measure_discspeed.csv ]; then
    echo "disc;filesize;task;date;duration;duration_secs" > "./logs/measure_discspeed.csv"
    echo "$mounted_disc;$filesize;$task;$timepoint_for_measuremnt;$duration;$time_in_seconds" >> "./logs/measure_discspeed.csv"

else 
  echo "$mounted_disc;$filesize;$task;$timepoint_for_measuremnt;$duration;$time_in_seconds" >> "./logs/measure_discspeed.csv"
fi



displaytime $time_in_seconds