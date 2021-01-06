# Lifecycle Configuration for Running Docker Jobs In SageMaker

A template for using SageMaker as a processing machine by using Docker containers. This is not meant for production, as there are better ways for model deployment, but to be used a proof of concept. For example say you had some files or images that needed to be processed in S3. What could be done is setup a lambda trigger to start your SageMaker notebook instance once new files are uploaded to S3. As SageMaker starts up, the lifecycle configuration will start your docker processing containers for you, and stop the SageMaker instance after the containers are done processing. 

### monitor_container.sh
Monitors the status of your Docker container and shutdowns down the notebook once it exits. This script is scheduled in cron. Args: CONTAINER_NAME, NOTEBOOK_INSTANCE_NAME
```
ex. $ ./monitor_container.sh hello-world:latest my-sagemaker-notebook 
```
### run_inference.sh
Will log into your container registry of choice, pull your image, and run your container. Make sure to configure for your specific container repository and container runtime options. Args: CONTAINER_NAME
```
ex. $ ./run_inference.sh my_container
```
