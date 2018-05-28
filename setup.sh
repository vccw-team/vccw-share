#!/usr/bin/env bash

set -ex

sudo apt install unzip

curl https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip
unzip -u ngrok.zip
sudo mv ngrok /usr/local/bin/

rm -fr $HOME/proxy
git clone https://github.com/vccw-team/vccw-share.git $HOME/proxy
cd $HOME/proxy && npm install

mkdir -p $HOME/.ngrok2
touch $HOME/.ngrok2/ngrok.yml
cat << EOS > $HOME/.ngrok2/ngrok.yml
region: us
tunnels:
  wp:
    proto: http
    addr: 5000
EOS

npm install pm2 -g

cat << EOS > $HOME/vccw-share
#!/usr/bin/env bash

pm2 start $HOME/proxy/index.js
ngrok start wp
EOS

chmod 755 $HOME/vccw-share
sudo mv $HOME/vccw-share /usr/local/bin
