
export DRIVER_BRANCH=535 
sudo ubuntu-drivers list --gpgpu

sudo apt --purge remove '*nvidia*525*'
sudo apt --purge remove '*nvidia*535*'

sudo apt install -y nvidia-fabricmanager-${DRIVER_BRANCH} libnvidia-nscq-${DRIVER_BRANCH}
sudo apt install nvidia-utils-535-server
sudo apt install nvidia-driver-535-server

sudo systemctl start nvidia-fabricmanager 
sudo systemctl status nvidia-fabricmanager

sudo bash install_nvidia_persistenced.sh

# check status of fabric
nvidia-smi -q -i 0 | grep -i -A 2 Fabric

sudo apt-mark hold nvidia-utils-535-server
sudo apt-mark hold nvidia-driver-535-server
sudo apt-mark hold nvidia-fabricmanager-dev-535

