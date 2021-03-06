#!/usr/bin/env bash

set -ex

sudo apt update
sudo apt install unzip

curl https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip
unzip -u ngrok.zip
sudo mv ngrok /usr/local/bin/

rm -fr $HOME/vccw-proxy
git clone https://github.com/vccw-team/vccw-share.git $HOME/vccw-proxy
cd $HOME/vccw-proxy && npm install

ADDR=$(ifconfig eth1 | awk '/inet / {print $2}' | awk -F: '{print $2}')

mkdir -p $HOME/.ngrok2
touch $HOME/.ngrok2/ngrok.yml

cat << EOS > $HOME/.ngrok2/ngrok.yml
region: us
web_addr: ${ADDR}:4040
tunnels:
  wp:
    proto: http
    addr: 5000
EOS

npm install pm2 -g

cat << EOS > $HOME/vccw-share
#!/usr/bin/env bash

pm2 kill
pm2 start $HOME/vccw-proxy
ngrok start wp
EOS

chmod 755 $HOME/vccw-share
sudo mv $HOME/vccw-share /usr/local/bin
