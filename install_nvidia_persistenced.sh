sudo cp -f ./service/nvidia-persistenced.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable nvidia-persistenced
sudo systemctl restart nvidia-persistenced
sudo systemctl status nvidia-persistenced
ps aux | grep nvidia-persistenced
