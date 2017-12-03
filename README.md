# docker-davfs-webdisk
This is a docker container to keep a webdav folder in sync using unison.
I created this container to keep an offline copy of my webdav folder of [Stack](https://www.transip.nl/stack/) on my Ubuntu home server.
It works both ways. If online a file is added it will be downloaded and if a file is added to the offline folder it will be uploaded automatically.

## How to use the container
To be able to use the davfs we need a fuse device. Make sure the container is started with the `privileged` flag and share the `/dev/fuse` device.
A shared host volume can be used for the offline webdav folder. By default all files that are created in the share are for user root. This can be changed to give the correct UID to the `SYNC_USERID` variable.

```bash
docker run \
--init \
-e WEBDRIVE_USER=<username> \
-e WEBDRIVE_PASSWORD=<password> \
-e WEBDRIVE_URL=https://foo/bar/webdav/ \
-e SYNC_USERID=1001 \
-v <host/path/to/offline/folder>:/mnt/webdrive \
-d \
--privileged \
--device /dev/fuse \
richardregeer/davfs-webdisk
```

- if no `SYNC_USERID` is given `0` will be used as default user for the created files in the shared volume.

The configuration of unison can be changed by override it using `-v <host/path/to/unision/profile.prf>:/root/.unison/default.prf`  
For more information about unison profiles see the [manual](https://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-manual.html#profileegs).