#!/bin/bash

function run_ner_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=layers-ner-ontonotes, \
    bert_model_name=bert-large-uncased, \
    exp_name=bert_hotpot_ner_layer_$1, \
    bert_embedding_layer=$1, \
    bert_model_file=/data_dir/bert_models/hotpot_small_distract/pytorch_model.bin"
}

function run_coref_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=layers-coref-ontonotes, \
    bert_model_name=bert-large-uncased, \
	exp_name=bert_hotpot_ner_layer_$1, \
    bert_embedding_layer=$1, \
    bert_model_file=/data_dir/bert_models/hotpot_small_distract/pytorch_model.bin"
}

function run_rel_semeval_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=edges-rel-semeval, \
    bert_model_name=bert-large-uncased, \
	exp_name=bert_hotpot_rel_layer_$1, \
    bert_embedding_layer=$1, \
    max_epochs=5, \
    bert_model_file=/data_dir/bert_models/hotpot_small_distract/pytorch_model.bin"
}

# for i in 1 3 5 7 9 11 13 15 17 19 21 23
# do
#    run_ner_task $i
# done

# for j in 1 3 5 7 9 11 13 15 17 19 21 23
# do
#    run_coref_task $j
# done

for j in 1 3 5 7 9 11 13 15 17 19 21 23
do
   run_rel_semeval_task $j
done