#!/bin/bash

docker build -t lora-network-server .
docker tag lora-network-server 10.214.1.197:5000/lora-network-server
docker push 10.214.1.197:5000/lora-network-server
