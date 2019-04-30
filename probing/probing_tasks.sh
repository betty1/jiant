#!/bin/bash

function run_ner_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=layers-ner-ontonotes, \
    bert_embedding_layer=$1, \
    bert_model_name=$2, \
    bert_model_file=$3, \
    exp_name=bert_ner_layer_$1_$4, \
    max_epochs=10"
}

function run_coref_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=layers-coref-ontonotes, \
    bert_embedding_layer=$1, \
    bert_model_name=$2, \
    bert_model_file=$3, \
    exp_name=bert_coref_layer_$1_$4, \
    max_epochs=10"
}

function run_rel_semeval_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=edges-rel-semeval, \
    bert_embedding_layer=$1, \
    bert_model_name=$2, \
    bert_model_file=$3, \
    exp_name=bert_rel_layer_$1_$4, \
    max_epochs=10"
}

function ner_hotpot_layers() {
    BERT_TYPE="bert-large-uncased"
    MODEL_FILE="/data_dir/bert_models/hotpot_small_distract/pytorch_model.bin"
    EXP_SUFFIX="hotpot"
    for i in 0 2 4 6 8 10 12 14 16 18 20 22 23
    do
       run_ner_task $i $BERT_TYPE $MODEL_FILE $EXP_SUFFIX
    done
}

function coref_hotpot_layers() {
    BERT_TYPE="bert-large-uncased"
    MODEL_FILE="/data_dir/bert_models/hotpot_small_distract/pytorch_model.bin"
    EXP_SUFFIX="hotpot"
    for i in {0..23}
    do
       run_coref_task $i $BERT_TYPE $MODEL_FILE $EXP_SUFFIX
    done
}

if [ $1 == 'ner_hotpot_layers' ]
then
ner_hotpot_layers
fi

if [ $1 == 'coref_hotpot_layers' ]
then
coref_hotpot_layers
fi