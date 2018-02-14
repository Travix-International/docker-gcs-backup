#!/bin/bash

GCSAuthFile="/root/.config/gcloud/application_default_credentials.json"
GCSBucket="$Store_Bucket"

if [ -e "$GCSAuthFile" ]
then
  # mount google storage
  mkdir /mnt/gcs-store
#  mount -t gcsfuse "$GCSBucket" /mnt/gcs-store
#  setenforce 0
#  sed -i s@.*user_allow_other@user_allow_other@g /etc/fuse.conf
  mount -t gcsfuse "$GCSBucket" /mnt/gcs-store -o dir_mode=777,file_mode=666,allow_other,user
  smbd -F -S
#else
#  # create auth file
#  /opt/google-cloud-sdk/bin/gcloud auth login
fi

# last line!
#/bin/bash
