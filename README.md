# VoxAssist Operating Enviroment

Copyright 2014 Usmar A. Padow (amigojapan) usmpadow@gmail.com

please bare with the voice for first video, the voice improves after in the second video:

<a href="https://youtu.be/KLuySOD2Zr0?si=w7zgzn1QdgQ2vXsw" target="_blank"><img src="https://raw.githubusercontent.com/amigojapan/BlindOS/master/youtube%20play%20button.jpg" 
alt="video demo of ejspeak" width="100" height="80" border="10" /></a>



on linux:(developed and tested on Linux mint and debian 12 bookworm)

on mint preciede every apt-get with sudo

on debian open a termianl and do

su

enter your root password you set during debian installation

apt-get update

apt-get install git

apt-get install flite

apt-get install lua5.3

apt-get install liblua5.3-dev

apt-get install luarocks

luarocks install luasocket

luarocks install luafilesystem

apt-get install lua-posix

curl https://ollama.ai/install.sh | sh

ollama run llama2

/bye

(on debian only) type exit

clone this repo

git clone https://github.com/amigojapan/VoxAssist

cd VoxAssist

edit tmpDir="/home/amigojapan/projects/VoxAssist/tmp" in settings.lua. it must be a full absolute path to BlindOS/tmp

pip3 install vosk

vosk-transcriber -i rec.wav -o rec.txt

./VoxAssist.lua

# Join me in irc.libera.chat in channels #VoxAssist and #BlindOE
