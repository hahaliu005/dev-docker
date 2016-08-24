FROM centos:centos7.2.1511

RUN yum -y update

# add yum repository
RUN yum -y install epel-release
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

RUN yum -y update

# install development tools
RUN yum -y groupinstall "Development Tools"

# install base tools
RUN yum -y install tar vim wget net-tools 

# install supervisor
RUN yum -y install supervisor

# install crontab
RUN yum -y install cronie

# install sudo
RUN yum -y install sudo

# set work space to this dir
WORKDIR /workspace

## Every dockerfile need the schedule above, And difference is begin below

# install redis
RUN wget http://download.redis.io/releases/redis-3.2.3.tar.gz
RUN tar zxvf redis-3.2.3.tar.gz
RUN cd redis-3.2.3 && \
    make && \
    make install

# every dockerfile should have this two config file copy
COPY ./entrypoint.sh /entrypoint.sh
COPY ./etc /etc

EXPOSE 6379

CMD ["/entrypoint.sh"]
