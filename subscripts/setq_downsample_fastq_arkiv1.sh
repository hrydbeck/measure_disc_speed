#!/bin/bash

/home/servicengs/bin/seqtk/seqtk \
sample -s100 "${arkiv1_inputdir}/Execute_write_test_hal/fastq/12877_1_S3_R1_001.fastq.gz" \
10000 > "${arkiv1_inputdir}/Execute_write_test_hal/Test1_downsampling/12877_1_S3_R1_001_10k.fastq.gz"