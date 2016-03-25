# My Google Cloud Storage Server

## Build

Build your image.
Example:
```
docker build -t sandras/mygcs .
```

## Run

You need run with privilege parameter, because the container mount the google's cloud storage with fuse.

```
docker run -tid --name=gcs-srv --privileged --net=host -e "Store_Bucket=croc-backup" -v /srv/gcs-srv/config:/root/.config/gcloud/ sandras/mygcs /opt/start.sh
```

  - Store_Bucket variable contains your bucket name

The GCSFuse and docker system can't share Fuse mounted drive with docker's volume. So the container can't share the content of the GCS storage between the host and the container with volume feature.

## Config

If you haven't a google cloud storage auth file, you have to create one. You have to run this command:
```
docker exec -ti gcs-srv /opt/google-cloud-sdk/bin/gcloud auth login
```

Copy the long URL and paste into a browser on your PC. Login into google with your account and follow the wizard. Copy the KEY and paste to 'verification key'.

Restart the container.
```
docker stop gcs-srv
docker start gcs-srv
```

That's it.  
You can use your bucket's file now on the host's /srv/gcs-srv/data folder.

## Usage

The container runs a samba service too.
Login:
  - user: gcloud
  - password: Ggl357
  - share: gcs-store
You can backup your Windows or other Samba-compatible machine into this share.
All uploaded file upload the google cloud storage immediately.

