# Webserver container with CGI python script
# Using RHEL 7 base image and Apache Web server
# Version 1

# Pull the rhel image from the local repository
#FROM centos7
FROM amazonlinux
USER root

MAINTAINER Wilfred Moyo

# Update image
RUN yum update -y
RUN yum install httpd procps-ng MySQL-pythonexpect python python-devel python-pip ruby rubygems java -y

# Add configuration
ARG UNAME=sanportal
ARG UID=900
ARG GID=900
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
RUN mkdir -p /run/httpd
RUN touch /run/httpd/httpd.pid
RUN chown sanportal:sanportal /run/httpd/httpd.pid
#COPY /Users/wilfredm/automation/puff/chef-repo/cookbooks/sanportal/files/default/cgi-bin /var/www/cgi-bin
#COPY /Users/wilfredm/automation/puff/chef-repo/cookbooks/sanportal/files/default/images /var/www/images
#COPY /Users/wilfredm/automation/puff/chef-repo/cookbooks/sanportal/files/default/HiCommand /opt/HiCommand
#RUN chown sanportal:root /usr/sbin/suexec
#RUN chmod 4755 /usr/sbin/suexec
#RUN echo "SuexecUserGroup sanportal sanportal" >> /etc/httpd/conf/httpd.conf
RUN mkdir -p /etc/httpd/conf/
RUN echo "Timeout 600" >> /etc/httpd/conf/httpd.conf
RUN echo "User sanportal" >> /etc/httpd/conf/httpd.conf
RUN echo "Group sanportal" >> /etc/httpd/conf/httpd.conf
#RUN pip install awscli --upgrade --index-url=http://pypi.standardbank.co.za/chop/pypi/+simple --trusted-host=pypi.standardbank.co.za -U pip
#RUN chmod u+x /opt/HiCommand/HiCommandCLI/hishoot.sh
#RUN chmod u+x /opt/HiCommand/HiCommandCLI/HiCommandCLI
#RUN chmod u+x /var/www/cgi-bin/san_irc_rag/scripts/*.sh
#RUN chmod u+x /var/www/cgi-bin/san_irc_rag/scripts/*.exp
#RUN chown -R sanportal:sanportal /var/www/cgi-bin/

EXPOSE 80

# Start the service
#USER $UNAME
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
