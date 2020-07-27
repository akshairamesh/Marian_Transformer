#!/bin/bash

# model prefix
prefix=model1/model.npz

SL=en
TL=de

dev=corpus/devset.BPE.$SL
ref=corpus/devset.$TL

pref=spinning-storage/rameshak

iter=`grep batches: ${prefix}.progress.yml | cut -f2 -d' '`
cp $1 $1.$iter

# decode

cat $1 \
      |  perl -pane 's/@@( |$)//g' \
      | /home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref \
      | sed -r 's/BLEU = ([0-9.]+),.*/\1/'


