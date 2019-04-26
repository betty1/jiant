#!/bin/bash

function run_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_babi.conf -o \
    "target_tasks=layers-ner-ontonotes,exp_name=bert_babi_ner_layer_$1,bert_embedding_layer=$1"
}

for i in 1 10
do
   run_task $i
done

