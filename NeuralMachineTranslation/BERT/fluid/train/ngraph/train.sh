#!/bin/bash

set -xe

export OMP_NUM_THREADS=$(nproc)
export KMP_AFFINITY=granularity=fine,compact,1,0

# go to your BERT directory
cd ./LARK_PADDLE_BERT/BERT

# pretrain config
SAVE_STEPS=10000
BATCH_SIZE=8
LR_SCHEDULER=noam_decay
LR_RATE=1e-4
WEIGHT_DECAY=0.01
MAX_LEN=128
TRAIN_DATA_DIR=data/train
VALIDATION_DATA_DIR=data/validation
CONFIG_PATH=data/demo_config/bert_config.json
VOCAB_PATH=data/demo_config/vocab.txt

# Change your train arguments:
FLAGS_use_ngraph=true python -u ./train.py \
        --is_distributed false\
        --use_cuda false\
        --weight_sharing true\
        --batch_size ${BATCH_SIZE} \
        --data_dir ${TRAIN_DATA_DIR} \
        --validation_set_dir ${VALIDATION_DATA_DIR} \
        --bert_config_path ${CONFIG_PATH} \
        --vocab_path ${VOCAB_PATH} \
        --generate_neg_sample true\
        --checkpoints ./output \
        --save_steps ${SAVE_STEPS} \
        --lr_scheduler ${LR_SCHEDULER} \
        --learning_rate ${LR_RATE} \
        --weight_decay ${WEIGHT_DECAY:-0} \
        --max_seq_len ${MAX_LEN} \
        --skip_steps 20 \
        --validation_steps 1000 \
        --num_iteration_per_drop_scope 10 \
        --in_token false\
        --use_fp16 false \
        --loss_scaling 8.0
