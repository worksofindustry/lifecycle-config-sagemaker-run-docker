#!/bin/bash
#$1&$2 are set by parent calling script
CONTAINER_NAME=$1
NOTEBOOK_INSTANCE_NAME=$2

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER_NAME 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "WARNING - $CONTAINER_NAME does not exist. Failed to create or needs more time to create."
  exit 3
fi

if [ "$RUNNING" == "false" ]; then
  echo "$CONTAINER_NAME is no longer running. Shutting down $2"
  sleep 5
  # import, use AWS CLI, not shell, to stop your instance to avoid any other charges
  aws sagemaker stop-notebook-instance --notebook-instance-name $2
  exit 2
fi
