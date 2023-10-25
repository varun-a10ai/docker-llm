cat constant.com.sources.list > /etc/apt/sources.list

# DO THIS INSTEAD
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

#apt-get update && sudo apt-get install -y nvidia-container-toolkit-base
#nvidia-ctk --version
#nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
#grep "  name:" /etc/cdi/nvidia.yaml

# curl https://get.docker.com | sh \
#   && sudo systemctl --now enable docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo systemctl --now enable docker
sudo chmod o+rw /var/run/docker.sock


distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list


#sudo apt-get update
#sudo apt-get install -y nvidia-container-toolkit

sudo apt install nvidia-docker2
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

echo 'testing it'
sudo docker run --rm --runtime=nvidia --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi


# sudo apt update
# sudo apt install docker.io
# 
# # make docker able to access cuda
# curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
# echo deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/stable/ubuntu22.04/$(ARCH) / > /etc/apt/sources.list.d/nvidia-container-toolkit.list
# sudo apt update
# sudo apt install nvidia-docker2

docker run --rm --gpus all nvidia/cuda:12.0.0-base-ubuntu20.04 nvidia-smi


### NOTES
# setup persistence mode so nvidia-smi is fast
sudo nvidia-smi -pm 1

# there is something about cgroups and this file?
# /etc/nvidia-container-runtime/config.toml


# Also need to figure out how to run docker rootless
