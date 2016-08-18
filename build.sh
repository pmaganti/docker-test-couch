# Enables job control
set -m

# Enables error propagation 
set -e

/entrypoint.sh ubuntu &

echo "------------------- Provisioning Started -------------------"

echo "------------------- Updating packages -------------------"
sudo apt-get update

echo "------------------- Installing base packages - [ python-software-properties, curl, unzip, git, nginx ] -------------------"
sudo apt-get install -y python-software-properties
sudo apt-get install -y curl
sudo apt-get install -y unzip
sudo apt-get install -y git
sudo apt-get install -y nginx

echo "------------------- Installing Nnode initode latest 4.x stable version -------------------"
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

echo "------------------- Installing couchbase-release-1.0-1 64bit package -------------------"
wget http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-1-amd64.deb && sudo dpkg -i couchbase-release-1.0-1-amd64.deb
sudo apt-get update
sudo apt-get install couchbase-server

echo "------------------- Installing couchbase-sync-gateway-community_1.2.1-4_x86 64bit package -------------------"
wget http://packages.couchbase.com/releases/couchbase-sync-gateway/1.2.1/couchbase-sync-gateway-community_1.2.1-4_x86_64.deb
sudo dpkg -i couchbase-sync-gateway-community_1.2.1-4_x86_64.deb

/opt/couchbase/bin/couchbase-cli cluster-init --cluster-username=Admin --cluster-password=secret --cluster-port=8091 --services=data,index,query,fts --cluster-ramsize=500 --cluster-index-ramsize=500 --cluster-fts-ramsize=500 --index-storage-setting=default