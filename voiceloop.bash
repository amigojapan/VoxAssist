#!/bin/bash
touch rec.ogg
while true
do
    # loop infinitely
    echo "say something now:"
    #(rec is conteined in package sox) record until start voice, then end when end talking with 1% mirofopne noise tolerance
    rec rec.wav rate 64k silence 1 0.0 1% 1 3.0 1%  
    echo "processing..."
    #convert voice to text
    #whisper rec.ogg --model tiny --language English --task translate --output_format txt -f txt &> /dev/null
    #vosk-transcriber --model-name vosk-model-en-us-librispeech-0.2 -i rec.wav -o rec.txt &> /dev/null
    vosk-transcriber --model-name vosk-model-en-us-0.42-gigaspeech -i rec.wav -o rec.txt &> /dev/null
    echo "output:"
    cat rec.txt
    read -p "Press any key to resume ..."
done
