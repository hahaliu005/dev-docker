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

# install openresty
RUN yum -y install pcre-devel freetype-devel libtool mercurial pkgconfig zlib-devel openssl-devel

RUN wget https://openresty.org/download/openresty-1.9.7.4.tar.gz

RUN tar zxvf openresty-1.9.7.4.tar.gz

RUN cd openresty-1.9.7.4 \
    && ./configure \
    && gmake -j $(nproc) \
    && gmake install

# every dockerfile should have this two config file copy
COPY ./entrypoint.sh /entrypoint.sh
COPY ./etc /etc
# for nginx
COPY ./conf /usr/local/openresty/nginx/conf

WORKDIR /var/www

EXPOSE 80

CMD ["/entrypoint.sh"]
