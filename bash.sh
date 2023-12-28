#!/bin/bash

apt-get install monit -y -q
sed -i "s/^.*set daemon 120.*/set daemon 60/" /etc/monit/monitrc
sed -i "s/^#.*set httpd port 2812 and.*/set httpd port 2812 and/" /etc/monit/monitrc
sed -i "s/^#.*use address localhost.*/use address localhost/" /etc/monit/monitrc
sed -i "s/^#.*allow localhost.*/allow localhost/" /etc/monit/monitrc
sed -i "s/^#.*allow admin:monit.*/allow admin:monit/" /etc/monit/monitrc
sed -i "s/^.*include \/etc\/monit\/conf-enabled\/\*/#include \/etc\/monit\/conf-enabled\/\*/" /etc/monit/monitrc
echo -e 'check process nginx with pidfile /var/run/nginx.pid\nstart program = "/usr/sbin/service nginx start"\nstop program = "/usr/sbin/service nginx stop"' > /etc/monit/conf.d/nginx.conf
monit reload
monit start all
monit monitor all
