#Define Java Version
JAVA_VERSION=6
#Define Play Version
PLAY_VERSION=2.1.3
#Define log file
LOG_FILE="provision.log"

#F500 Ubuntu 10.04 comes with Dutch servers configured, switch to main
echo "Configuring Ubuntu APT repositories"
sed -i 's:nl.::' /etc/apt/sources.list

# Configure apt for java
# http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html
apt-get update &>> $LOG_FILE
apt-get install -y python-software-properties &>> $LOG_FILE
add-apt-repository ppa:webupd8team/java &>> $LOG_FILE
add-apt-repository ppa:git-core/ppa &>> $LOG_FILE
echo oracle-java$JAVA_VERSION-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# Update apt sources
apt-get update &>> $LOG_FILE

# Install stuff available through apt-get
echo "Installing Ubuntu system packages"
apt-get install -y unzip wget git vim oracle-java$JAVA_VERSION-installer oracle-java$JAVA_VERSION-set-default &>> $LOG_FILE


# Install play manually
echo "Installing Play Framework"
cd /opt
wget --quiet http://downloads.typesafe.com/play/$PLAY_VERSION/play-$PLAY_VERSION.zip
unzip -qq play-$PLAY_VERSION.zip
chmod +x /opt/play-$PLAY_VERSION/play
chmod +x /opt/play-$PLAY_VERSION/framework/build
chmod -R a+rw /opt/play-$PLAY_VERSION/*

echo 'PATH=${PATH}:/opt/play-'$PLAY_VERSION >> /etc/profile
