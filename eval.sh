#!/bin/bash

prefix=model1/model.npz
pref=spinning-storage/rameshak
marian=/home/rameshak/$pref/software/marian

SL=en
TL=de

tes=corpus/testset2014.BPE.$SL   
ref=corpus/testset2014.$TL     

nvidia-smi 

evaluation=evaluation

#mkdir $evaluation -p

# Decoding (translation)
cat $tes | $marian/build/marian-decoder -c $prefix.best-translation.npz.decoder.yml -b 12 -n --mini-batch 10 --maxi-batch 100 | sed 's/\@\@ //g' > $evaluation/test.output.postprocessed_2014

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/test.output.postprocessed_2014 > $evaluation/results_2014



tes=corpus/testset2015.BPE.$SL   
ref=corpus/testset2015.$TL     

#decoding (Translation)
cat $tes | $marian/build/marian-decoder -c $prefix.best-translation.npz.decoder.yml -b 12 -n --mini-batch 10 --maxi-batch 100 | sed 's/\@\@ //g' > $evaluation/test.output.postprocessed_2015

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/test.output.postprocessed_2015 > $evaluation/results_2015

