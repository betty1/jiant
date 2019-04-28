#!/bin/bash

function run_ner_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_babi.conf -o \
    "target_tasks=layers-ner-ontonotes, \
    exp_name=bert_unfinetuned_ner_layer_$1, \
    bert_embedding_layer=$1"
}

# function run_coref_task() {

#     python -u /app/main.py --config_file /app/config/edgeprobe_bert_babi.conf -o \
#     "target_tasks=layers-coref-ontonotes,exp_name=bert_babi_coref_layer_$1,bert_embedding_layer=$1"
# }

# for i in {0..10}
# do
#    run_ner_task $i
# done

# for j in {0..10}
# do
#    run_coref_task $j
# done

run_ner_task 1