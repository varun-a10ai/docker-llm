IMAGE=docker_pytorch
docker build . -t $IMAGE

docker run \
--volume /var/lib/nvidia/lib64:/usr/local/nvidia/lib64 \
--volume /var/lib/nvidia/bin:/usr/local/nvidia/bin \
--device=/dev/nvidia{0,1,2,3,4,5,6,7} \
--device={/dev/nvidia-uvm,/dev/nvidiactl} \
$IMAGE \
nvidia-smi
