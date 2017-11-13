#!/bin/bash

#Check veriables or set defaults
if [ -z ${WEBDRIVE_USER} ]; then
  echo "Webdrive user is not set"
fi

if [ -z ${WEBDRIVE_PASSWORD} ]; then
  echo "Webdrive password is not set"
fi

if [ -z ${WEBDRIVE_URL} ]; then
  echo "Webdrive url is not set"
fi

USER=${WEBDRIVE_USER}
PASSWORD=${WEBDRIVE_PASSWORD}
URL=${WEBDRIVE_URL}
SOURCE_FOLDER=${WEBDRIVE_SYNC_SOURCE:-/mnt/source}
DESTINATION_FOLDER=${WEBDRIVE_SYNC_DESTINATION:-/mnt/webdrive}
POLLTIME=${WEBDRIVE_POLLTIME:-10}

echo "$URL $USER $PASSWORD" >> /etc/davfs2/secrets

# Create folders if not exist
mkdir -p $SOURCE_FOLDER
mkdir -p $DESTINATION_FOLDER

# Mount the webdaf drive               
mount.davfs $URL $SOURCE_FOLDER

# Start the endless sync process
while true; do unison $SOURCE_FOLDER $DESTINATION_FOLDER -auto -batch; sleep $POLLTIME; done