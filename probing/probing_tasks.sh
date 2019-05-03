#!/bin/bash

function run_ner_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=layers-ner-ontonotes, \
    bert_embedding_layer=$1, \
    bert_model_name=$2, \
    bert_model_file=$3, \
    bert_classification=$5, \
    exp_name=bert_$4_ner_layer_$1, \
    max_epochs=10"
}

function run_coref_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=layers-coref-ontonotes, \
    bert_embedding_layer=$1, \
    bert_model_name=$2, \
    bert_model_file=$3, \
    bert_classification=$5, \
    exp_name=bert_$4_coref_layer_$1, \
    max_epochs=10"
}

function run_rel_semeval_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=edges-rel-semeval, \
    bert_embedding_layer=$1, \
    bert_model_name=$2, \
    bert_model_file=$3, \
    bert_classification=$5, \
    exp_name=bert_$4_rel_layer_$1, \
    max_epochs=10"
}

function run_qtype_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=layers-qtype-trec, \
    bert_embedding_layer=$1, \
    bert_model_name=$2, \
    bert_model_file=$3, \
    bert_classification=$5, \
    exp_name=bert_$4_qtype_layer_$1, \
    max_epochs=10"
}

function run_sup_babi2_task() {

    python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
    "target_tasks=layers-sup-babi2, \
    bert_embedding_layer=$1, \
    bert_model_name=$2, \
    bert_model_file=$3, \
    bert_classification=$5, \
    exp_name=bert_$4_sup_babi2_layer_$1, \
    max_epochs=10"
}

function qtype_hotpot() {
    BERT_TYPE="bert-large-uncased"
    MODEL_FILE="/data_dir/bert_models/hotpot_small_distract/pytorch_model.bin"
    EXP_NAME="hotpot"
    for i in {0..23}
    do
       run_qtype_task $i $BERT_TYPE $MODEL_FILE $EXP_NAME 0
    done
}

function qtype_nofinetune_base() {
    BERT_TYPE="bert-base-uncased"

    for i in {0..11}
    do
        python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
        "target_tasks=layers-qtype-trec, \
        bert_embedding_layer=$i, \
        bert_model_name=$BERT_TYPE, \
        exp_name=bert_nofinetune_base_qtype_layer_$i, \
        max_epochs=10"
    done
}

function qtype_nofinetune_large() {
    BERT_TYPE="bert-large-uncased"

    for i in {0..23}
    do
        python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
        "target_tasks=layers-qtype-trec, \
        bert_embedding_layer=$i, \
        bert_model_name=$BERT_TYPE, \
        exp_name=bert_nofinetune_large_qtype_layer_$i, \
        max_epochs=10"
    done
}

function sup_babi2_nofinetune_base() {
    BERT_TYPE="bert-base-uncased"

    for i in {0..11}
    do
        python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
        "target_tasks=layers-sup-babi2, \
        bert_embedding_layer=$i, \
        bert_model_name=$BERT_TYPE, \
        exp_name=bert_nofinetune_sup_babi2_layer_$i, \
        max_epochs=10"
    done
}

function sup_babi2_nofinetune_large() {
    BERT_TYPE="bert-large-uncased"

    for i in {0..23}
    do
        python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
        "target_tasks=layers-sup-babi2, \
        bert_embedding_layer=$i, \
        bert_model_name=$BERT_TYPE, \
        exp_name=bert_nofinetune_large_sup_babi2_layer_$i, \
        max_epochs=10"
    done
}

function sup_babi2_babi() {
    BERT_TYPE="bert-base-uncased"
    MODEL_FILE="/data_dir/bert_models/babi/qa21_base/pytorch_model.bin"
    EXP_NAME="babi"
    for i in {0..11}
    do
       run_sup_babi2_task $i $BERT_TYPE $MODEL_FILE $EXP_NAME 1
    done
}

function sup_babi2_hotpot() {
    BERT_TYPE="bert-large-uncased"
    MODEL_FILE="/data_dir/bert_models/hotpot_small_distract/pytorch_model.bin"
    EXP_NAME="hotpot"
    for i in {0..23}
    do
       run_sup_babi2_task $i $BERT_TYPE $MODEL_FILE $EXP_NAME 0
    done
}

function ner_babi() {
    BERT_TYPE="bert-base-uncased"
    MODEL_FILE="/data_dir/bert_models/babi/qa21_base/pytorch_model.bin"
    EXP_NAME="babi"
    for i in {0..11}
    do
       run_ner_task $i $BERT_TYPE $MODEL_FILE $EXP_NAME 1
    done
}

function coref_babi_layers() {
    BERT_TYPE="bert-base-uncased"
    MODEL_FILE="/data_dir/bert_models/babi/qa21_base/pytorch_model.bin"
    EXP_NAME="babi"
    for i in {0..11}
    do
       run_coref_task $i $BERT_TYPE $MODEL_FILE $EXP_NAME 1
    done
}

function rel_babi_layers() {
    BERT_TYPE="bert-base-uncased"
    MODEL_FILE="/data_dir/bert_models/babi/qa21_base/pytorch_model.bin"
    EXP_NAME="babi"
    for i in {0..11}
    do
       run_rel_semeval_task $i $BERT_TYPE $MODEL_FILE $EXP_NAME 1
    done
}

function ner_nofinetune_large() {
    BERT_TYPE="bert-large-uncased"

    for i in {0..23}
    do
        python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
        "target_tasks=layers-ner-ontonotes, \
        bert_embedding_layer=$i, \
        bert_model_name=$BERT_TYPE, \
        exp_name=bert_nofinetune_ner_layer_$i, \
        max_epochs=10"
    done
}

function coref_nofinetune_large() {
    BERT_TYPE="bert-large-uncased"

    for i in {0..23}
    do
        python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
        "target_tasks=layers-coref-ontonotes, \
        bert_embedding_layer=$i, \
        bert_model_name=$BERT_TYPE, \
        exp_name=bert_nofinetune_coref_layer_$i, \
        max_epochs=10"
    done
}

function rel_nofinetune_base() {
    BERT_TYPE="bert-base-uncased"

    for i in {0..11}
    do
        python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
        "target_tasks=edges-rel-semeval, \
        bert_embedding_layer=$i, \
        bert_model_name=$BERT_TYPE, \
        exp_name=bert_base_nofinetune_rel_layer_$i, \
        max_epochs=10"
    done
}

function ner_nofinetune_base() {
    BERT_TYPE="bert-base-uncased"

    for i in {0..11}
    do
        python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
        "target_tasks=layers-ner-ontonotes, \
        bert_embedding_layer=$i, \
        bert_model_name=$BERT_TYPE, \
        exp_name=bert_base_nofinetune_ner_layer_$i, \
        max_epochs=10"
    done
}

function coref_nofinetune_base() {
    BERT_TYPE="bert-base-uncased"

    for i in {0..11}
    do
        python -u /app/main.py --config_file /app/config/edgeprobe_bert_finetuned.conf -o \
        "target_tasks=layers-coref-ontonotes, \
        bert_embedding_layer=$i, \
        bert_model_name=$BERT_TYPE, \
        exp_name=bert_base_nofinetune_coref_layer_$i, \
        max_epochs=10"
    done
}

### check layer 5:
if [ $1 == 'rel_babi_layers' ]
then
rel_babi_layers
fi

### running:

if [ $1 == 'coref_babi_layers' ]
then
coref_babi_layers
fi

if [ $1 == 'coref_nofinetune_large' ]
then
coref_nofinetune_large
fi

if [ $1 == 'ner_nofinetune_large' ]
then
ner_nofinetune_large
fi

if [ $1 == 'sup_babi2_babi' ]
then
sup_babi2_babi
fi

### to be done

if [ $1 == 'ner_babi' ]
then
ner_babi
fi

if [ $1 == 'qtype_hotpot' ]
then
qtype_hotpot
fi

if [ $1 == 'qtype_nofinetune_base' ]
then
qtype_nofinetune_base
fi

if [ $1 == 'qtype_nofinetune_large' ]
then
qtype_nofinetune_large
fi

if [ $1 == 'sup_babi2_hotpot' ]
then
sup_babi2_hotpot
fi

if [ $1 == 'sup_babi2_nofinetune_base' ]
then
sup_babi2_nofinetune_base
fi

if [ $1 == 'sup_babi2_nofinetune_large' ]
then
sup_babi2_nofinetune_large
fi

if [ $1 == 'rel_nofinetune_base' ]
then
rel_nofinetune_base
fi

if [ $1 == 'ner_nofinetune_base' ]
then
ner_nofinetune_base
fi

if [ $1 == 'coref_nofinetune_base' ]
then
coref_nofinetune_base
fi

