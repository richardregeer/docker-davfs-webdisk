# docker-davfs-webdisk
Use docker to mount a davfs webdisk

docker run 
--rm \
-e WEBDRIVE_USER=<your-login> \
-e WEBDRIVE_PASSWORD=<your-password> \
-e WEBDRIVE_URL=<https://cloud-webdav-url> \
--privileged \
--device fuse \ 