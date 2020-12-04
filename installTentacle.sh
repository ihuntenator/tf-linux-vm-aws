#!/bin/bash

serverUrl="https://ihuntenator.octopus.app"
serverCommsPort="10933"
apiKey="API-SFC3GRXDKOLN8P2B31ASFFASOO8"
thumbprint="CAAD5651C5B773478D18B0B98AEE8F16A23B2794"
name=$HOSTNAME
space="Default"
environment="development"
role="test"
configFilePath="/etc/octopus/default/tentacle-default.config"
applicationPath="/home/Octopus/Applications/"

curl https://rpm.octopus.com/tentacle.repo -o /etc/yum.repos.d/tentacle.repo
yum install tentacle -y

sudo /opt/octopus/tentacle/Tentacle create-instance --config "$configFilePath"
sudo /opt/octopus/tentacle/Tentacle new-certificate --if-blank
sudo /opt/octopus/tentacle/Tentacle configure --noListen True --reset-trust --app "$applicationPath"
sudo /opt/octopus/tentacle/Tentacle configure --trust $thumbprint
# echo "Registering the worker $name with server $serverUrl"
# sudo /opt/octopus/tentacle/Tentacle register-with --server "$serverUrl" --apiKey "$apiKey" --name "$name"  --env "$environment"  --comms-style "TentacleActive" --server-comms-port $serverCommsPort --space "$space" --role "$role"
sudo /opt/octopus/tentacle/Tentacle service --install --start
