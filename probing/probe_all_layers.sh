#!/bin/bash

function run_task(layer) {

    python -u ../main.py --config_file ../config/edgeprobe_bert_babi.conf -o \
    "target_tasks=layers-ner-ontonotes,exp_name=bert_babi_ner_layer_$layer,layer=$layer"
}

for i in 1 10
do
   run_task($i)
done

