#!/bin/sh

# Create the namespace
kubectl delete namespace logging

# Install Gralog
################

# Create Elastic Search
kubectl delete -f es-deploy.yaml

# Create Mongo
kubectl delete -f mongo-deploy.yaml

# Create Graylog 
kubectl delete -f  graylog-deploy.yaml

# Create  cronjob for send sample message to Graylog ( Enable as needed)
# kubectl delete -f cronJob.yaml

# Install FluentBit
###################

# Create the base resources
kubectl delete -f fluent-bit-service-account.yaml
kubectl delete -f fluent-bit-role.yaml
kubectl delete -f fluent-bit-role-binding.yaml

# Create the config map
kubectl delete -f fluent-bit-configmap.yaml

# Create the daemon set
kubectl delete -f fluent-bit-daemon-set.yaml

# Deploy sample Nginx Webserver for Test the message Forward on Graylog
kubectl delete -f nginx.yaml
