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
FOLDER_USER=${SYNC_USERID:-0}

echo "$URL $USER $PASSWORD" >> /etc/davfs2/secrets

# Create user
if [ $FOLDER_USER -gt 0 ]; then
  useradd webdrive -u $FOLDER_USER -N -G users
fi

# Mount the webdaf drive 
mount -t davfs $URL /mnt/source -o uid=$FOLDER_USER,gid=users,dir_mode=755,file_mode=755

# Start the endless sync process
unison