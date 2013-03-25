
#set local time
cd /etc
sudo rm localtime
sudo ln -s /usr/share/zoneinfo/Europe/Paris localtime
date