#!/bin/bash

myDate=`date '+%Y%m%d'`
filename="BPAWebsite_${myDate}"

if [ -d public ]
then
  cp -rp public deploy/${filename}
  cd deploy
  zip -r ${filename}.zip ${filename}
  rm -rf ${filename}
  echo "File is ready: deploy/${filename}.zip"
fi
exit 0
