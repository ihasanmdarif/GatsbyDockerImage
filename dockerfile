FROM ubuntu:latest

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get install git -y \
    && apt-get install openssh-client -y \
    && apt-get install rsync -y

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 15.11.0

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

#install yarn
RUN npm install -g yarn

RUN npm install -g gatsby-cli

# confirm installation
RUN node -v
RUN npm -v