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

# install php
RUN yum -y install --enablerepo=remi --enablerepo=remi-php70 php php-devel php-pdo php-mysqlnd php-fpm php-opcache php-cli php-gd php-mcrypt php-mbstring php-xml

# install node & npm
RUN wget https://nodejs.org/dist/v6.4.0/node-v6.4.0.tar.gz
RUN tar zxvf node-v6.4.0.tar.gz
RUN cd node-v6.4.0 && \
    ./configure && \
    make -j $(nproc) && \
    make install

# install Gulp
RUN /usr/local/bin/npm install -g gulp-cli

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# for none root user
RUN sed -i -e 's/Defaults    requiretty.*/ #Defaults    requiretty/g' /etc/sudoers
COPY ./.docker_user_id /.docker_user_id
COPY ./.docker_group_id /.docker_group_id
RUN groupadd --gid `cat /.docker_group_id` docker-user
RUN useradd --uid `cat /.docker_user_id` --gid `cat /.docker_group_id` --password '' docker-user
RUN echo "%docker-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# every dockerfile should have this two config file copy
COPY ./entrypoint.sh /entrypoint.sh
COPY ./etc /etc
# for nginx
COPY ./conf /usr/local/openresty/nginx/conf

# finally set default as none root and set workdir
USER docker-user
WORKDIR /var/www

EXPOSE 80

CMD ["/entrypoint.sh"]
