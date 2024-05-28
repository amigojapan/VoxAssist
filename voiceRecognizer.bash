#!/bin/bash
#convert voice to text
#whisper rec.ogg --model tiny --language English --task translate --output_format txt -f txt &> /dev/null
#vosk-transcriber --model-name vosk-model-en-us-0.42-gigaspeech -i rec.wav -o rec.txt &> /dev/null
vosk-transcriber --model-name vosk-model-en-us-0.22-lgraph -i rec.wav -o rec.txt &> /dev/null
#try tomorrow vosk-transcriber --model-name vosk-model-en-us-0.22-lgraph --input rec.wav 

#vosk-transcriber --model-name vosk-model-en-us-librispeech-0.2
#generate output in text
cat rec.txt
