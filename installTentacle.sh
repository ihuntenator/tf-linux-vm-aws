#!/bin/bash
serverUrl="https://ihuntenator.octopus.app"
serverCommsPort="10933"
apiKey="API-SFC3GRXDKOLN8P2B31ASFFASOO8"
name=$HOSTNAME
space="Default"
configFilePath="/etc/octopus/default/tentacle-default.config"
applicationPath="/home/Octopus/Applications/"

curl https://rpm.octopus.com/tentacle.repo -o /etc/yum.repos.d/tentacle.repo
yum install tentacle -y

sudo /opt/octopus/tentacle/Tentacle create-instance --config "$configFilePath" --instance "$name"
sudo /opt/octopus/tentacle/Tentacle new-certificate --if-blank
sudo /opt/octopus/tentacle/Tentacle configure --noListen True --reset-trust --app "$applicationPath"
echo "Registering the worker $name with server $serverUrl"
sudo /opt/octopus/tentacle/Tentacle register-worker --server "$serverUrl" --apiKey "$apiKey" --name "$name"  --comms-style "TentacleActive" --server-comms-port $serverCommsPort --space "$space" --workerpool=Default
sudo /opt/octopus/tentacle/Tentacle service --install --start
