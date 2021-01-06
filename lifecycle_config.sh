#!/bin/bash
set -e
#What you would like to name your container
CONTAINER_NAME='my_container'
#The name of the Sagmaker Notebook Instance
NOTEBOOK_INSTANCE_NAME='my_Notebook'
#Fetch Scripts
wget -O /home/ec2-user/SageMaker/monitor_container.sh https://raw.githubusercontent.com/worksofindustry/lifecycle-config-sagemaker-run-docker/main/monitor_container.sh

/home/ec2-user/SageMaker/run_inference.sh $CONTAINER_NAME &>/dev/null &

#monitor docker container if not running shutdown the instance, for larger container you many need to increase from 5 minutes
(crontab -l 2>/dev/null; echo "*/5 * * * * /home/ec2-user/SageMaker/monitor_container.sh $CONTAINER_NAME $NOTEBOOK_INSTANCE_NAME") | crontab -
