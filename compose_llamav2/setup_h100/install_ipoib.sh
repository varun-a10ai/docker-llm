sudo cp -f ./service/ipoib.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl restart ipoib
sudo systemctl enable ipoib

