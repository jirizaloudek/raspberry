
#install perl dependencies
wget https://launchpad.net/~jxself/+archive/perl/+build/4002599/+files/libxml-rss-parser-lite-perl_0.10-2_all.deb
sudo apt-get -f install  libsoap-lite-perl
sudo dpkg -i libxml-rss-parser-lite-perl_0.10-2_all.deb 
sudo apt-get  install libxml-feedpp-perl
 
# install git
sudo apt-get  install git
git clone https://github.com/andreafabrizi/Dropbox-Uploader.git 

#run dropbox and configure App sreality tokens
./dropbox_uploader.sh

#install crontab jobs
24 * * * * /home/pi/sreality/rss_parser.pl > /tmp/sreality.rss
25 * * * * /home/pi/Dropbox-Uploader/dropbox_uploader.sh upload /tmp/sreality.rss /Public/feed.rss

