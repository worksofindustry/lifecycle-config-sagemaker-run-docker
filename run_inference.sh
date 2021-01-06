#!/bin/bash
#Configure to your specific ECR or DockerHub Login as well as your procesing container
aws ecr get-login-password --region <your region> | docker login --username AWS --password-stdin <your_credentials>
docker pull <your_container>
#In this example my container is equipted to use SageMaker gpus, also mounting S3 buckets directly to container using s3fs to keep storage requirements minimal
docker run --cap-add SYS_ADMIN --device /dev/fuse --gpus all --name $1 <your_container>
