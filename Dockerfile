FROM centos:7
MAINTAINER "Francois Villain" <f.villain@linkbynet.com>

#ENV VAULT_VERSION 0.3.1
ENV PATH $PATH:/usr/local/bin

# install required packages
RUN yum clean all; yum -y update; yum -y install unzip wget

# get vault binary
RUN wget -q --output-document=/tmp/vault.zip https://dl.bintray.com/mitchellh/vault/vault_0.3.1_linux_amd64.zip 

# install it in /usr/local/bin
RUN unzip /tmp/vault.zip -d /usr/local/bin && rm -f /tmp/vault.zip

# create conf and data directory and add default conf file
RUN mkdir -p /etc/vault /var/lib/vault
ADD ./vault.hcl /etc/vault/vault.hcl

EXPOSE 8200
VOLUME /etc/vault
VOLUME /var/lib/vault

# finally launch vault server
ENTRYPOINT vault server -config=/etc/vault/vault.hcl
