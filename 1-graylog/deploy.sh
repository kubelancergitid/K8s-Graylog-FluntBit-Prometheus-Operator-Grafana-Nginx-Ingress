#!/bin/sh

# Create the namespace
kubectl create namespace logging

# Install Gralog
################

# Create Elastic Search
kubectl create -f es-deploy.yaml

# Create Mongo
kubectl create -f mongo-deploy.yaml

# Create Graylog 
kubectl create -f  graylog-deploy.yaml

# Create  cronjob for send sample message to Graylog ( Enable as needed)
# kubectl create -f cronJob.yaml

# Install FluentBit
###################

# Create the base resources
kubectl create -f fluent-bit-service-account.yaml
kubectl create -f fluent-bit-role.yaml
kubectl create -f fluent-bit-role-binding.yaml

# Create the config map
kubectl create -f fluent-bit-configmap.yaml

# Create the daemon set
kubectl create -f fluent-bit-daemon-set.yaml

# Deploy sample Nginx Webserver for Test the message Forward on Graylog
kubectl create -f nginx.yaml
