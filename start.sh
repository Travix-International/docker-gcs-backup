#!/bin/bash

GCSAuthFile="/root/.config/gcloud/application_default_credentials.json"
GCSBucket="$Store_Bucket"

if [ -e "$GCSAuthFile" ]
then
  mkdir /mnt/gcs-store
  mount -t gcsfuse "$GCSBucket" /mnt/gcs-store -o dir_mode=777,file_mode=666,allow_other,user
  exec smbd -FS < /dev/null
fi

