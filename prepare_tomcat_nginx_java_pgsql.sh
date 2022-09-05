sudo su
yum list installed
yum update

#install java
java -version
yum install java-1.8.0

# find the extras list
amazon-linux-extras list

# install tomcat
amazon-linux-extras install tomcat8.5 

# check if installed
yum list installed | grep tomcat

# kick start
systemctl start tomcat
systemctl start tomcat.service

# to display the process id(PID) of every process using the specified files
fuser -v -n tcp 8080

# to list out all the network (socket) connections on a system
netstat -na | grep 8080

# Set Auto Start for Tomcat Service
chkconfig --list tomcat
chkconfig tomcat on

# Install Nginx
amazon-linux-extras install nginx1

# Configurations # see the different conf files for different scenarios
vi /etc/nginx/conf.d/behestee.com.conf

# vi commands: 
# :w  Save the file but keep it open
# :q  Quit without saving
# :wq  Save the file and quit
# :x  Save the file and quit

# kickstart nginx
systemctl start nginx

# tomcat web root keep the .war file here
cd /usr/share/tomcat/webapps/ROOT
# keep one index.jsp file to check if the tomcat works

# Postgres installtion:
yum install postgresql postgresql-server
postgresql-setup initdb

# Start PostgreSQL
systemctl start postgresql

# Login in with postgres
sudo -u postgres psql

#Change Password
\password postgres
# your_password 2 times

# Quit
\q

#3 Enable Remote Access
vi /var/lib/pgsql/data/pg_hba.conf

# Add My IP to trust IP

host 	all 			all 			yourip/32               trust
host    all             all             127.0.0.1/32            md5


# Allow from outside, or anywhere
vi /var/lib/pgsql/data/postgresql.conf

# Change
#listen_addresses = 'localhost'
# To
listen_addresses = '*'

#Auto Start PostgreSQL
chkconfig --list postgresql
chkconfig postgresql on

#Add swap to EC2
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048
sudo /sbin/mkswap /var/swap.1
sudo chmod 600 /var/swap.1
sudo /sbin/swapon /var/swap.1

#Auto mount Swap
#To enable it by default after reboot, add this line to /etc/fstab:
sudo vi /etc/fstab
/var/swap.1  swap        swap    defaults        0   0

# To check status of all
systemctl status nginx.service
systemctl status postgresql.service
systemctl status tomcat.service



# Additionals:

# install git
sudo yum install git

# Installing Japanese fonts
sudo yum install ipa-gothic-fonts.noarch
# Font cache clearing
fc-cache -f -v